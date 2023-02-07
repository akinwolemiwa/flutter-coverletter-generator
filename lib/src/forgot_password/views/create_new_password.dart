import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/auth/views/login.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_sheet.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPassword extends ConsumerStatefulWidget {
  final String email;
  const CreateNewPassword(this.email, {super.key});

  @override
  ConsumerState<CreateNewPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<CreateNewPassword> {
  bool isActive = false;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New Password',
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
                  controller: passwordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                  isPasswordField: true,
                  title: 'New Password',
                  hintText: 'Password',
                ),
                YGap(value: 32.h),
                CustomTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(removeSpace),
                    ),
                  ],
                  controller: confirmPasswordController,
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
                  title: 'Confirm Password',
                  hintText: 'Password',
                ),
                YGap(value: 32.h),
                PrimaryButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authenticationProvider.notifier)
                          .changePassword(
                            widget.email,
                            passwordController.text,
                            confirmPasswordController.text,
                          )
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
                                  )),
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
                                              builder: (context) =>
                                                  const Login(),
                                            ),
                                          );
                                        },
                                        message:
                                            'Congratulations! Your new password\nhas been set successfully',
                                        buttonText: 'Log In',
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
                  text: 'Change Password',
                  color: isActive == true
                      ? AppColors.primaryMain
                      : AppColors.primaryLight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TOD0: add will pop scope. 