class InputFieldValidation {
  bool emailValidation(String? email) {
    if (email == null) return false;
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    bool matched = emailRegEx.hasMatch(email);
    return matched;
  }

  String? passwordValidation(String? pass) {
    if (pass == null) return 'Password field can\'t be empty';
    if (pass.length < 6) return 'Password length must be greater than 5';
    if (pass.contains(' ', 0)) return 'Password text can\'t contain space';
    return null;
  }

  String? nameValidation(String? text) {
    if (text == null || text.isEmpty) return 'Name field can\'t be empty';
    return null;
  }

  String? otpValidation(String otp) {
    if (otp.contains(' ', 0)) return 'OTP text can\'t contain space';
    return null;
  }
}
