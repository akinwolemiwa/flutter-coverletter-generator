import 'package:coverletter/main.dart';
import 'package:coverletter/src/pdf-download-preview/views/download_option.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';

MaterialButton downloadButton({required bool active}) {
  download() {
    showModalBottomSheet(
      context: navKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) => const DownloadOptions(),
    );
  }

  return MaterialButton(
    color: AppColors.primaryMain,
    onPressed: active ? () => download() : null,
    disabledColor: Colors.grey.shade200,
    child: Text(
      'Download Cover Letter',
      style: textTheme.bodyText1!.copyWith(color: AppColors.backgroundColor),
    ),
  );
}
