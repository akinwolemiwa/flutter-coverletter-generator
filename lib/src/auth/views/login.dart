import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/auth/views/signup.dart';
import 'package:coverletter/src/config/storage/storage.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/forgot_password/views/forgot_password.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/bottom_nav_widget.dart';
import 'package:coverletter/src/widgets/google_button.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  Storage storage = Storage();
  final _formKey = GlobalKey<FormState>();
  final loginPasswordController = TextEditingController();
  final loginEmailController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    "Login to your account ",
                    style: textTheme.headline3,
                  ),
                  const YGap(value: 24),
                  const Text("Email Address"),
                  const YGap(value: 4),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    validator: (String? value) {
                      String pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      if (value!.isEmpty) {
                        return 'Email address is required';
                      } else {
                        RegExp regExp = RegExp(pattern);
                        if (regExp.hasMatch(value)) {
                          return null;
                        } else {
                          return 'Please use a valid email address';
                        }
                      }
                    },
                    controller: loginEmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const YGap(value: 24),
                  const Text("Password"),
                  const YGap(value: 4),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }

                      return null;
                    },
                    obscureText: !_passwordVisible,
                    controller: loginPasswordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: AppColors.greys[800],
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const YGap(value: 24),
                  PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authenticationProvider.notifier)
                            .login(loginEmailController.text.trim(),
                                loginPasswordController.text.trim())
                            .then((value) {
                          value.fold((l) => l, (r) {
                            if (r) {
                              Navigator.push(
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
                    text: "Sign In",
                  ),
                  const YGap(value: 16),
                  GestureDetector(
                    onTap: () async {
                      ref
                          .read(authenticationProvider.notifier)
                          .googleAuth()
                          .then(
                        (value) {
                          value.fold(
                            (l) => l,
                            (r) {
                              if (r) {
                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                      );
                    },
                    child: const GoogleButton(
                      text: 'Sign In with Google',
                    ),
                  ),
                  const YGap(value: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Forgot Password"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Click Here",
                          style: TextStyle(
                            color: AppColors.primaryMain,
                          ),
                        ),
                      )
                    ],
                  ),
                  const YGap(value: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: AppColors.primaryMain,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
