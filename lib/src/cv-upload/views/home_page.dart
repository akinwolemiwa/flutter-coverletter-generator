import 'dart:developer';
import 'dart:io';

import 'package:coverletter/src/auth/models/profil_pic_notifier.dart';
import 'package:coverletter/src/auth/models/user_notifier.dart';
import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/cv-upload/models/files_model.dart';
import 'package:coverletter/src/cv-upload/views/process_upload_cv.dart';
import 'package:coverletter/src/profile/view/profile_page.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/showdialog.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final String? picture = ref.watch(profilePicProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightest,
                      shape: BoxShape.circle,
                      image: picture != null
                          ? DecorationImage(
                              image: NetworkImage(picture), fit: BoxFit.cover)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: picture == null
                        ? Text(
                            user.initials,
                            style: textTheme.headlineMedium!.copyWith(
                              color: AppColors.primaryMain,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              const YGap(value: 25),
              Text(
                "Recent files",
                style: textTheme.headlineMedium!.copyWith(
                  color: AppColors.greys.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const YGap(value: 15),
              Container(
                height: 152.h,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      kDocRedIcon,
                      height: 64.h,
                      width: 64.w,
                    ),
                    const YGap(value: 10),
                    Text(
                      "No generated files yet",
                      style: textTheme.headlineSmall!.copyWith(
                        color: AppColors.greys.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              const YGap(value: 60),
              Text(
                "Your Cover Letter",
                style: textTheme.headlineMedium!.copyWith(
                  color: AppColors.greys.shade800,
                ),
              ),
              const YGap(value: 10),
              Text(
                "Maximum file size is 10MB and you can only upload a maximum of 1 file per upload session,",
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.greys.shade400,
                ),
              ),
              const YGap(value: 20),
              DottedBorder(
                strokeWidth: 3,
                color: const Color(0xFFCDDCF8),
                dashPattern: const [6, 8],
                radius: const Radius.circular(12.0),
                child: Container(
                  height: 140,
                  width: 400,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        kUploadIcon2,
                        height: 64,
                        width: 64,
                      ),
                      const XGap(value: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Upload CV/Resume",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF101010),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const YGap(value: 10),
                          Text(
                            "File supported, PDF",
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.greys.shade400,
                            ),
                          ),
                          const YGap(value: 15),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                              );

                              if (result != null) {
                                File file = File(result.files.single.path!);

                                //Caching the file so that we use it in any page.
                                ref
                                    .read(fileProvider.notifier)
                                    .update((state) => file);

                                log(file.path);
                                if (mounted) {
                                  pushNewScreen(
                                    context,
                                    screen: const ProcessUploadCV(),
                                  );
                                }
                              } else {
                                if (mounted) {
                                  ShowDialog().show(
                                      "Error unsupported file format",
                                      success: false);
                                }
                              }
                            },
                            child: Text(
                              "Browse",
                              style: textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryMain,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
