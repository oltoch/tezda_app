import 'dart:io';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezda_app/utils/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.message,
    this.onCancel,
  });

  final String? message;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    final colorizeColors = [
      Colors.white.withOpacity(0.4),
      Colors.white.withOpacity(0.7),
      Colors.white,
    ];

    final colorizeTextStyle = TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (v, r) {},
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            Positioned(
              bottom: 130.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      child: AnimatedTextKit(
                        pause: const Duration(milliseconds: 1000),
                        repeatForever: true,
                        animatedTexts: [
                          FadeAnimatedText(message ?? 'Please wait...'),
                          FadeAnimatedText('Please wait...'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2), width: 2),
                  ),
                  child: const CircularProgressIndicator(
                    color: Colors.blueAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Center(
                  child: AnimatedTextKit(
                    pause: const Duration(milliseconds: 1000),
                    repeatForever: true,
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Tezda',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        'Tezda',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key, this.color = kPrimaryBlue});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(color: color)
          : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(color),
            ),
    );
  }
}
