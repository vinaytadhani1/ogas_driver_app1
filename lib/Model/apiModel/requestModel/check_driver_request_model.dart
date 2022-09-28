class CheckDriverRequestModel {
  String? mobile;

  CheckDriverRequestModel({
    this.mobile,
  });
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
    };
  }
}
