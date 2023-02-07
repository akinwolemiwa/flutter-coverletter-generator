import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:coverletter/main.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDialog {
  ShowDialog() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) => _dispose());
  }

  late Timer timer;

  show(String text, {bool success = true}) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: navKey.currentContext!,
      builder: (context) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ElasticIn(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  margin: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: success ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge!.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.cancel,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _dispose() {
    Navigator.of(navKey.currentContext!).pop(true);

    timer.cancel();
  }
}
