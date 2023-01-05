import 'dart:developer';
import 'dart:io';

import 'package:coverletter/main.dart';
import 'package:coverletter/src/auth/models/profil_pic_notifier.dart';
import 'package:coverletter/src/auth/models/user_notifier.dart';
import 'package:coverletter/src/config/formatter/formatter.dart';
import 'package:coverletter/src/config/network/network.dart';
import 'package:coverletter/src/config/storage/storage.dart';
import 'package:coverletter/src/constants/api_urls.dart';
import 'package:coverletter/src/widgets/showdialog.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifer, User>(
        (ref) => AuthenticationNotifer(ref));

class AuthenticationNotifer extends StateNotifier<User> {
  AuthenticationNotifer(this.ref)
      :
        // we probably need to cache their data.
        super(User(name: "Anonymous", email: "unkown@email.com"));

  final Ref ref;
  String? error;

  final network = NetworkImpl();
  final fmt = NetworkFormatter();
  final storage = Storage();
  final googleSignin = GoogleSignIn();

  Future<Either<void, bool>> login(String email, String passowrd) async {
    var response = await fmt.fmt(() async {
      return await network.post(ApiUrls.login,
          form: FormData.fromMap({
            "email": email,
            "password": passowrd,
          }));
    });

    return response.fold((l) => Left(l), (r) async {
      Logger().d(r);
      storage.set('TOKEN', r['token']);

      Logger().d(r);
      ref.read(profilePicProvider.notifier).getPic();
      await network
          .get("${ApiUrls.getUser}${r["user"]}", token: r['token'])
          .then((value) {
        storage.set('EMAIL', value['email']);
        storage.set('NAME', value['name']);
        storage.set('ROLE', value['jobRole']);

        ref.read(userProvider.notifier).update((state) => User(
            name: value["name"],
            email: value['email'],
            role: value['jobRole']));
      });

      return const Right(true);
    });
  }

  Future<Either<void, bool>> signUp(
      String name, String email, String password) async {
    var response = await fmt.fmt(() async {
      return await network.post(ApiUrls.signup,
          form: FormData.fromMap({
            "name": name,
            "email": email,
            "password": password,
          }));
    });

    return response.fold((l) => Left(l), (r) {
      ref
          .read(userProvider.notifier)
          .update((state) => User(name: name, email: email, role: "Unknown"));

      return const Right(true);
    });
  }

  Future<Either<void, bool>> verifyUser(String otp) async {
    var response = await fmt.fmt(() async {
      return await network.post(ApiUrls.verify,
          form: FormData.fromMap({
            'otp': otp,
          }));
    });
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<void, bool>> generateOTP(String email) async {
    var response = await fmt.fmt(() async {
      return await network.post(ApiUrls.generate,
          form: FormData.fromMap({
            "type": "verify",
            "email": email,
          }));
    });
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<void, bool>> forgotPassword(String email) async {
    var response = await fmt.fmt(() async {
      return await network.post(ApiUrls.forgotPassword,
          form: FormData.fromMap({
            "email": email,
          }));
    });
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<void, bool>> validateOTP(String email, String otp) async {
    var response = await fmt.fmt(() async {
      return await network.post(
        ApiUrls.validateOTP,
        form: FormData.fromMap(
          {
            "email": email,
            "otp": otp,
          },
        ),
      );
    });

    return response.fold((l) => Left(l), (r) {
      Navigator.of(navKey.currentContext!).pop();

      Storage().set('TOKEN', r['token']);

      return const Right(true);
    });
  }

  Future<Either<void, bool>> changePassword(
    String email,
    String password,
    String confirmPassword,
  ) async {
    var token = Storage().get('TOKEN');

    var response = await fmt.fmt(() async {
      return await network.post(
        ApiUrls.resetPassword,
        form: FormData.fromMap(
          {
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
          },
        ),
        token: token,
      );
    });

    return response.fold((l) => Left(l), (r) {
      Navigator.of(navKey.currentContext!).pop();
      return const Right(true);
    });
  }

  Future<Either<void, bool>> updateProfile(
    String name,
    String role,
  ) async {
    var token = Storage().get('TOKEN');

    var response = await fmt.fmt(() async {
      return await network.put(
        ApiUrls.updateProfile,
        form: FormData.fromMap(
          {
            "name": name,
            "jobRole": role,
          },
        ),
        token: token,
      );
    });

    return response.fold((l) => Left(l), (r) {
      Navigator.of(navKey.currentContext!).pop();
      return const Right(true);
    });
  }

  Future<Either<void, bool>> googleAuth() async {
    var url = Uri.parse("https://api.coverly.hng.tech/api/v1/auth/google");

    var response = await fmt.fmt(() async {
      if (await canLaunchUrl(
        url,
      )) {
        await launchUrl(url, mode: LaunchMode.inAppWebView);
      } else {
        throw "Failed to open link";
      }
    });

    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<void, bool>> changeProfilePic(var file) async {
    var token = Storage().get('TOKEN');
    String fileName = file.split('/').last;

    var response = await fmt.fmt(() async {
      log("Form changprofile");
      log(fileName);
      return await network.patch(
        ApiUrls.changeProfilepic,
        form: FormData.fromMap(
          {
            'myFile': MultipartFile.fromBytes(
              File(file).readAsBytesSync(),
              filename: fileName,
            ),
          },
        ),
        token: token,
      );
    });

    return response.fold((l) => Left(l), (r) {
      log(r.toString());
      log(r["data"]["profileIconUrl"]);

      ref
          .read(profilePicProvider.notifier)
          .storePic(r["data"]["profileIconUrl"]);
      ShowDialog().show("Profile picture updated", success: true);
      Navigator.of(navKey.currentContext!).pop();
      return const Right(true);
    });
  }

  Future<Either<void, bool>> updatePassword(
      String oldPassword, String password, String confirmPassword) async {
    var token = Storage().get('TOKEN');
    var response = await fmt.fmt(() async {
      return await network.put(
        ApiUrls.updatePassword,
        form: FormData.fromMap(
          {
            'oldPassword': oldPassword,
            'password': password,
            'confirmPassword': confirmPassword,
          },
        ),
        token: token,
      );
    });

    return response.fold((l) => Left(l), (r) {
      Navigator.of(navKey.currentContext!).pop();
      return const Right(true);
    });
  }
}
