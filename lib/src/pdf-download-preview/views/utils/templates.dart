import 'package:coverletter/src/constants/assets.dart';
import 'package:coverletter/src/pdf-download-preview/model/service/pdf_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

templates(
  PdfService state, {
  required bool active,
  required Uint8List data,
  required bool templateStatus,
}) {
  final double top = active ? 0 : 30;

  return AnimatedContainer(
    width: double.infinity,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeOutQuint,
    margin: EdgeInsets.only(top: top),
    child: Stack(
      children: [
        Align(
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 50,
            ),
            child: state.active == 1
                ? PdfPreview(
                    build: (format) => data,
                    allowPrinting: false,
                    allowSharing: false,
                    useActions: false,
                    previewPageMargin: EdgeInsets.zero,
                    maxPageWidth: double.infinity,
                    shouldRepaint: true,
                    padding: EdgeInsets.zero,
                    dpi: 120,
                    loadingWidget: const CircularProgressIndicator(),
                    pdfPreviewPageDecoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    initialPageFormat: const PdfPageFormat(
                      double.infinity,
                      double.maxFinite,
                    ),
                  )
                : Image.asset(
                    state.active == 0 ? kDummyTemplate1 : kDummyTemplate2,
                  ),
          ),
        ),
      ],
    ),
  );
}
