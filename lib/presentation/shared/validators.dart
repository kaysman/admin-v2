String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a valid email address';
  } else if (!value.isValidEmail()) {
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
