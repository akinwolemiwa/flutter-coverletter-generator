import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:coverletter/src/forgot_password/views/otp_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  bool isActive = false;
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                Text('Forgot Password', style: textTheme.displaySmall),
                YGap(value: 8.h),
                const Text(
                    'You appear to have forgotten your password. Enter the email registered to your account, and a code will be sent to reset your password.'),
                YGap(value: 32.h),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(removeSpace),
                    ),
                  ],
                  controller: emailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Invalid email address. Check it out!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'email@example.com',
                    hintStyle: textTheme.bodyLarge!.copyWith(
                      color: AppColors.hinttext,
                    ),
                  ),
                  onChanged: (v) {
                    setState(() {
                      isActive = v.isEmpty ? false : true;
                    });
                  },
                ),
                YGap(value: 32.h),
                PrimaryButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authenticationProvider.notifier)
                          .forgotPassword(emailController.text)
                          .then(
                        (value) {
                          value.fold(
                            (l) => l,
                            (r) {
                              if (r) {
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
                                      height: 336.h,
                                      child: AppBottomsheet(
                                        isSuccess: true,
                                        title: 'Success',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => OtpScreen(
                                                emailController.text,
                                              ),
                                            ),
                                          );
                                        },
                                        message:
                                            'Check your email address for a code\nto reset your password',
                                        buttonText: 'Open Email',
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                  text: 'Change password',
                  color: isActive == true
                      ? AppColors.primaryMain
                      : AppColors.primaryLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
