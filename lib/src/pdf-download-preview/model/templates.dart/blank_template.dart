import 'package:coverletter/src/cv-upload/models/upload_model.dart';
import 'package:coverletter/src/pdf-download-preview/model/templates.dart/pdf_templates_rules.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BlankTemplate extends PdfTemplateRules {
  @override
  Future<pw.Document> build(
    String letter, {
    required UploadCVInfo cvInfo,
     String? email,
     String? name,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return body(context);
        },
        header: (context) => header(context),
        footer: (context) => footer(context),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        pageFormat: PdfPageFormat.a4,
      ),
    );

    return pdf;
  }

  pw.Container header(pw.Context context) {
    return pw.Container();
  }

  pw.Row footer(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [],
    );
  }

  List<pw.Widget> body(pw.Context context) {
    return [];
  }
}
