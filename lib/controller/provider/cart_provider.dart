import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/model/secure_storage_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, String>> _items = [];
  List<Map<String, String>> get items => _items;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  final List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> addToCart(
      Map<String, String> productData, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userId = await SecureStorage.readId("id");

    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    await userRef.update({
      "cart": FieldValue.arrayUnion([productData]),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("item added to cart")),
    );
    notifyListeners();
  }

  Future<void> removeFromCart(
      Map<String, String> productData, List<Product> prods) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userId = await SecureStorage.readId("id");

    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    await userRef.update({
      "cart": FieldValue.arrayRemove([productData]),
    });
    // fetchCart(prods);
    notifyListeners();
  }

  Future<void> fetchCart(List<Product> prods) async {
    _isLoading = true;
    notifyListeners();
    final userId = await SecureStorage.readId("id");
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        List<dynamic> cartData = userDoc.get('cart');
        _items =
            cartData.map((item) => Map<String, String>.from(item)).toList();
        notifyListeners();
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching cart: $e');
    }
    getProductsFromFavs(prods);
    getTotalPrice();

    notifyListeners();
  }

  Future<void> getProductsFromFavs(List<Product> prods) async {
    _products.clear();
    for (var i in _items) {
      _products.addAll(prods.where((product) => product.id == i["id"]));
    }
    // getTotalPrice();
    notifyListeners();
  }

  Future<void> changeQuantity(String productId, String color, int quantity,
      String size, List<Product> prods) async {
    List<Map<String, String>> editedItems = [];
    int index = _items.indexWhere((e) =>
        e["id"] == productId && e["color"] == color && e["size"] == size);

    _items.removeAt(index);
    _items.insert(index, {
      "color": color,
      "id": productId,
      "quantity": quantity.toString(),
      "size": size,
    });

    editedItems;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userId = await SecureStorage.readId("id");

    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await userRef.set({
      "cart": _items.toSet().toList(),
    });

    getTotalPrice();
    notifyListeners();
  }

  void getTotalPrice() {
    _totalPrice = 0;

    for (var item in products) {
      Map<String, String> cartItem =
          _items.firstWhere((e) => e["id"] == item.id);
      double? price = item.price * int.parse(cartItem["quantity"]!);

      _totalPrice += price;
    }
    notifyListeners();
  }
}
