import 'package:coverletter/src/history/cover_letters.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'History',
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.header,
          ),
        ),
      ),
      body: const CoverLetters(),
    );
  }
}
