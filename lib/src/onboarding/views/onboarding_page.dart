import 'package:coverletter/src/auth/views/login.dart';
import 'package:coverletter/src/auth/views/signup.dart';
import 'package:coverletter/src/config/storage/storage.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/outline_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  Storage storage = Storage();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
    setState(() {
      storage.hasSeenOnboarding = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: demoData.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              itemBuilder: (context, index) => OnboardContent(
                pageIndex: demoData[index].pageIndex,
                image: demoData[index].image,
                title: demoData[index].title,
                description: demoData[index].description,
              ),
            ),
          ),
          Padding(
            padding: XPadding.horizontal24,
            child: _pageIndex == 2
                ? Column(
                    children: [
                      PrimaryButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        text: "Register",
                      ),
                      const YGap(value: 12),
                      OutlineButton(
                        btnText: "Sign in",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: AppColors.greys[800]),
                        ),
                      ),
                      PrimaryButton(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        text: "Next",
                        width: 100,
                      ),
                    ],
                  ),
          ),
          const YGap(value: 12),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryMain : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;
  final int pageIndex;

  const Onboard(
      {required this.pageIndex,
      required this.image,
      required this.title,
      required this.description});
}

List<Onboard> demoData = const [
  Onboard(
    pageIndex: 0,
    image: "assets/images/onboarding/screen1.png",
    title: "Upload Your CV",
    description:
        "Get your professional cover letter ready within few minutes of uploading your CV.",
  ),
  Onboard(
    pageIndex: 1,
    image: "assets/images/onboarding/screen2.png",
    title: "Create Cover Letter",
    description:
        "The coverly generating tool allows job seekers to create a well-detailed cover letter within a few minutes",
  ),
  Onboard(
    pageIndex: 2,
    image: "assets/images/onboarding/screen3.png",
    title: "Download Letter ",
    description: "Your detailed cover letter is ready for download.",
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.pageIndex,
  }) : super(key: key);

  final String image, title, description;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, -160),
            child: Column(
              children: [
                Image.asset(
                  image,
                  width: 571,
                  height: 550.h,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, left: 24.0),
                  child: Row(
                    children: [
                      ...List.generate(
                        demoData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: DotIndicator(
                            isActive: index == pageIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: XPadding.horizontal24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: textTheme.headlineMedium),
                      const YGap(value: 8),
                      Text(
                        description,
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
