import 'package:shared_preferences/shared_preferences.dart';

const String _hasSeenOnboardingKey = 'hasSeenOnboardingKey';

class Storage {
  static final Storage _instance = Storage._internal();
  late SharedPreferences sharedPreferences;

  factory Storage() {
    return _instance;
  }

  Storage._internal() {
    getSharedPreferencesInstance();
  }

  getSharedPreferencesInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool get hasSeenOnboarding => _read(_hasSeenOnboardingKey) ?? false;

  set<T>(String key, T content) {
    _write(key, content);
  }

  get<T>(String key) {
    return _read(key);
  }

  set hasSeenOnboarding(bool hasSeenOnboarding) {
    _write(_hasSeenOnboardingKey, hasSeenOnboarding);
  }

  dynamic _read(String key) {
    var value = sharedPreferences.get(key);
    return value;
  }

  void _write<T>(String key, T content) {
    if (content is String) {
      sharedPreferences.setString(key, content);
    }
    if (content is bool) {
      sharedPreferences.setBool(key, content);
    }
    if (content is int) {
      sharedPreferences.setInt(key, content);
    }
    if (content is double) {
      sharedPreferences.setDouble(key, content);
    }
    if (content is List<String>) {
      sharedPreferences.setStringList(key, content);
    }
  }
}
