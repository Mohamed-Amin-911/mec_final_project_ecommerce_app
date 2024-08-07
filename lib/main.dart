import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/controller/provider/address_provider.dart';
import 'package:ecommerce_app/controller/provider/cart_provider.dart';
import 'package:ecommerce_app/controller/provider/credit_card_provider.dart';
import 'package:ecommerce_app/controller/provider/favourites_provider.dart';
import 'package:ecommerce_app/controller/provider/promoCode_provider.dart';
import 'package:ecommerce_app/controller/provider/retrieve_products_provider.dart';
import 'package:ecommerce_app/controller/provider/retrieve_user_info_provider.dart';
import 'package:ecommerce_app/controller/provider/review_provider.dart';
import 'package:ecommerce_app/controller/provider/upload_products_provider.dart';
import 'package:ecommerce_app/controller/provider/upload_user_provider.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/view/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UploadProductProvider()),
    ChangeNotifierProvider(create: (_) => RetrieveProductProvider()),
    ChangeNotifierProvider(create: (_) => UploadUserProvider()),
    ChangeNotifierProvider(create: (_) => FavoritesProvider()),
    ChangeNotifierProvider(create: (_) => ReviewProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => PromoCodePRovider()),
    ChangeNotifierProvider(create: (_) => AddressProvider()),
    ChangeNotifierProvider(create: (_) => CreditCardProvider()),
    ChangeNotifierProvider(create: (_) => RetrieveUserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'eCommerce app',
            theme: ThemeData(
              scaffoldBackgroundColor: kColor.whiteColor,
              chipTheme: ChipThemeData(
                  labelStyle: TextStyle(
                      color: kColor.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Metropolis",
                      fontSize: 14.sp)),
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: kColor.text2Color),
                floatingLabelStyle: TextStyle(color: kColor.text2Color),
              ),
              useMaterial3: false,
            ),
            home: const MainScreen(),
          );
        });
  }
}
