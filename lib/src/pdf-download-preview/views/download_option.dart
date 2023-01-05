import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/pdf-download-preview/model/service/pdf_service.dart';
import 'package:coverletter/src/pdf-download-preview/views/downloading.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadOptions extends ConsumerStatefulWidget {
  const DownloadOptions({Key? key}) : super(key: key);

  @override
  ConsumerState<DownloadOptions> createState() => _DownloadOptionsState();
}

class _DownloadOptionsState extends ConsumerState<DownloadOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(pdfProvider.notifier);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        color: Colors.white,
        height: 450.h,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F7),
              ),
              height: 60.h,
              child: Row(
                children: [
                  const Spacer(),
                  const SizedBox(width: 24),
                  const Spacer(),
                  Text(
                    'Download Option',
                    style: textTheme.headline4!,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const ImageIcon(
                      AssetImage(kCloseIcon),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(24.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: DocumentFormat.values
                              .map((e) => downloadTile(e))
                              .toList(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: state.sendToEmail,
                          onChanged: (_) {
                            setState(() {
                              state.sendToEmail = !state.sendToEmail;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: AppColors.primaryMain,
                        ),
                        Text(
                          'Send downloaded template to email.',
                          style: textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const YGap(value: 10),
                    MaterialButton(
                      color: AppColors.primaryMain,
                      onPressed: state.format == null
                          ? null
                          : () {
                              Navigator.of(context).pop();

                              showDialog(
                                context: context,
                                barrierColor: Colors.white,
                                barrierDismissible: false,
                                builder: (context) => const Downloading(),
                              );
                            },
                      disabledColor: Colors.grey.shade200,
                      disabledTextColor: Colors.black,
                      child: Text(
                        'Download Cover Letter',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const YGap(value: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector downloadTile(DocumentFormat documentFormat) {
    var state = ref.watch(pdfProvider.notifier);

    return GestureDetector(
      onTap: () {
        setState(() {
          state.format = documentFormat;
        });
      },
      child: Column(
        children: [
          Row(
            children: [
              const ImageIcon(AssetImage(kDoc)),
              const XGap(value: 30),
              Expanded(
                child: Text(
                  documentFormat.name.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const XGap(value: 30),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: (state.format != null &&
                            state.format!.name.toLowerCase() ==
                                documentFormat.name.toLowerCase())
                        ? AppColors.primaryMain
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const YGap(value: 5),
          const Divider(),
          const YGap(value: 15),
        ],
      ),
    );
  }
}
