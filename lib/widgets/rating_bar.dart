import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({super.key, required this.rating, this.size, this.padding})
      : assert(rating <= 5);
  final int rating;
  final double? size;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rating; i++)
          Padding(
            padding: padding ?? EdgeInsets.only(right: 5.0.w),
            child: SvgPicture.asset(
              'assets/icons/ic_star_filled.svg',
              width: size ?? 15.r,
              height: size ?? 15.r,
            ),
          ),
        for (int i = 0; i < 5 - rating; i++)
          Padding(
            padding: padding ?? EdgeInsets.only(right: 5.0.w),
            child: SvgPicture.asset(
              'assets/icons/ic_star.svg',
              width: size ?? 15.r,
              height: size ?? 15.r,
            ),
          ),
      ],
    );
  }
}
