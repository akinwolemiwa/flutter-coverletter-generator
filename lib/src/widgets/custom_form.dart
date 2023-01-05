import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
    required this.formTitle,
    required this.inputType,
    required this.controller,
    required this.customeError,
    this.isFieldRequired = true,
    this.hint = '',
    this.isReadOnly = false,
    this.onTap,
  });

  final String formTitle;
  final TextInputType inputType;
  final TextEditingController controller;
  final String customeError;
  final String hint;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final bool isFieldRequired;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.formTitle,
          style: TextStyle(
            color: AppColors.greys.shade400,
            fontSize: 14,
          ),
        ),
        const YGap(value: 2),
        SizedBox(
          height: 73,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: AppColors.greys.shade400),
              hintText: widget.hint,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
            readOnly: widget.isReadOnly,
            onTap: widget.onTap,
            validator: (value) {
              if (value!.isEmpty && widget.isFieldRequired) {
                return widget.customeError;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
