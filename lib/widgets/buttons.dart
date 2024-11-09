import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezda_app/utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.textStyle,
    this.padding,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
  });

  final VoidCallback onPressed;
  final String? text;
  final bool enabled;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? kPrimaryBlue,
        disabledForegroundColor: kPrimaryBlue.withOpacity(0.56),
        disabledBackgroundColor: kPrimaryBlue.withOpacity(0.38),
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r)),
      ),
      child: Align(
        child: Center(
          child: Text(
            text ?? ' ',
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  letterSpacing: 1.sp,
                ),
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    this.label,
    this.color,
    this.textColor,
    this.fontSize,
    this.onTap,
    this.border,
    this.fontWeight,
    this.padding,
  });

  final String? label;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: border ??
              Border.all(color: const Color(0xFFA5AB07).withOpacity(0.2)),
          color: color ?? Colors.white,
        ),
        child: Text(
          label ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? kTextGray,
            fontSize: fontSize ?? 13.sp,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
