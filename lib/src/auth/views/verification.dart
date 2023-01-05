import 'dart:async';
import 'dart:developer';
import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_nav_widget.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerCountdown = StateProvider<int>((ref) {
  return 60;
});

class Verification extends ConsumerStatefulWidget {
  final String email;
  const Verification({super.key, required this.email});

  @override
  ConsumerState<Verification> createState() => _VerificationState();
}

class _VerificationState extends ConsumerState<Verification> {
  Timer? _timer;
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify your account ",
                    style: textTheme.headline3,
                  ),
                  const YGap(value: 24),
                  Text(
                    "Enter the code sent to your email address",
                    style: textTheme.bodyText1,
                  ),
                  const YGap(value: 24),
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                    controller: codeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: '0000',
                      hintStyle: textTheme.bodyText1!.copyWith(
                        color: AppColors.hinttext,
                      ),
                    ),
                  ),
                  const YGap(value: 24),
                  PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authenticationProvider.notifier)
                            .verifyUser(codeController.text)
                            .then((value) {
                          value.fold((l) => l, (r) {
                            if (r) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomNavWidget(),
                                ),
                              );
                            }
                          });
                        });
                      }
                    },
                    text: "Verify",
                  ),
                  const YGap(value: 24),
                  time > 0
                      ? Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                  text:
                                      'Code not received? please click resend in '),
                              TextSpan(
                                text: '$time',
                              ),
                              const TextSpan(text: ' seconds'),
                            ],
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            ref
                                .read(authenticationProvider.notifier)
                                .generateOTP(widget.email)
                                .then((value) {
                              value.fold((l) => l, (r) {
                                if (r) {
                                  Navigator.pop(context);
                                }
                              });
                            });
                          },
                          child: const Text("Resend"),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
