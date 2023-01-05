import 'dart:async';

import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/pdf-download-preview/model/service/pdf_service.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Downloading extends ConsumerStatefulWidget {
  const Downloading({Key? key}) : super(key: key);

  @override
  ConsumerState<Downloading> createState() => _DownloadingState();
}

class _DownloadingState extends ConsumerState<Downloading> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), _init);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const YGap(value: 24),
          Text(
            'Downloading Cover Letter...',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          const YGap(value: 24),
          Column(
            children: [
              Image.asset(kDownloading),
              const YGap(value: 32),
              Text(
                'Loading...',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          const YGap(value: 24),
          MaterialButton(
            color: const Color(0xFF0652DD),
            onPressed: () {
              timer.cancel();
              Navigator.of(context).pop();
            },
            disabledColor: Colors.grey.shade200,
            disabledTextColor: Colors.black,
            child: Text(
              'Cancel Download',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  FutureOr _init() {
    ref
        .read(pdfProvider.notifier)
        .download()
        .then((_) => Navigator.of(context).pop());
  }
}
