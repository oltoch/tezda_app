import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tezda_app/modules/onboarding/controllers/login_controller.dart';
import 'package:tezda_app/modules/onboarding/views/register_view.dart';
import 'package:tezda_app/utils/app_colors.dart';
import 'package:tezda_app/utils/locator.dart';
import 'package:tezda_app/widgets/buttons.dart';
import 'package:tezda_app/widgets/inputs.dart';

class LoginView extends StatelessWidget {
  static const String route = '/login_view';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      init: LoginController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(40.h),
                    Text(
                      'Account Login',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryBlue,
                      ),
                    ),
                    Gap(24.h),
                    InputWidget(
                      initialValue: controller.email,
                      onChanged: (value) {
                        controller.email = value;
                      },
                      hintText: 'Email',
                      textInputAction: TextInputAction.next,
                      keyBoardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value == null || !GetUtils.isEmail(value)
                              ? 'Enter a valid email address'
                              : null,
                    ),
                    Gap(12.h),
                    InputWidget(
                      onFieldSubmitted: (value) => controller.login(),
                      onChanged: (value) => controller.password = value,
                      hintText: 'Password',
                      textInputAction: TextInputAction.done,
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
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Enter a valid password'
                          : null,
                    ),
                    Gap(24.h),
                    PrimaryButton(
                      onPressed: () => controller.login(),
                      enabled: controller.email.isNotEmpty &&
                          controller.password.isNotEmpty,
                      text: 'LOGIN',
                    ),
                    Gap(20.h),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Don\'t have an account yet? ',
                          style: TextStyle(
                              letterSpacing: 0.25.sp,
                              fontSize: 15.sp,
                              color: kTextGray,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nav.pushNamed(RegisterView.route);
                                },
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
                    Gap(36.h),
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
