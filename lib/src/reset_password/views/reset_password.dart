import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/forgot_password/views/forgot_password.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_sheet.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ForgotPasswordState();
}

bool isActive = false;
final passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _ForgotPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: XPadding.horizontal24,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: textTheme.displaySmall,
                ),
                YGap(value: 8.h),
                const Text(
                    'Create a strong password for your account. Your new password must be different from the previous.'),
                YGap(value: 32.h),
                CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    isPasswordField: true,
                    title: 'Old Password',
                    hintText: 'Password'),
                const YGap(value: 32),
                CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    isPasswordField: true,
                    title: 'New Password',
                    hintText: 'Password'),
                YGap(value: 32.h),
                CustomTextField(
                    onChanged: (value) {
                      if (value == passwordController.text) {
                        setState(() {
                          isActive = true;
                        });
                      }
                    },
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Both passwords must match';
                      }
                      return null;
                    },
                    isPasswordField: true,
                    title: 'Confrim Password',
                    hintText: 'Password'),
                YGap(value: 32.h),
                PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 336,
                              child: AppBottomsheet(
                                isSuccess: false,
                                title: 'Success',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ),
                                  );
                                },
                                message:
                                    'Congratulations! Your password has\nbeen reset successfully',
                                buttonText: 'Back To Settings',
                              ),
                            );
                          },
                        );
                      }
                    },
                    text: 'Send Code',
                    color: isActive == true
                        ? AppColors.primaryMain
                        : AppColors.primaryLight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
