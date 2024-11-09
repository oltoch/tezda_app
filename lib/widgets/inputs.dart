import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tezda_app/utils/app_colors.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyBoardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool multiLine;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final TextAlign textAlign;
  final String? label;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final bool hasLabel;
  final double? borderRadius;

  /// A custom TextFormField to accept user input
  const InputWidget({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.keyBoardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.multiLine = false,
    this.enabled = true,
    this.readOnly = false,
    this.initialValue,
    this.textAlign = TextAlign.start,
    this.label,
    this.textInputAction,
    this.contentPadding,
    this.hasLabel = true,
    this. borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          Text(
            label ?? hintText ?? '',
            style: TextStyle(
                fontSize: 14.sp, color: kTextGray, height: (22 / 14).sp),
          ),
          Gap(4.h),
        ],
        TextFormField(
          initialValue: initialValue,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: multiLine ? null : 1,
          expands: multiLine,
          cursorColor: kTextGray,
          textInputAction: textInputAction,
          textAlignVertical:
              multiLine ? TextAlignVertical.top : TextAlignVertical.center,
          autocorrect: true,
          textAlign: textAlign,
          textCapitalization: keyBoardType == TextInputType.emailAddress
              ? TextCapitalization.none
              : TextCapitalization.sentences,
          keyboardType: keyBoardType,
          obscureText: obscureText,
          controller: controller,
          obscuringCharacter: '*',
          style: TextStyle(color: kTextGray, fontSize: 16.0.sp),
          decoration: InputDecoration(
            fillColor: const Color(0xFFE5E5E5),
            filled: true,
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFE8EBEE)),
                borderRadius: BorderRadius.circular(borderRadius??12.0)),
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 16.0.w),
            hintText: !enabled && initialValue != null ? null : hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14.0.sp,
              height: (20.12 / 14.0).sp,
              color: const Color(0xFFA5B0B7),
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10.0.sp,
              height: 1,
              color: Colors.red,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14.0.sp,
              height: (22 / 14.0).sp,
              color: kTextGray,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFE8EBEE)),
                borderRadius: BorderRadius.circular(borderRadius??12.0)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(borderRadius??12.0)),
          ),
          onChanged: (String value) => onChanged?.call(value),
          onFieldSubmitted: (String value) => onFieldSubmitted?.call(value),
          validator: (String? value) => validator?.call(value),
        ),
      ],
    );
  }
}
