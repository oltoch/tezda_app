import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_app/modules/profile/controllers/profile_controller.dart';
import 'package:tezda_app/widgets/inputs.dart';
import 'package:tezda_app/widgets/place_holder_image.dart';

import '../../../utils/app_colors.dart';

class ProfileView extends StatelessWidget {
  static const String route = '/profile-view';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFDFF),
        title: const Text(
          'Profile',
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w700),
        ),
        elevation: 1,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              pc.logout();
            },
            icon: const Icon(
              Icons.logout,
              size: 26,
            ),
          ),
          Gap(12.w),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Gap(24.h),
            Center(
              child: SizedBox(
                width: 120.w,
                height: 120.h,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: pc.model?.avatar ?? '',
                        width: 120.w,
                        height: 120.h,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const PlaceHolderImage(),
                        placeholder: (context, url) => const PlaceHolderImage(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: Container(
                          width: 26.w,
                          height: 26.h,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/ic_edit.svg',
                              width: 14.w,
                              height: 14.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(16.h),
            Text(
              pc.model?.name ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                color: kTextGray,
                fontWeight: FontWeight.w600,
                height: (20.16 / 16).sp,
              ),
            ),
            Gap(30.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFECF7FF),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 11,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                            color: const Color(0xFF000000).withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Form(
                          key: pc.formKey,
                          child: Column(
                            children: [
                              Gap(20.h),
                              InputWidget(
                                hasLabel: false,
                                enabled: pc.isEdit,
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  size: 26,
                                  color: Color(0xFF5D5A7E),
                                ),
                                initialValue: pc.name.isEmpty ? null : pc.name,
                                onChanged: (v) => pc.name = v,
                                hintText: 'Name',
                                borderRadius: 26.r,
                                textInputAction: TextInputAction.next,
                                validator: (v) => (v == null || v.length < 3)
                                    ? 'Name should be at least 3 characters'
                                    : null,
                              ),
                              Gap(12.h),
                              InputWidget(
                                hasLabel: false,
                                enabled: pc.isEdit,
                                prefixIcon: const Icon(
                                  Icons.mail_outline,
                                  size: 26,
                                  color: Color(0xFF5D5A7E),
                                ),
                                initialValue:
                                    pc.email.isEmpty ? null : pc.email,
                                onChanged: (v) => pc.email = v,
                                hintText: 'Email',
                                keyBoardType: TextInputType.emailAddress,
                                borderRadius: 26.r,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) => pc.updateProfile(),
                                validator: (v) =>
                                    v != null && !GetUtils.isEmail(v)
                                        ? 'Enter a valid email address'
                                        : null,
                              ),
                              Gap(12.h),
                              InputWidget(
                                hasLabel: false,
                                enabled: false,
                                prefixIcon: const Icon(
                                  Icons.settings_accessibility,
                                  size: 26,
                                  color: Color(0xFF5D5A7E),
                                ),
                                initialValue: pc.model?.role.capitalize,
                                hintText: 'Role',
                                borderRadius: 26.r,
                              ),
                              Gap(30.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => pc.updateProfile(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimaryBlue,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 11,
                              spreadRadius: 0,
                              offset: const Offset(1, 1),
                              color: const Color(0xFF000000).withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            pc.isEdit ? 'Update' : 'Edit',
                            style: TextStyle(
                              height: (20.16 / 16).sp,
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
