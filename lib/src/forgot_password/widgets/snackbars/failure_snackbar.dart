import 'package:coverletter/src/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/spacing.dart';

class FailureSnackbar extends StatelessWidget {
  final String errorMessage;
  const FailureSnackbar({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.errorMain, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      height: 38.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 3),
            width: 16,
            height: 16,
            child: SvgPicture.asset(errorSb),
          ),
          XGap(value: 8.h),
          Text(errorMessage, style: const TextStyle(color: AppColors.errorMain))
        ],
      ),
    );
  }
}
