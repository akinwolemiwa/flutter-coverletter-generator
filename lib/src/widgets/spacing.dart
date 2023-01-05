import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// h mean hieght and w means width

class XPadding {
  static EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: 24.0.w);
}

//Gap for the width
class XGap extends StatelessWidget {
  const XGap({super.key, this.value = 24});

  final num value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value.toDouble().w,
    );
  }
}

//Gap for the height
class YGap extends StatelessWidget {
  const YGap({super.key, this.value = 24});

  final num value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value.toDouble().h,
    );
  }
}
