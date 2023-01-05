import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/theme/color.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/primary_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';

class Languages extends StatelessWidget {
  const Languages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Languages',
            style: textTheme.headline4!.copyWith(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const YGap(),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            kEnglish,
                            height: 20.0,
                            width: 20.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const XGap(
                          value: 18,
                        ),
                        Text(
                          "English (UK)",
                          style: textTheme.bodyText1,
                        ),
                        const Spacer(),
                        Checkbox(
                          value: true,
                          onChanged: null,
                          fillColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryMain),
                        ),
                      ],
                    ),
                  ),
                ),
                const YGap(),
                const Text(
                  "The Coverly cover letter generator is currently available in English, and will soon be available in the following languages;",
                ),
                const YGap(),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.disabled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "español",
                          style: TextStyle(color: AppColors.disabled),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.disabled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "português",
                          style: TextStyle(color: AppColors.disabled),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.disabled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Deutsch",
                          style: TextStyle(color: AppColors.disabled),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.disabled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "français",
                          style: TextStyle(color: AppColors.disabled),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.disabled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "italiano",
                          style: TextStyle(color: AppColors.disabled),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.disabled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Polski",
                          style: TextStyle(color: AppColors.disabled),
                        ),
                      ],
                    ),
                  ),
                ),
                const YGap(),
                PrimaryButton(onTap: () {}, text: "Save"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
