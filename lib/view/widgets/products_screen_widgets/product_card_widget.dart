import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/text_style.dart';
import 'package:ecommerce_app/controller/provider/favourites_provider.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/view/screens/product_screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.name,
    required this.price,
    required this.store,
    required this.product,
  });
  final String image;

  final double rating;
  final int reviews;
  final String name;
  final String store;
  final String price;
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(product: widget.product),
            ));
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            width: 164.w,
            // height: 280.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                      color: kColor.text2Color.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.outer)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    width: 162.w,
                    height: 184.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 7.h),
                //rating
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    RatingBar.builder(
                      initialRating: widget.rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 20,
                      maxRating: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rate_rounded,
                        color: kColor.ratingColor,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    Text(
                      " (${widget.reviews})",
                      style: appStyle(
                          fw: FontWeight.w500,
                          size: 15.sp,
                          color: kColor.text2Color),
                    ),
                  ],
                ),

                //store
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    Text(
                      widget.store,
                      style: appStyle(
                          fw: FontWeight.w500,
                          size: 15.sp,
                          color: kColor.text2Color),
                    ),
                  ],
                ),

                //name
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 145.w,
                      child: Text(
                        widget.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(
                                fw: FontWeight.w600,
                                size: 16.sp,
                                color: kColor.textColor)
                            .copyWith(
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                //price
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    Text(
                      "${widget.price}\$",
                      style: appStyle(
                          fw: FontWeight.w600,
                          size: 16.sp,
                          color: kColor.textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //favorite
          Positioned(
            right: 0.w,
            top: 150.h,
            child: FutureBuilder(
                future: Provider.of<FavoritesProvider>(context, listen: false)
                    .isFavorite(widget.product.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kColor.whiteColor,
                          shape: const CircleBorder(),
                          padding: REdgeInsets.all(10),
                          elevation: 4),
                      onPressed: () {
                        if (snapshot.data == true) {
                          Provider.of<FavoritesProvider>(context, listen: false)
                              .removeFavorites(widget.product.id!);
                          setState(() {});
                        } else if (snapshot.data == false) {
                          Provider.of<FavoritesProvider>(context, listen: false)
                              .addToFavorites(widget.product.id!);
                          setState(() {});
                        }
                      },
                      child: snapshot.data!
                          ? const Center(
                              child: Icon(
                                Icons.favorite_rounded,
                                color: kColor.redColor,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.favorite_border_rounded,
                                color: kColor.text2Color,
                              ),
                            ),
                    );
                  } else {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kColor.whiteColor,
                          shape: const CircleBorder(),
                          padding: REdgeInsets.all(10),
                          elevation: 4),
                      onPressed: () {},
                      child:
                          Provider.of<FavoritesProvider>(context, listen: true)
                                  .isFavourited
                              ? const Center(
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    color: kColor.whiteColor,
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.favorite_border_rounded,
                                    color: kColor.text2Color,
                                  ),
                                ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
