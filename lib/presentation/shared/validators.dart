String? validateEmail(String? value, {bool nullable = false}) {
  if (nullable && (value == null || value.trim().isEmpty)) {
    return null;
  } else {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email address';
    }
  }
  if (!value.isValidEmail()) {
    return 'Invalid email';
  }
  return null;
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}

String? emptyField(dynamic value) {
  dynamic trimmedValue = value.trim();
  if (trimmedValue.toString().isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null) return 'This field is required';

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value)
      ? null
      : 'Must include 1 lowercase letter, 1 upper case letter, 1 symbol, 1 number, and be at least 8 characters';
}
