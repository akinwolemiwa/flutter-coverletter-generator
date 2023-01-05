import 'package:coverletter/main.dart';
import 'package:flutter/material.dart';

class MyLoader {
  show() {
    showDialog(
      barrierDismissible: false,
      context: navKey.currentContext!,
      builder: (_) => Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
