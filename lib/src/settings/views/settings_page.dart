import 'dart:developer';
import 'dart:io';
import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/auth/models/profil_pic_notifier.dart';
import 'package:coverletter/src/auth/models/user_notifier.dart';
import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/settings/views/change_password.dart';
import 'package:coverletter/src/settings/views/languages.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:coverletter/src/settings/views/edit_profile.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsConsumerState();
}

class _SettingsConsumerState extends ConsumerState<Settings> {
  final ImagePicker picker = ImagePicker();
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider);
    final String? picture = ref.watch(profilePicProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: textTheme.headline4!.copyWith(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        imagePath = pickedFile.path;
                        log("imageeeeee");
                        log(imagePath);
                      });
                      ref
                          .read(authenticationProvider.notifier)
                          .changeProfilePic(imagePath)
                          .then(
                        (value) {
                          value.fold(
                            (l) => l,
                            (r) {
                              if (r) {}
                            },
                          );
                        },
                      );
                    }
                  },
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        imagePath != '' && picture != null
                            ? CircleAvatar(
                                radius: 35,
                                backgroundImage: FileImage(
                                  File(imagePath),
                                ),
                              )
                            : Container(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryDark,
                                  image: picture != null
                                      ? DecorationImage(
                                          image: NetworkImage(picture))
                                      : null,
                                  border: Border.all(
                                      color: AppColors.primaryLightest,
                                      width: 8),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: picture == null
                                    ? Text(
                                        user.initials,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                        Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.2),
                            border: Border.all(
                                color: AppColors.primaryLightest, width: 8),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const XGap(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: textTheme.headline4,
                    ),
                    Text(
                      user.email,
                      style: textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
            const YGap(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PrimaryButton(
                  text: "Edit Profile",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                  }),
            ),
            const YGap(),
            GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()));
              }),
              child: Card(
                shadowColor: Colors.transparent,
                color: AppColors.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock),
                      const XGap(value: 18),
                      Text(
                        "Change Password",
                        style: textTheme.headline4!.copyWith(
                          fontSize: 16,
                          color: AppColors.greys.shade400,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: AppColors.greys.shade400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const YGap(value: 16),
            GestureDetector(
              onTap: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Languages()));
              }),
              child: Card(
                shadowColor: Colors.transparent,
                color: AppColors.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.language),
                      const XGap(value: 18),
                      Text(
                        "Language",
                        style: textTheme.headline4!.copyWith(
                          fontSize: 16,
                          color: AppColors.greys.shade400,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: AppColors.greys.shade400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          logoSvg,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    ),
                    const YGap(value: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.copyright_outlined,
                          size: 12,
                          color: AppColors.greys.shade400,
                        ),
                        Text(
                          " 2022. All rights reserved",
                          style: textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.greys.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
