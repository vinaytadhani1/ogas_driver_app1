// To parse this JSON data, do
//
//     final editProfileResponseModel = editProfileResponseModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

EditProfileResponseModel editProfileResponseModelFromJson(String str) =>
    EditProfileResponseModel.fromJson(json.decode(str));

String editProfileResponseModelToJson(EditProfileResponseModel data) =>
    json.encode(data.toJson());

class EditProfileResponseModel {
  EditProfileResponseModel({
    this.success,
    this.data,
    this.message,
  });

  final bool? success;
  final Data? data;
  final String? message;

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      EditProfileResponseModel(
        success: json["success"] == null ? true : json["success"],
        data: json["success"] == false ? Data() : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data?.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.licenceNo,
    this.vehicleNo,
    this.deviceToken,
    this.deviceType,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? licenceNo;
  final String? vehicleNo;
  final dynamic deviceToken;
  final dynamic deviceType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? 'null' : json["name"],
        mobile: json["mobile"] == null ? 'null' : json["mobile"],
        email: json["email"] == null ? 'null' : json["email"],
        licenceNo: json["licence_no"] == null ? 'null' : json["licence_no"],
        vehicleNo: json["vehicle_no"] == null ? 'null' : json["vehicle_no"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? 'null' : name,
        "mobile": mobile == null ? 'null' : mobile,
        "email": email == null ? 'null' : email,
        "licence_no": licenceNo == null ? 'null' : licenceNo,
        "vehicle_no": vehicleNo == null ? 'null' : vehicleNo,
        "device_token": deviceToken,
        "device_type": deviceType,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
