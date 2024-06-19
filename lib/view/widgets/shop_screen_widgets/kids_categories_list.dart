import 'package:ecommerce_app/constants/image_Assets.dart';
import 'package:ecommerce_app/view/widgets/shop_screen_widgets/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KidsCategoriesList extends StatelessWidget {
  const KidsCategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.6.h),
        child: const IntrinsicHeight(
          child: Column(
            children: [
              CategoryCardWidget(
                image: KImageAssets.womanNew,
                name: "New",
              ),
              CategoryCardWidget(
                image: KImageAssets.womanClothes,
                name: "Clothes",
              ),
              CategoryCardWidget(
                image: KImageAssets.womanShoes,
                name: "Shoes",
              ),
              CategoryCardWidget(
                image: KImageAssets.womanAccesories,
                name: "Accesories",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
