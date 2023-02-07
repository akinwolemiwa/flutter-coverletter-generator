import 'package:coverletter/src/auth/models/authentication_notifer.dart';
import 'package:coverletter/src/auth/views/login.dart';
import 'package:coverletter/src/auth/views/verification.dart';
import 'package:coverletter/src/constants/string.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimController = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confrimController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),
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
                    "Don't have an account?\nSignup to save cover letter",
                    style: textTheme.displaySmall,
                  ),
                  const YGap(value: 24),
                  const Text("Full Name"),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'John Doe',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: AppColors.hinttext,
                      ),
                    ),
                    controller: nameController,
                  ),
                  const YGap(value: 24),
                  const Text("Email Address"),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'johndoe@gmail.com',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: AppColors.hinttext,
                      ),
                    ),
                    controller: emailController,
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
                      if (passwordController.text.length < 8) {
                        return 'Must be atleast 8 characters.';
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible2,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.greys.shade800,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible2 = !_passwordVisible2;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: '**********',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: AppColors.hinttext,
                      ),
                    ),
                    controller: passwordController,
                  ),
                  const YGap(value: 24),
                  const Text("Confirm Password"),
                  const YGap(value: 4),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(removeSpace),
                      ),
                    ],
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please confrim your password";
                      }
                      if (confrimController.text != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.greys.shade800,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'password1234',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: AppColors.hinttext,
                      ),
                    ),
                    controller: confrimController,
                  ),
                  const YGap(value: 24),
                  PrimaryButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authenticationProvider.notifier)
                            .signUp(nameController.text, emailController.text,
                                passwordController.text)
                            .then(
                          (value) {
                            value.fold(
                              (l) => l,
                              (r) {
                                if (r) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Verification(
                                          email: emailController.text),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                    text: "Register",
                  ),
                  const YGap(value: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
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
