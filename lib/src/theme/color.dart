///READ THIS
///usage: AppColors.backgroundColor
///use 'greys' as: AppColors.greys.//insert shade

import 'package:flutter/material.dart';

class AppColors {
  //uncategorized
  static const Color backgroundColor = Color(0xffF2F2F7);
  static Color blueOverlay = const Color(0xff03296F).withOpacity(0.4);
  static Color disabledOverlay = const Color(0xff1b1b1b).withOpacity(0.6);

  //text
  static const Color header = Color(0xff1C1C1E);
  static const Color body = Color(0xff484848);
  static const Color placeholder = Color(0xffA7A7A7);
  static const Color white = Color(0xffFCFCFC);

  //primary
  static const Color primaryLightest = Color(0xffCDDCF8);
  static const Color primaryLight = Color(0xffACC5F4);
  static const Color primaryMain = Color(0xff0652DD);
  static const Color primaryDark = Color(0xff0544b8);
  static const Color primaryDeep = Color(0xff03296F);

  //stroke
  static const Color strokeDark = Color(0xff434343);
  static const Color strokeLight = Color(0xffCAD0DD);
  static const Color strokeLightest = Color(0xffDFE3EA);

  //error
  static const Color errorLight = Color(0xffFFD8D6);
  static const Color errorDark = Color(0xffA81414);
  static const Color errorMain = Color(0xffFF2635);

  //success
  static const Color successLight = Color(0xffE5FCF6);
  static const Color successMain = Color(0xff0FB56D);
  static const Color successDark = Color(0xff26704C);

  //warning
  static const Color warningLight = Color(0xffFFFBA8);
  static const Color warningMain = Color(0xffE9E132);
  static const Color warningDark = Color(0xffB0AB39);

  //hinttext
  static const Color hinttext = Color(0xffBABABA);

  //disabled
  static const Color disabled = Color(0xffC5C5C5); //same with grey200

  //grey
  static const greys = MaterialColor(
    0xffDCDCDC, //same as grey100 from the design guide
    {
      300: Color(0xff8A8A8A),
      400: Color(0xff6D6D6D),
      500: Color(0xff434343),
      600: Color(0xff353535),
      700: Color(0xff282828),
      800: Color(0xff101010),
    },
  );
}
