import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_app/modules/product/controllers/product_controller.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/widgets/buttons.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({super.key});

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  String sortBy = '';
  String order = '';
  final pc = Get.find<ProductController>();

  void clearFilter() {
    sortBy = '';
    order = '';
    pc.category = 'All';
    pc.filter.clear();
    pc.getProducts();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      final f = pc.filter;
      if (f.containsKey('sortBy')) sortBy = getSortByText(f['sortBy']!);
      if (f.containsKey('order')) order = getOrderText(f['order']!);
      setState(() {});
    });
  }

  String getOrderText(String v) => v == 'asc'
      ? 'Ascending'
      : v == 'desc'
          ? 'Descending'
          : v;

  String getSortByText(String v) => v.capitalize!;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 0.8.sh,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: kTextGray,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        clearFilter();

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Clear Filter',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: kTextGray,
                        ),
                      ),
                    ),
                    Gap(4.w),
                    GestureDetector(
                      onTap: () {
                        clearFilter();
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.02.sp,
                    color: kTextGray,
                    height: (22 / 14).sp,
                  ),
                ),
              ),
              Gap(4.h),
              Container(
                height: 300,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration:
                    BoxDecoration(border: Border.all(color: kPrimaryBlue)),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 6.h,
                    children: List.generate(
                      pc.categories.length + 1,
                      (i) => i == 0
                          ? CardButton(
                              label: 'All',
                              color: pc.category == 'All' ? kPrimaryBlue : null,
                              textColor:
                                  pc.category == 'All' ? Colors.white : null,
                              onTap: () => setState(() => pc.category = 'All'),
                            )
                          : CardButton(
                              label: pc.categories[i - 1].name,
                              color: pc.category == pc.categories[i - 1].name
                                  ? kPrimaryBlue
                                  : null,
                              textColor:
                                  pc.category == pc.categories[i - 1].name
                                      ? Colors.white
                                      : null,
                              onTap: () => setState(() =>
                                  pc.category = pc.categories[i - 1].name),
                            ),
                    ),
                  ),
                ),
              ),
              Gap(12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'Order',
                  style: TextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.02.sp,
                    color: kTextGray,
                    height: (22 / 14).sp,
                  ),
                ),
              ),
              Gap(4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Wrap(
                  spacing: 12.w,
                  runSpacing: 6.h,
                  children: [
                    for (var e in ['Ascending', 'Descending'])
                      CardButton(
                        label: e,
                        color: order == e ? kPrimaryBlue : null,
                        textColor: order == e ? Colors.white : null,
                        onTap: () => setState(() => order = e),
                      ),
                  ],
                ),
              ),
              Gap(12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.02.sp,
                    color: kTextGray,
                    height: (22 / 14).sp,
                  ),
                ),
              ),
              Gap(4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Wrap(
                  spacing: 12.w,
                  runSpacing: 6.h,
                  children: [
                    for (var e in ['Price', 'Title', 'Category'])
                      CardButton(
                        label: e,
                        color: sortBy == e ? kPrimaryBlue : null,
                        textColor: sortBy == e ? Colors.white : null,
                        onTap: () => setState(() => sortBy = e),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Gap(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: PrimaryButton(
              onPressed: () {
                final map = <String, String>{
                  if (order.isNotEmpty) 'order': order,
                  if (sortBy.isNotEmpty) 'sortBy': sortBy,
                };
                pc.filter.assignAll(map);
                if (pc.category != 'All') {
                  pc.getProductsByCategory();
                } else {
                  pc.getProducts();
                }
                Navigator.of(context).pop();
              },
              text: 'Apply Filter',
            ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}
