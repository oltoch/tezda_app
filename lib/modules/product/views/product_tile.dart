import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tezda_app/models/product_model.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/utils/extension.dart';
import 'package:tezda_app/widgets/place_holder_image.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.model,
    this.onHeartTapped,
  });

  final Product model;
  final void Function()? onHeartTapped;

  @override
  Widget build(BuildContext context) {
    final discountPrice = model.price * (model.discountPercentage / 100);
    final offer = model.price - discountPrice;
    return Card(
      elevation: 2,
      shadowColor: kPrimaryBlue,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding:
            EdgeInsets.only(left: 12.w, right: 16.w, top: 12.h, bottom: 12.0.h),
        child: Row(
          children: [
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: CachedNetworkImage(
                    imageUrl: model.thumbnail,
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const PlaceHolderImage(),
                    placeholder: (context, url) => const PlaceHolderImage(),
                  ),
                ),
              ),
            ),
            Gap(12.w),
            Expanded(
              // flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.black),
                  ),
                  Gap(6.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: offer.formatToCurrency,
                          style: TextStyle(
                              color: kPrimaryBlue,
                              fontSize: 18.sp,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: model.price.formatToCurrency,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: kTextGray,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(8.w),
            GestureDetector(
              onTap: onHeartTapped,
              child: Icon(
                model.favourite ? Icons.favorite : Icons.favorite_border,
                size: 32,
                color: model.favourite ? Colors.redAccent : kTextGray,
              ),
            ),
            Gap(20.w),
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}
