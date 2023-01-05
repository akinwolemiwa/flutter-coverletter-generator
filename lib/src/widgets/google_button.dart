import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleButton extends StatelessWidget {
  // final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  const GoogleButton(
      {super.key,
      //required this.onTap,
      required this.text,
      this.color,
      this.textColor,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primaryMain,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              color: textColor ?? AppColors.primaryMain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SvgPicture.asset(
              googleIcon,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
