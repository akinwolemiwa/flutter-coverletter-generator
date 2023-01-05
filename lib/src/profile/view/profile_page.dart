import 'package:coverletter/main.dart';
import 'package:coverletter/src/auth/models/profil_pic_notifier.dart';
import 'package:coverletter/src/auth/models/user_notifier.dart';
import 'package:coverletter/src/auth/views/login.dart';
import 'package:coverletter/src/constants/api_urls.dart';
import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/cv-upload/views/home_page.dart';
import 'package:coverletter/src/faq/faq.dart';
import 'package:coverletter/src/profile/model/launch_url.dart';
import 'package:coverletter/src/profile/view/how_it_works.dart';
import 'package:coverletter/src/settings/views/settings_page.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/profile_buttons.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider);
    final String? picture = ref.watch(profilePicProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile',
            style: textTheme.headline4!.copyWith(fontSize: 18),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              icon: const Icon(Icons.settings_outlined),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              //avatar
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryDark,
                    image: picture != null
                        ? DecorationImage(
                            image: NetworkImage(picture), fit: BoxFit.cover)
                        : null,
                    border: Border.all(
                      color: AppColors.primaryLightest,
                      width: 10,
                    )),
                child: picture == null
                    ? Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        child: Text(
                          user.initials,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const YGap(value: 20),
              //name
              Text(
                user.name,
                style: textTheme.headline4,
              ),
              const YGap(value: 5),
              //email
              Text(user.email, style: textTheme.subtitle1),
              const YGap(value: 25),
              //upload cv button
              InkWell(
                onTap: () {
                  pushNewScreen(context, screen: const HomePage());
                },
                child: Container(
                  width: 327,
                  height: 48,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryDark,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text('Upload CV',
                          style: textTheme.bodyText1!.copyWith(
                              color: AppColors.primaryDark,
                              fontSize: 17,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
              const YGap(value: 32),
              //how it works button
              ProfileButton(
                prefixIcon: kWarning,
                text: 'How it works',
                suffixIcon: kArrowRight,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HowItWorks(),
                  ),
                ),
              ),
              const YGap(value: 16),
              //faqs
              ProfileButton(
                prefixIcon: kInfo,
                text: 'FAQs',
                suffixIcon: kArrowRight,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FaqPage()),
                ),
              ),
              const YGap(value: 16),
              //contact us
              ProfileButton(
                prefixIcon: kUserOutlined,
                text: 'Contact Us',
                suffixIcon: kExport,
                onTap: (() {
                  customLaunch(ApiUrls.contact);
                }),
              ),
              const YGap(value: 16),
              //Log out
              ProfileButton(
                prefixIcon: kLogOut,
                text: 'Log out',
                suffixIcon: kArrowRight,
                onTap: (() {
                  _modalBottomSheetMenu4(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu4(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      barrierColor: AppColors.primaryDeep.withOpacity(0.4),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const YGap(value: 30),
              Text(
                'Logout',
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.header,
                ),
              ),
              const YGap(value: 30),
              Text(
                'Are you sure you want to logout',
                style: textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: AppColors.header,
                ),
              ),
              const YGap(value: 30),
              GestureDetector(
                onTap: () => Navigator.of(navKey.currentContext!)
                    .pushReplacement(
                        MaterialPageRoute(builder: (context) => const Login())),
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
                      'Continue',
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
}
