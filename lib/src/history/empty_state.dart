import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const YGap(value: 100),
        Image.asset(emptyState),
        const YGap(value: 26),
        Text(
          letterString,
          textAlign: TextAlign.center,
          style: textTheme.displaySmall!.copyWith(
            color: AppColors.header,
          ),
        ),
        const YGap(value: 8),
        Text(
          noLetter,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge!.copyWith(
            color: AppColors.greys.shade400,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
