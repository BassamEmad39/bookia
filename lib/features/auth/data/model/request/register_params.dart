class RegisterParams {
  String? name,
      email,
      password,
      passwordConfirmation,
      verifyCode,
      newPassword,
      newPasswordConfirmation;

  RegisterParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.verifyCode,
    this.newPassword,
    this.newPasswordConfirmation,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'verify_code': verifyCode,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
    };
  }
}
