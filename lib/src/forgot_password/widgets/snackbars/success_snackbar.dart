import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:coverletter/src/theme/color.dart';

class SuccessSnackbar extends StatelessWidget {
  final String successMessage;
  const SuccessSnackbar({super.key, required this.successMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.successMain, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      height: 36,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 3),
            width: 16,
            height: 16,
            child: SvgPicture.asset(successSb),
          ),
          XGap(value: 8.w),
          Text(
            successMessage,
            style: const TextStyle(color: AppColors.successMain),
          ),
        ],
      ),
    );
  }
}
