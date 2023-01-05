import 'dart:io';
import 'dart:typed_data';

import 'package:coverletter/src/pdf-download-preview/model/service/pdf_service.dart';
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyFileService {
  Future<void> _saveFile(
    List<int> byte,
    String name, {
    DocumentFormat format = DocumentFormat.pdf,
    String coverContent = '',
  }) async {
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (Platform.isIOS || Platform.isAndroid) {
      late Uint8List data;
      late MimeType type;

      switch (format) {
        case DocumentFormat.pdf:
          data = Uint8List.fromList(byte);
          type = MimeType.PDF;
          break;
        case DocumentFormat.docx:
          data = (await _docx(Uint8List.fromList(byte))).readAsBytesSync();
          type = MimeType.MICROSOFTWORD;
          break;
        case DocumentFormat.txt:
          data = (await _txt(coverContent)).readAsBytesSync();
          type = MimeType.TEXT;
          break;
      }

      // the formats selected are used to create the final file here
      await FileSaver.instance.saveAs(name, data, format.name, type);
    }
  }

  Future<void> save(
    Uint8List uint8list,
    DocumentFormat format,
    String content,
  ) async {
    var date = DateTime.now();

    await _saveFile(
      uint8list,
      'Cover-letter_${date.day}_${date.minute}_${date.second}_${date.millisecondsSinceEpoch}',
      format: format,
      coverContent: content,
    );
  }

  Future<File> _docx(Uint8List uint8list) async {
    final Directory directory = await getTemporaryDirectory();

    final File file = File(
      '${directory.path}/${DateTime.now().toIso8601String()}.doc',
    );

    await file.writeAsBytes(uint8list);

    return file;
  }

  Future<File> _txt(String text) async {
    final Directory directory = await getTemporaryDirectory();

    final File file = File(
      '${directory.path}/${DateTime.now().toIso8601String()}.txt',
    );

    await file.writeAsString(text);

    return file;
  }
}
