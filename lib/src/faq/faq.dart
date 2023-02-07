import 'package:coverletter/src/faq/faq_dummy.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FAQs',
            style: textTheme.headlineMedium!.copyWith(fontSize: 16)),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YGap(value: 8),
                  Text(
                    'We are here to help you with anything and everything on Coverly. We have got you covered. Check our frequently asked questions listed below.',
                    style: textTheme.titleMedium!.copyWith(
                      color: AppColors.greys.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const YGap(value: 25),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: const [...dummyFaq],
              ),
            ),
            const YGap(value: 30),
          ],
        ),
      ),
    );
  }
}
