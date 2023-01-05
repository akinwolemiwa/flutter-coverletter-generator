import 'package:coverletter/src/cv-upload/models/upload_model.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class PdfTemplateRules {
  Future<pw.Document> build(
    String letter, {
    required UploadCVInfo cvInfo,
    String? email,
    String? name,
  });
}
