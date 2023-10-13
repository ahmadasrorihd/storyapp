class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Harap masukkan email yang sesuai.';
    } else {
      return null;
    }
  }

  static String? validateText(String value, String type) {
    if (value.isEmpty) {
      return 'Harap masukkan $type';
    } else {
      return null;
    }
  }
}
