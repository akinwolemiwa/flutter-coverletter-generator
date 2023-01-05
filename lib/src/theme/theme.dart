import 'package:coverletter/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    headline1: _style(size: 40.sp, weight: FontWeight.w700),
    headline2: _style(size: 36.sp, weight: FontWeight.w700),
    headline3: _style(size: 24.sp, weight: FontWeight.w700),
    headline4: _style(size: 20.sp, weight: FontWeight.w700),
    headline5: _style(size: 14, weight: FontWeight.w700),
    headline6: _style(size: 12, weight: FontWeight.w700),
    bodyText1: _style(size: 16.sp),
    bodyText2: _style(size: 12.sp),
    subtitle1: _style(size: 14.sp),
    subtitle2: _style(size: 12.sp),
  ),
  primaryColor: AppColors.primaryMain,
  dividerColor: AppColors.strokeDark,
  backgroundColor: Colors.white,
  disabledColor: AppColors.disabled,
  iconTheme: const IconThemeData(color: Colors.black),
  primaryIconTheme: const IconThemeData(color: Colors.black),
  cardTheme: CardTheme(
    margin: EdgeInsets.symmetric(vertical: 5.h),
    elevation: 5,
    color: const Color.fromARGB(255, 255, 255, 255),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
  ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(vertical: 15.h),
    buttonColor: AppColors.primaryMain,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
  ),
  cardColor: const Color.fromRGBO(240, 249, 255, 1),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: const Color.fromRGBO(255, 255, 255, 1),
    filled: true,
    hintStyle: _style(size: 14.sp),
    labelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    floatingLabelStyle: _style(size: 18.sp),
    prefixIconColor: Colors.black,
    iconColor: Colors.black,
    focusColor: const Color.fromARGB(5, 94, 131, 1),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.strokeDark,
      ),
      borderRadius: BorderRadius.circular(8.r),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.strokeLight),
      borderRadius: BorderRadius.circular(8.r),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.errorMain,
      ),
      borderRadius: BorderRadius.circular(8.r),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.strokeLight,
      ),
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    interactive: true,
    thumbColor: MaterialStateProperty.all(AppColors.primaryMain),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryMain,
  ),
);

///wrap around the normal [TextStyle] and set constants
TextStyle _style({
  required double size,
  FontWeight weight = FontWeight.w400,
  Color color = Colors.black,
}) =>
    TextStyle(
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
      fontFamily: 'MANROPE',
    );

///Expose a context-free textTheme and theme constant
final TextTheme textTheme = themeData.textTheme;
final ThemeData theme = themeData;
