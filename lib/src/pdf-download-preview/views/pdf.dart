import 'package:coverletter/src/cv-upload/views/home_page.dart';
import 'package:coverletter/src/pdf-download-preview/model/service/pdf_service.dart';
import 'package:coverletter/src/pdf-download-preview/views/utils/download_button.dart';
import 'package:coverletter/src/pdf-download-preview/views/utils/templates.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:coverletter/src/widgets/outline_button.dart';
import 'package:coverletter/src/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class PdfHome extends ConsumerStatefulWidget {
  const PdfHome({
    Key? key,
    this.fromHistory = false,
  }) : super(key: key);

  final bool fromHistory;

  @override
  ConsumerState<PdfHome> createState() => _PdfHomeState();
}

class _PdfHomeState extends ConsumerState<PdfHome> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(
      viewportFraction: .9,
      initialPage: 1,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(pdfProvider.notifier);

    return WillPopScope(
      onWillPop: () {
        pushNewScreen(context, screen: const HomePage());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your Information has been updated.',
                style: textTheme.headline3,
              ),
              const YGap(value: 20),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      state.active = value;
                    });
                  },
                  children: [
                    for (var i = 0; i < state.templates.length; i++)
                      FutureBuilder(
                        future: state.readPDF(),
                        builder: (_, s) => s.connectionState ==
                                ConnectionState.waiting
                            ? const Center(child: CircularProgressIndicator())
                            : templates(
                                state,
                                active: state.active == i,
                                data: s.data!,
                                templateStatus: state.templateStatus,
                              ),
                      ),
                  ],
                ),
              ),
              const YGap(value: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  downloadButton(active: state.templateStatus),
                  const YGap(value: 8),
                  if (!widget.fromHistory)
                    OutlineButton(
                      onTap: state.templateStatus
                          ? () => state.saveToProfile()
                          : null,
                      btnText: 'Save to profile',
                    ),
                  const YGap(value: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
