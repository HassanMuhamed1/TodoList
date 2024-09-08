import 'package:task_todo/db.dart';

extension Validations on String {
  bool isValidEmail() {
    return (contains('@gmail.com') && length > 5);
  }
  bool isValidName() {
    return (length>2);
  }

  bool isValidPassword() {
    return trim().length >= 8 &&
        contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]')) &&
        contains(RegExp(r'[A-Z]'));
  }

}
