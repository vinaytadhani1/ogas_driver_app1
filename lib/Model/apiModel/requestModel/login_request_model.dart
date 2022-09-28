class LoginRequestModel {
  String? mobile;

  LoginRequestModel({
    this.mobile,
  });
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
    };
  }
}
