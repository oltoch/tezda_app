import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_app/modules/onboarding/controllers/register_controller.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/utils/locator.dart';
import 'package:tezda_app/widgets/buttons.dart';
import 'package:tezda_app/widgets/inputs.dart';

class RegisterView extends StatelessWidget {
  static const String route = '/register_view';

  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RegisterController>(
      init: RegisterController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: const Color(0xFFFAFDFF),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryBlue,
                        letterSpacing: -0.02.sp,
                      ),
                    ),
                    Gap(20.h),
                    InputWidget(
                      onChanged: (value) => controller.firstName = value,
                      hintText: 'First Name',
                      keyBoardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) => (value == null || value.length < 3)
                          ? 'First Name should be at least 3 characters'
                          : null,
                    ),
                    Gap(10.h),
                    InputWidget(
                      onChanged: (value) => controller.lastName = value,
                      hintText: 'Last Name',
                      keyBoardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) => (value == null || value.length < 3)
                          ? 'Last Name should be at least 3 characters'
                          : null,
                    ),
                    Gap(10.h),
                    InputWidget(
                      onChanged: (value) => controller.email = value,
                      hintText: 'Email',
                      keyBoardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value == null || !GetUtils.isEmail(value)
                              ? 'Enter a valid email address'
                              : null,
                    ),
                    Gap(10.h),
                    InputWidget(
                      onChanged: (value) => controller.password = value,
                      hintText: 'Password',
                      textInputAction: TextInputAction.next,
                      obscureText: controller.passwordVisibility,
                      suffixIcon: GestureDetector(
                        onTap: () => controller.passwordVisibility =
                            !controller.passwordVisibility,
                        child: Icon(
                          controller.passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 24.sp,
                          color: const Color(0xFFA5B0B7),
                        ),
                      ),
                      validator: (value) => (value == null || value.length < 4)
                          ? 'Password should be at least 4 characters'
                          : null,
                    ),
                    Gap(10.h),
                    InputWidget(
                      onFieldSubmitted: (value) => controller.register(),
                      onChanged: (value) => controller.confirmPassword = value,
                      hintText: 'Confirm Password',
                      textInputAction: TextInputAction.done,
                      obscureText: controller.confirmPasswordVisibility,
                      suffixIcon: GestureDetector(
                        onTap: () => controller.confirmPasswordVisibility =
                            !controller.confirmPasswordVisibility,
                        child: Icon(
                          controller.confirmPasswordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 24.sp,
                          color: const Color(0xFFA5B0B7),
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value != controller.password)
                              ? 'Passwords do not match'
                              : null,
                    ),
                    Gap(20.h),
                    PrimaryButton(
                      onPressed: () => controller.register(),
                      enabled: controller.enabled,
                      text: 'REGISTER',
                    ),
                    Gap(24.h),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                              color: kTextGray,
                              letterSpacing: 0.25.sp,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => nav.pop(),
                              style: TextStyle(
                                  letterSpacing: 0.25.sp,
                                  fontSize: 15.sp,
                                  color: kPrimaryBlue,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
