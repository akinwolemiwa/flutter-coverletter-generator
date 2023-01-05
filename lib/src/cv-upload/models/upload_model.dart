import 'dart:io';

import 'package:coverletter/main.dart';
import 'package:coverletter/src/config/formatter/formatter.dart';
import 'package:coverletter/src/config/network/network.dart';
import 'package:coverletter/src/constants/api_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class UploadCVInfo {
  UploadCVInfo({
    required this.companyName,
    required this.companyAddress,
    required this.city,
    required this.country,
    required this.role,
    required this.yearsOfExp,
    required this.date,
    required this.recipientName,
    required this.recipientDepartment,
    required this.recipientEmail,
    required this.recipientPhoneNo,
    required this.fileName,
    required this.filePath,
  });

  final String companyName;
  final String companyAddress;
  final String city;
  final String country;
  final String role;
  final String yearsOfExp;
  final String date;
  final String recipientName;
  final String recipientDepartment;
  final String recipientEmail;
  final String recipientPhoneNo;

  final String filePath;
  final String fileName;

  factory UploadCVInfo.fromJson(Map<String, dynamic> map) {
    return UploadCVInfo(
      companyName: map['company_name'],
      companyAddress: map['company_address'],
      city: map['city'],
      country: map['country'],
      role: map['role'],
      yearsOfExp: map['years_of_exp'],
      date: map['date'],
      recipientName: map['recipient_name'],
      recipientDepartment: map['recipient_department'],
      recipientEmail: map['recipient_email'],
      recipientPhoneNo: map['recipient_phone_no'],
      fileName: map['file_name'] ?? '',
      filePath: map['file_path'] ?? '',
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      "company_name": companyName,
      "company_address": companyAddress,
      "city": city,
      "country": country,
      "role": role,
      "years_of_exp": yearsOfExp,
      "date": date,
      "recipient_name": recipientName,
      "recipient_department": recipientDepartment,
      "recipient_email": recipientEmail,
      "recipient_phone_no": recipientPhoneNo,
      "myFile": MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: fileName,
      ),
    };
  }
}

class GeneratedLetter {
  GeneratedLetter(this.coverLetter);

  final String coverLetter;
}

// Ogene gets the generated letter from here.
final generatedCoverLetter =
    StateProvider<GeneratedLetter>((ref) => GeneratedLetter(""));

final userInfoData = StateProvider<UploadCVInfo?>((ref) => null);

final uploadCVProvider =
    FutureProvider.family<GeneratedLetter, Map<String, dynamic>>(
        (ref, data) async {
  final network = NetworkImpl();
  final fmt = NetworkFormatter();

  FormData formData = FormData.fromMap(data);

  var response = await fmt.fmt(() async {
    return await network.post(
      ApiUrls.generateCoverLetter,
      isFormData: true,
      form: formData,
    );
  });

  // ignore: prefer_typing_uninitialized_variables
  var dataPoint;

  response.fold((l) => Left(l), (r) {
    Logger().d(r);

    dataPoint = r["data"];
    Navigator.of(navKey.currentContext!).pop();
  });

  var result = GeneratedLetter(dataPoint['cover_letter']);

  ref.read(generatedCoverLetter.notifier).update((state) => result);

  return result;
});
