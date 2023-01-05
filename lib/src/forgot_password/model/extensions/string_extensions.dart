extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidLength {
    final validLengthRegExp = RegExp(r"^.{8,}$");
    return validLengthRegExp.hasMatch(this);
  }

  bool get containsSpecialCharacter {
    final specialCharRegExp = RegExp(r"[a-zA-Z0-9]*[@#$%^&+=]{1}[a-zA-Z0-9]*");
    return specialCharRegExp.hasMatch(this);
  }
}