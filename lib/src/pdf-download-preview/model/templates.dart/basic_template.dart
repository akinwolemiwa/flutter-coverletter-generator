import 'package:coverletter/src/cv-upload/models/upload_model.dart';
import 'package:coverletter/src/pdf-download-preview/model/templates.dart/pdf_templates_rules.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BasicTemplate extends PdfTemplateRules {
  @override
  Future<pw.Document> build(
    String letter, {
    required UploadCVInfo cvInfo,
    String? email,
    String? name,
  }) async {
    final pdf = pw.Document();

    // var manropeBold = await PdfGoogleFonts.manropeBold();
    // var manropeRegular = await PdfGoogleFonts.manropeRegular();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return _body(
            context,
            body: letter,
            cvInfo: cvInfo,
          );
        },
        header: (context) => _header(
          context,
          cvInfo: cvInfo,
          email: email ?? '',
          name: name ?? '',
        ),
        footer: (context) => _footer(context),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        pageFormat: PdfPageFormat.a4,
        // theme: pw.ThemeData.withFont(
        //   base: manropeRegular,
        //   bold: manropeBold,
        // ),
      ),
    );

    return pdf;
  }

  pw.Container _header(
    pw.Context context, {
    required UploadCVInfo cvInfo,
    required String email,
    required String name,
  }) {
    return pw.Container(
      child: pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    pw.Text(
                      '',
                      maxLines: 1,
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      email,
                      maxLines: 1,
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                  child: pw.Text(
                    name,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            width: double.infinity,
            height: 6,
            decoration: const pw.BoxDecoration(color: PdfColors.blue900),
          ),
        ],
      ),
    );
  }

  pw.Row _footer(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 2,
          width: 50,
          color: PdfColors.grey,
        ),
        pw.Spacer(),
        pw.Container(
          height: 50,
          width: 2,
          color: PdfColors.grey,
        ),
      ],
    );
  }

  List<pw.Widget> _body(
    pw.Context context, {
    required String body,
    required UploadCVInfo cvInfo,
  }) {
    return [
      pw.SizedBox(height: 40),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Text(
            cvInfo.date,
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            cvInfo.companyAddress,
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.SizedBox(height: 3),
        ],
      ),
      pw.SizedBox(height: 20),
      pw.RichText(
        text: pw.TextSpan(
          style: const pw.TextStyle(fontSize: 14, height: 3),
          children: [
            pw.TextSpan(text: body),
          ],
        ),
      ),
    ];
  }
}
