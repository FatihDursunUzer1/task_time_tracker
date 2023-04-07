class Validators {
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@')) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? validatePasswordAgain(String? value, String? password) {
    if (value != password) {
      return 'Passwords do not match';
    }
  }

  static String? checkEmptyText(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
  }
}
