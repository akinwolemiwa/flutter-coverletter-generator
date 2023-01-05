import 'package:coverletter/main.dart';
import 'package:coverletter/src/widgets/loader.dart';
import 'package:coverletter/src/widgets/showdialog.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NetworkFormatter {
  NetworkFormatter();

  Future<Either<void, dynamic>> fmt(Function function) async {
    try {
      MyLoader().show();

      return Right(await function.call());
    } on DioError catch (e) {
      Navigator.pop(navKey.currentContext!);

      if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectTimeout) {
        ShowDialog().show('Connection timed out', success: false);
      }

      if (e.response == null) {
        Logger().d(e.error);

        ShowDialog().show(e.error.toString(), success: false);
      }

      ShowDialog()
          .show(e.response?.data.toString() ?? "Unknow error", success: false);
      Logger().d(e.response ?? "Unknow error");

      return const Left(null);
    } catch (e) {
      Navigator.pop(navKey.currentContext!);

      Logger().d(e);

      ShowDialog().show(e.toString(), success: false);
      return const Left(null);
    }
  }
}
