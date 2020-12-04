

class Utils {

  static bool isMinLetter(String text, int i) {
    return text.length > i;
  }

  static bool isUppercase(String text) {
    return text.contains(new RegExp(r'[A-Z]'));
  }

  static bool isCharacter(String text) {
    return text.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }



  static bool hasDigits(String text) {
    return text.contains(new RegExp(r'[0-9]'));
  }


}
