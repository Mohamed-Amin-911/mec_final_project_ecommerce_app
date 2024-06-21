import 'package:ecommerce_app/constants/image_Assets.dart';
import 'package:ecommerce_app/constants/text_style.dart';
import 'package:ecommerce_app/controller/provider/upload_products_provider.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/constants/colors.dart';

class FashionSaleWidget extends StatefulWidget {
  const FashionSaleWidget({
    super.key,
  });

  @override
  State<FashionSaleWidget> createState() => _FashionSaleWidgetState();
}

class _FashionSaleWidgetState extends State<FashionSaleWidget> {
  final UploadProductProvider productProvider = UploadProductProvider();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          KImageAssets.main,
          fit: BoxFit.fitWidth,
          width: 376.w,
          height: 536.h,
        ),
        Positioned(
          left: 15.w,
          top: 344.h,
          child: Text(
            "Fashion\nsale",
            style: appStyle(
                    fw: FontWeight.w900, size: 48.sp, color: kColor.whiteColor)
                .copyWith(height: 1),
          ),
        ),
        Positioned(
            left: 10.w,
            top: 448.h,
            child: SizedBox(
              width: 160.w,
              height: 36.h,
              child: ElevatedButton(
                onPressed: () async {
                  await productProvider.uploadProducts(products);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColor.redColor, elevation: 0),
                child: Text(
                  "Check",
                  style: appStyle(
                      fw: FontWeight.w500,
                      size: 14.sp,
                      color: kColor.whiteColor),
                ),
              ),
            ))
      ],
    );
  }
}
