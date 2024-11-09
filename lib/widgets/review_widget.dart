import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/widgets/rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.name,
    required this.date,
    this.comment,
    this.rating = 1,
  });

  final String name;
  final DateTime date;
  final String? comment;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24.r,
          child: Image.asset(
            'assets/images/avatar_image.png',
            fit: BoxFit.cover,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5.sp,
                  color: Colors.black,
                  height: 1.2.sp,
                ),
              ),
              Text(
                DateFormat('y - MM - dd').format(date),
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Color(0xFF898A8D),
                  height: 1.2.sp,
                ),
              ),
              Gap(10.h),
              Text(
                comment ?? '',
                style: TextStyle(
                  color: kTextGray,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        Gap(10.w),
        RatingBar(rating: rating, size: 10.r),
      ],
    );
  }
}
