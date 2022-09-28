class SignupRequestModel {
  String? mobile;
  String? name;
  String? email;
  String? licenceNo;
  String? vehicalNo;
  String? deviceToken;

  SignupRequestModel({
    this.mobile,
    this.name,
    this.email,
    this.licenceNo,
    this.vehicalNo,
    this.deviceToken,
  });
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'name': name,
      'email': email,
      'device_token': deviceToken,
      'licence_no': licenceNo,
      'vehicle_no': vehicalNo,
    };
  }
}
