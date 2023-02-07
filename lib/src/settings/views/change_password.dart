import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_sheet.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:coverletter/src/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Password',
          style: textTheme.headlineMedium!.copyWith(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create New Password",
                    style: textTheme.displaySmall,
                  ),
                  const YGap(),
                  Text(
                    "Input a unique password. The new password must be different from the previously used passwords.",
                    style: textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const YGap(),
                  CustomTextField(
                    controller: currentPasswordController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Must not be empty';
                      }
                      return null;
                    },
                    isPasswordField: true,
                    title: 'Current Password',
                    hintText: 'Password',
                  ),
                  const YGap(value: 4),
                  const YGap(),
                  CustomTextField(
                    controller: newPasswordController,
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
                  const YGap(),
                  CustomTextField(
                    controller: confirmPasswordController,
                    onChanged: (value) {
                      if (value == newPasswordController.text) {
                        setState(() {
                          isActive = true;
                        });
                      }
                    },
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return 'Both passwords must match';
                      }
                      return null;
                    },
                    isPasswordField: true,
                    title: 'Confirm Password',
                    hintText: 'Password',
                  ),
                  const YGap(value: 32),
                  PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authenticationProvider.notifier)
                            .updatePassword(
                                currentPasswordController.text,
                                newPasswordController.text,
                                confirmPasswordController.text)
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
                                            Navigator.pop(context);
                                          },
                                          message:
                                              'Congratulations! Your new password\nhas been set successfully',
                                          buttonText: 'Done',
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
                    text: 'Create New Password',
                    color: isActive == true
                        ? AppColors.primaryMain
                        : AppColors.primaryLight,
                  ),
                  // const YGap(value: 12),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 48,
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => ResetPassword(),
                  //         ),
                  //       );
                  //     },
                  //     child: const Text("Reset Password"),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
