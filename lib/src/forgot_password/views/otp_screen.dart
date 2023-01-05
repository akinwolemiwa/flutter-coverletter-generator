import 'dart:async';
import 'dart:developer';
import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/forgot_password/views/create_new_password.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/widgets/bottom_sheet.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

final timerCountdown = StateProvider<int>((ref) {
  return 60;
});

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  const OtpScreen(this.email, {super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  Timer? _timer;
  bool isFilled = false;
  TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    _setTimer();
    super.initState();
  }

  _setTimer() {
    var time = ref.read(timerCountdown);
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      time = ref.read(timerCountdown.notifier).update((state) {
        time = state--;
        return state--;
      });

      log(time.toString());
      if (time < 1) _timer?.cancel();
    });
    _timer;
  }

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(timerCountdown);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: XPadding.horizontal24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email Verification',
                style: textTheme.headline3,
              ),
              YGap(value: 10.h),
              const Text(
                  'Enter the OTP code sent to the email associated with your account to reset your password.'),
              YGap(value: 32.h),
              Center(
                child: Pinput(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(removeSpace),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      isFilled = v.isEmpty ? false : true;
                    });
                  },
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: defaultPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => debugPrint(pin),
                ),
              ),
              const YGap(value: 32),
              time > 0
                  ? Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Code not received? please click resend in ',
                          ),
                          TextSpan(
                            text: '$time',
                          ),
                          const TextSpan(text: ' seconds'),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Didn\'t receive any code?'),
                        XGap(value: 4.h),
                        InkWell(
                          onTap: () {
                            ref
                                .read(authenticationProvider.notifier)
                                .generateOTP(widget.email)
                                .then((value) {
                              value.fold((l) => l, (r) {
                                if (r) {
                                  Navigator.pop(context);
                                  setState(() {
                                    _setTimer();
                                  });
                                }
                              });
                            });
                          },
                          child: const Text(
                            'Resend Code',
                            style: TextStyle(color: AppColors.primaryMain),
                          ),
                        ),
                      ],
                    ),
              const YGap(value: 32),
              PrimaryButton(
                onTap: () {
                  ref
                      .read(authenticationProvider.notifier)
                      .validateOTP(widget.email, pinController.text)
                      .then(
                    (value) {
                      value.fold(
                        (l) => l,
                        (r) async {
                          if (r) {
                            //  Navigator.pop(context);
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 336,
                                  child: AppBottomsheet(
                                    isSuccess: true,
                                    title: 'Success',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateNewPassword(widget.email),
                                        ),
                                      );
                                    },
                                    message:
                                        'Congratulations! OTP code verification successfull',
                                    buttonText: 'Proceed',
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
                },
                text: 'Reset Password',
                color: isFilled == true
                    ? AppColors.primaryMain
                    : AppColors.primaryLight,
              )
            ],
          ),
        ),
      ),
    );
  }
}

final defaultPinTheme = PinTheme(
  margin: const EdgeInsets.symmetric(horizontal: 16),
  width: 45.w,
  height: 48.h,
  textStyle: textTheme.headline4!.copyWith(
    color: AppColors.strokeDark,
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.strokeDark),
    borderRadius: BorderRadius.circular(8),
  ),
);
