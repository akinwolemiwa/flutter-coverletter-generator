import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
class SecondaryButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  const SecondaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.fontWeight,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: color ?? AppColors.primaryMain,
        minimumSize: Size(
          width ?? double.infinity,
          height ?? 48.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        text,
        style: textTheme.subtitle1!.copyWith(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
