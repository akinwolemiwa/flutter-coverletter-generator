import 'package:coverletter/main.dart';
import 'package:coverletter/src/config/formatter/formatter.dart';
import 'package:coverletter/src/config/network/network.dart';
import 'package:coverletter/src/config/storage/storage.dart';
import 'package:coverletter/src/cv-upload/models/upload_model.dart';
import 'package:coverletter/src/history/model/cv.dart';
import 'package:coverletter/src/pdf-download-preview/views/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

final historyProvider = StateNotifierProvider<HistoryService, List>((ref) {
  return HistoryService(ref);
});

final getHistProvider = StateProvider<List<CoverLetter>>((ref) => []);

class HistoryService extends StateNotifier<List> {
  HistoryService(this.ref) : super([]) {
    formatter = NetworkFormatter();
    networkImpl = NetworkImpl();
    storage = Storage();
  }

  final Ref ref;
  List<CoverLetter> cvs = [];

  late NetworkFormatter formatter;
  late NetworkImpl networkImpl;
  late Storage storage;

  Future<void> getHistory() async {
    var res = await formatter.fmt(() async {
      return await networkImpl.get(
        '/api/v1/template',
        token: storage.get('TOKEN'),
      );
    });

    res.fold((l) => l, (r) {
      cvs.clear();

      Navigator.of(navKey.currentContext!).pop();
      var data = r['data'] as List;

      for (var e in data) {
        cvs.add(CoverLetter.fromJson(e));
      }
      //Riverpod does not rebuild list, because it point to the same place in memory, we have to pass a new list
      ref.read(getHistProvider.notifier).update((state) => [...cvs]);
    });
  }

  Future<void> deleteHistory(String id) async {
    var res = await formatter.fmt(() async {
      return networkImpl.delete(
        '/api/v1/coverLetter/$id',
        storage.get('TOKEN'),
      );
    });
    res.fold((l) => l, (r) {
      Navigator.of(navKey.currentContext!).pop();
      getHistory();
    });
  }

  Future<void> downlaod(CoverLetter cv, BuildContext context) async {
    ref
        .read(generatedCoverLetter.notifier)
        .update((state) => GeneratedLetter(cv.coverLetter ?? ''));

    var cvInfo = UploadCVInfo(
      companyName: cv.companyName ?? '',
      companyAddress: cv.companyAddress ?? '',
      city: cv.city ?? '',
      country: cv.country ?? '',
      role: cv.role ?? '',
      yearsOfExp: cv.yearsOfExp ?? '',
      date: cv.date ?? '',
      recipientName: cv.recipientName ?? '',
      recipientDepartment: cv.recipientDepartment ?? '',
      recipientEmail: cv.recipientEmail ?? '',
      recipientPhoneNo: cv.recipientPhoneNo ?? '',
      fileName: '',
      filePath: '',
    );

    ref.read(userInfoData.notifier).update((state) => cvInfo);

    pushNewScreen(
      context,
      screen: const PdfHome(fromHistory: true),
    );
  }
}
