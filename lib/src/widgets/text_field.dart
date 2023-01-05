import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final String title;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.title,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.controller,
    this.isPasswordField = false,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const YGap(value: 4),
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: widget.isPasswordField == true
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.greys.shade800,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : const SizedBox(),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.placeholder,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.strokeLight),
              borderRadius: BorderRadius.circular(8.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.strokeDark,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.errorMain,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.strokeLight,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        )
      ],
    );
  }
}
