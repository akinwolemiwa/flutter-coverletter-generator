import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String prefixIcon;
  final String text;
  final String suffixIcon;

  final void Function()? onTap;

  const ProfileButton(
      {super.key,
      required this.prefixIcon,
      required this.text,
      required this.suffixIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 72,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, bottom: 24, left: 40, right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // ImageIcon(
                  Image.asset(
                    prefixIcon,
                    height: 24,
                    width: 24,
                  ),
                  // ),
                  const XGap(value: 24),
                  Text(
                    text,
                    style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.header,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              ImageIcon(
                AssetImage(suffixIcon),
              )
            ],
          ),
        ),
      ),
    );
  }
}
