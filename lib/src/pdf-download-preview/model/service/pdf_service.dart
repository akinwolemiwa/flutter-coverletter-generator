import 'package:coverletter/main.dart';
import 'package:coverletter/src/config/formatter/formatter.dart';
import 'package:coverletter/src/config/network/network.dart';
import 'package:coverletter/src/config/storage/storage.dart';
import 'package:coverletter/src/cv-upload/models/upload_model.dart';
import 'package:coverletter/src/history/service/history_service.dart';
import 'package:coverletter/src/pdf-download-preview/model/service/file_service.dart';
import 'package:coverletter/src/pdf-download-preview/model/templates.dart/pdf_templates_rules.dart';
import 'package:coverletter/src/pdf-download-preview/model/templates.dart/basic_template.dart';
import 'package:coverletter/src/pdf-download-preview/model/templates.dart/blank_template.dart';
import 'package:coverletter/src/widgets/showdialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DocumentFormat {
  pdf,
  docx,
  txt,
}

final pdfProvider = StateNotifierProvider<PdfService, int>((ref) {
  return PdfService(ref);
});

class PdfService extends StateNotifier<int> {
  PdfService(this.ref) : super(1) {
    myFileService = MyFileService();
    networkImpl = NetworkImpl();
    formatter = NetworkFormatter();
    storage = Storage();
  }

  final Ref ref;
  var active = 1;
  DocumentFormat? format;
  bool sendToEmail = false;

  late MyFileService myFileService;
  late NetworkImpl networkImpl;
  late NetworkFormatter formatter;
  late Storage storage;

  // this holds all available templates and their unlock status
  final _templates = <Map<bool, PdfTemplateRules>>[
    {
      false: BlankTemplate(),
    },
    {
      true: BasicTemplate(),
    },
    {
      false: BlankTemplate(),
    },
  ];

  // this is providing access to the first unlock status of the active template
  bool get templateStatus => _templates[active].entries.first.key;

  List<Map<bool, PdfTemplateRules>> get templates => _templates;

  Future<Uint8List> readPDF() async {
    // get the active template from the map
    var pc = _templates[active].entries.first.value;
    var cvState = ref.read(generatedCoverLetter.notifier);
    var cvInfo = ref.read(userInfoData.notifier).state;

    var email = storage.get('EMAIL');
    var name = storage.get('NAME');

    return (await pc.build(
      cvState.state.coverLetter,
      cvInfo: cvInfo!,
      email: email,
      name: name,
    ))
        .save();
  }

  Future<void> download() async {
    final cvState = ref.read(generatedCoverLetter.notifier);

    await myFileService.save(
      await readPDF(),
      format ?? DocumentFormat.pdf,
      cvState.state.coverLetter,
    );

    if (sendToEmail) _sendEmail();
  }

  Future<void> _sendEmail() async {
    var token = await storage.get('TOKEN');

    var res = await formatter.fmt(() async {
      return networkImpl.post(
        '/api/v1/sendCoverLetter',
        form: FormData.fromMap({
          'email': storage.get('EMAIL'),
          'file': MultipartFile.fromBytes(await readPDF()),
        }),
        isFormData: true,
        token: token,
      );
    });

    res.fold((l) => l, (r) {
      nav.pop();

      ShowDialog().show(r);
    });
  }

  Future<void> saveToProfile() async {
    var cvState = ref.read(generatedCoverLetter.notifier);
    var cvInfo = ref.read(userInfoData.notifier).state;
    var token = await storage.get('TOKEN');

    if (token == null) {
      ShowDialog().show('You need to be an authenticated user');
    } else {
      var info = await cvInfo!.toJson();
      info.remove('myFile');
      info.addAll({
        'cover_letter': cvState.state.coverLetter,
      });

      var form = FormData.fromMap(info);
      var res = await formatter.fmt(() async {
        return await networkImpl.post(
          '/api/v1/saveCoverLetter',
          form: form,
          isFormData: false,
          token: token,
        );
      });

      res.fold((l) => l, (r) async {
        //this update the state of history page
        await ref.read(historyProvider.notifier).getHistory();
        Navigator.of(navKey.currentContext!).pop();

        ShowDialog().show('Cover letter saved to profile');
      });
    }
  }
}
