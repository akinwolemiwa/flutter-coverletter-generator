import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:coverletter/src/widgets/steps_card.dart';
import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'How It Works',
            style: textTheme.headlineMedium!.copyWith(fontSize: 18),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  'Generate your cover letter in 4 simple steps.',
                  style: textTheme.displayMedium!.copyWith(
                    fontSize: 27,
                  ),
                ),
                const YGap(value: 10),
                //list of tiles
                const StepsCard(
                  number: '1',
                  icon: kCvUploadFill,
                  text: 'Upload your CV or resume',
                ),
                const StepsCard(
                  number: '2',
                  icon: kAdditionalInfoFill,
                  text: 'Input Additional Information',
                ),
                const StepsCard(
                  number: '3',
                  icon: kGenCoverLetterFill,
                  text: 'Generate Your Cover letter',
                ),
                const StepsCard(
                  number: '4',
                  icon: kDocDownloadFill,
                  text: 'Download and Save Your Cover letter',
                ),
                const YGap(value: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
