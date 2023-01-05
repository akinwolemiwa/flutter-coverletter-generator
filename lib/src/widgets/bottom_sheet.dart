import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomsheet extends StatelessWidget {
  final String message;
  final String buttonText;
  final bool isSuccess;
  final VoidCallback onTap;
  final String title;

  const AppBottomsheet({
    super.key,
    required this.message,
    required this.title,
    required this.buttonText,
    required this.onTap,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSuccess
              ? SvgPicture.asset(kSuccessUrl)
              : SvgPicture.asset(kFailureUrl),
          const YGap(value: 27.25),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const YGap(value: 5),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const YGap(value: 16),
          PrimaryButton(
            onTap: onTap,
            text: buttonText,
          ),
        ],
      ),
    );
  }
}
