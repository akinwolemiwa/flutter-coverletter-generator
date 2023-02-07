import 'dart:developer';
import 'dart:io';
import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/cv-upload/models/files_model.dart';
import 'package:coverletter/src/cv-upload/views/form_page.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/outline_button.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/showdialog.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ProcessUploadCV extends ConsumerStatefulWidget {
  const ProcessUploadCV({super.key});

  @override
  ConsumerState<ProcessUploadCV> createState() => _ProcessUploadCVState();
}

class _ProcessUploadCVState extends ConsumerState<ProcessUploadCV>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1600), vsync: this);

    animation = Tween(begin: 0.0, end: 250.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInToLinear,
      ),
    )..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contex) {
    final pdfFile = ref.read(fileProvider);

    var fileName = pdfFile!.path.split('/').last;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          child: Column(
            children: [
              Text(
                "Upload your CV and we will take care of the rest",
                style: textTheme.headlineMedium!.copyWith(
                  color: AppColors.strokeDark,
                ),
              ),
              const YGap(value: 10),
              Text(
                "Maximum file size is 10MB and you can only upload a maximum of 1 file per upload session,",
                style: textTheme.bodyLarge!.copyWith(
                  color: AppColors.greys.shade400,
                ),
              ),
              const YGap(value: 30),
              DottedBorder(
                strokeWidth: 3,
                color: AppColors.primaryLightest,
                // strokeCap: StrokeCap.round,
                dashPattern: const [6, 8],
                radius: const Radius.circular(12.0),
                child: Container(
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
                      const XGap(value: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: _progress == 250
                                  ? Text(fileName,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: AppColors.greys.shade800,
                                        fontWeight: FontWeight.w600,
                                      ))
                                  : const SizedBox.shrink(),
                            ),
                            const YGap(value: 10),
                            _progress == 250
                                ? Text(
                                    "File uploaded",
                                    style: textTheme.bodyLarge!.copyWith(
                                      color: AppColors.greys.shade400,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const YGap(value: 15),
                            _progress == 250
                                ? InkWell(
                                    onTap: () {
                                      ref
                                          .read(fileProvider.notifier)
                                          .update((state) => null);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Remove file",
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: AppColors.errorMain,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const YGap(value: 15),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            fileName,
                            style: textTheme.bodyLarge!.copyWith(
                              color: AppColors.greys.shade400,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const YGap(value: 10),
                          //Animate this container
                          Container(
                            width: _progress,
                            height: 5,
                            color: AppColors.primaryMain,
                          ),
                        ],
                      ),
                    ),
                    _progress == 250
                        ? const Icon(
                            Icons.check_box,
                            color: AppColors.successMain,
                          )
                        : const SizedBox.shrink(),
                    const XGap(value: 10)
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                child: Column(
                  children: [
                    PrimaryButton(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: const FormPage(),
                        );
                      },
                      text: "Continue",
                    ),
                    const YGap(value: 10),
                    OutlineButton(
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
                            pushNewScreen(context,
                                screen: const ProcessUploadCV());
                          }
                        } else {
                          if (mounted) {
                            ShowDialog().show("Error unsupported file format",
                                success: false);
                          }
                        }
                      },
                      btnText: "Change file",
                    ),
                    const YGap(value: 15.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
