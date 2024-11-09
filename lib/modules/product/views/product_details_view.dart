import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_app/models/product_model.dart';
import 'package:tezda_app/modules/product/controllers/product_controller.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/utils/extension.dart';
import 'package:tezda_app/widgets/image_carousel.dart';
import 'package:tezda_app/widgets/rating_bar.dart';
import 'package:tezda_app/widgets/review_widget.dart';

class ProductDetailsView extends StatelessWidget {
  static const String route = '/product-details-view';

  const ProductDetailsView({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final discountPrice = product.price * (product.discountPercentage / 100);
    final offer = product.price - discountPrice;
    final pc = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          'Details',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  offset: const Offset(0, 0),
                  blurRadius: 4.0,
                  color: Colors.grey.shade700,
                ),
              ]
              // fontSize: 14.sp,
              ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: double.maxFinite,
              color: kPrimaryBlue,
              child: Center(child: ImageCarousel(imageUrls: product.images)),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.sizeOf(context).height * 0.64,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFDFF),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        product.shippingInformation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Gap(20.h),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      pc.categories
                              .firstWhereOrNull(
                                  (e) => e.slug == product.category)
                              ?.name ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    Gap(4.h),
                    RichText(
                      text: TextSpan(
                        text: offer.formatToCurrency,
                        style: TextStyle(
                            color: kPrimaryBlue,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none),
                        children: [
                          const TextSpan(
                              text: ' ',
                              style:
                                  TextStyle(decoration: TextDecoration.none)),
                          TextSpan(
                              text: product.price.formatToCurrency,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: const Color(0xFF898A8D),
                                  decoration: TextDecoration.lineThrough)),
                          const TextSpan(
                              text: '  ',
                              style:
                                  TextStyle(decoration: TextDecoration.none)),
                          TextSpan(
                              text: '${product.discountPercentage}% OFF',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  decoration: TextDecoration.none)),
                        ],
                      ),
                    ),
                    Gap(24.h),
                    Text(
                      'About Product',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: kTextGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(5.h),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: kTextGray,
                      ),
                    ),
                    Gap(16.h),
                    RatingBar(
                      rating: product.rating.round(),
                    ),
                    Gap(2.h),
                    Text(
                      '(${product.reviews.length} '
                      '${product.reviews.length == 1 ? 'rating' : 'ratings'})',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(14.h),
                    Text(
                      'Review',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kTextGray,
                        fontSize: 16.sp,
                      ),
                    ),
                    Gap(12.h),
                    product.reviews.isEmpty
                        ? Center(
                            child: Text(
                              'No reviews yet',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextGray,
                                fontSize: 18.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Column(
                            children: [
                              //Display 5 reviews
                              for (int i = 0;
                                  product.reviews.length > 5
                                      ? i < 5
                                      : i < product.reviews.length;
                                  i++)
                                _reviewWidget(product.reviews[i]),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewWidget(Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewWidget(
          name: review.reviewerName,
          date: review.date,
          comment: review.comment,
          rating: review.rating,
        ),
        Gap(8.h),
        Divider(
          color: kTextGray,
          height: 1.h,
          thickness: 0.5,
        ),
        Gap(8.h),
      ],
    );
  }
}
