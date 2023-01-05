import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.btnText,
    required this.onTap,
  });

  final String btnText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.primaryMain,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryMain,
          ),
        ),
      ),
    );
  }
}
