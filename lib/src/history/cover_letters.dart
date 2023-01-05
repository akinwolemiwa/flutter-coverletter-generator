import 'dart:async';
import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/history/empty_state.dart';
import 'package:coverletter/src/history/model/cv.dart';
import 'package:coverletter/src/history/service/history_service.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/secondary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverLetters extends ConsumerStatefulWidget {
  const CoverLetters({super.key});

  @override
  ConsumerState<CoverLetters> createState() => _CoverLettersState();
}

class _CoverLettersState extends ConsumerState<CoverLetters> {
  @override
  void initState() {
    Future.delayed(Duration.zero, _init);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cvs = ref.watch(getHistProvider);

    return SingleChildScrollView(
      child: cvs.isEmpty
          ? const EmptyState()
          : Column(
              children: [
                const YGap(value: 20),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cvs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10.h,
                            left: 24.h,
                            right: 24.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                  ),
                                ),
                              ),
                              const XGap(value: 8),
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      kPdf,
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                    const XGap(value: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Role: ${cvs[index].role}',
                                            style:
                                                textTheme.headline4!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.greys.shade400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Organisation: ${cvs[index].companyName}',
                                            style:
                                                textTheme.subtitle2!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.greys.shade400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const XGap(value: 8),
                                    Column(
                                      children: [
                                        SecondaryButton(
                                          text: "Download",
                                          textColor: AppColors.greys[400],
                                          color: const Color(0xFFF0F0F8),
                                          width: 100,
                                          height: 32,
                                          onTap: () => _modalBottomSheetMenu3(
                                            cvs[index],
                                          ),
                                        ),
                                        SecondaryButton(
                                          text: "Clear",
                                          textColor: AppColors.errorDark,
                                          color: AppColors.errorLight,
                                          width: 100,
                                          height: 32,
                                          onTap: () {
                                            ref
                                                .read(historyProvider.notifier)
                                                .deleteHistory(cvs[index].sId ??
                                                    "sId is null");
                                          },
                                        ),
                                      ],
                                    ),
                                    const XGap(value: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: AppColors.strokeLight),
                        const YGap(value: 10),
                      ],
                    );
                  },
                )
              ],
            ),
    );
  }

  void _modalBottomSheetMenu3(CoverLetter cv) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      barrierColor: AppColors.primaryDeep.withOpacity(0.4),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Letter Download',
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.header,
                ),
              ),
              const YGap(value: 30),
              GestureDetector(
                onTap: () =>
                    ref.read(historyProvider.notifier).downlaod(cv, context),
                child: Container(
                  width: 327.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primaryMain,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'View Letter',
                      style: textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const YGap(value: 30),
            ],
          ),
        );
      },
    );
  }

  FutureOr _init() async {
    await ref.read(historyProvider.notifier).getHistory();
    setState(() {});
  }
}
