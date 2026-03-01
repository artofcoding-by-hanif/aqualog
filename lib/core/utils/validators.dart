/// Input validators

class Validators {
  Validators._();

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? positiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final number = double.tryParse(value);
    if (number == null || number <= 0) {
      return 'Please enter a valid positive number';
    }
    return null;
  }

  static String? minLength(String? value, int minLength) {
    if (value == null || value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength) {
    if (value != null && value.length > maxLength) {
      return 'Must be at most $maxLength characters';
    }
    return null;
  }

  static String? range(String? value, double min, double max) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final number = double.tryParse(value);
    if (number == null || number < min || number > max) {
      return 'Must be between $min and $max';
    }
    return null;
  }
}

