import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/auth/models/user_notifier.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_sheet.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final roleController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = ref.read(userProvider).name;
    roleController.text = ref.read(userProvider).role ?? "";
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.read(userProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Full Name"),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: user.name,
                    hintStyle: textTheme.bodyText1!.copyWith(
                      color: AppColors.hinttext,
                    ),
                  ),
                  controller: nameController,
                ),
                const YGap(value: 24),
                const Text("Role"),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: user.role,
                    hintStyle: textTheme.bodyText1!.copyWith(
                      color: AppColors.hinttext,
                    ),
                  ),
                  controller: roleController,
                ),
                const YGap(),
                PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authenticationProvider.notifier)
                            .updateProfile(
                                nameController.text, roleController.text)
                            .then(
                          (value) {
                            value.fold(
                              (l) => l,
                              (r) {
                                if (r) {
                                  var userInfo = User(
                                    name: nameController.text,
                                    email: user.email,
                                    role: roleController.text,
                                  );
                                  ref
                                      .read(userProvider.notifier)
                                      .update((state) => userInfo);

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
                                                    'Congratulations! Your profile has\nbeen updated successfully',
                                                buttonText: 'Done'));
                                      });
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                    text: "Save"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
