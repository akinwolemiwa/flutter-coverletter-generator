import 'package:coverletter/src/config/storage/storage.dart';
import 'package:coverletter/src/auth/views/login.dart';
import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/onboarding/views/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigateUser();
  }

  Storage storage = Storage();

  Future navigateUser() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      if (storage.hasSeenOnboarding) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    logoSvg,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
