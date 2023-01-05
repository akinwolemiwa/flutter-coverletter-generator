


import 'package:coverletter/src/config/storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profilePicProvider = StateNotifierProvider<ProfilePic, String? >((ref) {
  return ProfilePic();
});

class ProfilePic extends StateNotifier<String?> {
  ProfilePic() : super(null);

  final Storage _storage = Storage();

  storePic(String picture) {
    state = picture;
    _storage.set("pic", picture);
  }

  void getPic() {
    final String? picUrl = _storage.get('pic');
    state = picUrl;
  }
}
