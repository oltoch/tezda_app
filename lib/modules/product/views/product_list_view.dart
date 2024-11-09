import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_app/modules/product/controllers/product_controller.dart';
import 'package:tezda_app/modules/product/views/product_details_view.dart';
import 'package:tezda_app/modules/product/views/product_filter.dart';
import 'package:tezda_app/modules/product/views/product_tile.dart';
import 'package:tezda_app/modules/profile/views/profile_view.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/utils/locator.dart';
import 'package:tezda_app/widgets/inputs.dart';
import 'package:tezda_app/widgets/loading_screen.dart';

class ProductListView extends StatelessWidget {
  static const String route = '/product-list-view';

  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(
      init: ProductController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFFAFDFF),
            // surfaceTintColor: Colors.transparent,
            title: const Text(
              'Products',
              style:
                  TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w700),
            ),
            elevation: 1,
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  nav.pushNamed(ProfileView.route);
                },
                icon: Image.asset(
                  'assets/images/avatar_image.png',
                  width: 35.w,
                  height: 35.h,
                ),
              ),
              Gap(12.w),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: RefreshIndicator(
                onRefresh: () {
                  if (controller.search.isNotEmpty) {
                    return Future.value();
                  }
                  if (controller.category != 'All') {
                    return Future.value(controller.getProductsByCategory());
                  }
                  return Future.value(controller.getProducts());
                },
                color: kPrimaryBlue,
                strokeWidth: 3,
                child: Column(
                  children: [
                    Gap(10.h),
                    InputWidget(
                        hasLabel: false,
                        hintText: 'Search...',
                        controller: controller.searchController,
                        onChanged: (v) => controller.search = v,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        prefixIcon: UnconstrainedBox(
                          child: SvgPicture.asset('assets/icons/ic_search.svg',
                              height: 24.h, width: 24.w),
                        ),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              if (controller.search.isNotEmpty) {
                                controller.searchController.clear();
                                controller.search = '';
                                controller.getProducts();
                                return;
                              }
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return const ProductFilter();
                                },
                              );
                            },
                            child: controller.search.isNotEmpty
                                ? const Icon(
                                    Icons.close,
                                    color: Color(0xFF003057),
                                    size: 28,
                                  )
                                : UnconstrainedBox(
                                    child: SvgPicture.asset(
                                        'assets/icons/ic_filter.svg',
                                        height: 24.h,
                                        width: 24.w),
                                  )),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (v) {
                          if (v.isNotEmpty) {
                            controller.searchProduct(v);
                            return;
                          }
                          controller.getProducts();
                        }),
                    Gap(20.h),
                    Expanded(
                      child: controller.loading
                          ? const CircularLoading()
                          : controller.products.isEmpty
                              ? Center(
                                  child: Text(
                                    'No products to show!',
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      color: kTextGray,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  controller: controller.scrollController,
                                  itemCount: controller.products.length + 1,
                                  itemBuilder: (context, i) {
                                    if (i < controller.products.length) {
                                      final item = controller.products[i];
                                      return GestureDetector(
                                        onTap: () {
                                          nav.pushNamed(
                                              ProductDetailsView.route,
                                              arg: item);
                                        },
                                        child: ProductTile(
                                          model: item,
                                          onHeartTapped: () {
                                            controller.products[i] =
                                                item.copyWith(
                                                    favourite: !item.favourite);
                                          },
                                        ),
                                      );
                                    } else if (controller.loadingMore) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: const CircularLoading(),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
