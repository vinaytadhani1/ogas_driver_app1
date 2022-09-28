// To parse this JSON data, do
//
//     final signupResponseModel = signupResponseModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) => SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) => json.encode(data.toJson());

class SignupResponseModel {
  SignupResponseModel({
    this.success,
    this.data,
    this.message,
  });

  final bool? success;
  final Data? data;
  final String? message;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) => SignupResponseModel(
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
    this.token,
    this.expiresAt,
    this.user,
  });

  final String? token;
  final DateTime? expiresAt;
  final User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
        expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
        user: json["user"] == null ? User() : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "expires_at": expiresAt == null ? null : expiresAt?.toIso8601String(),
        "user": user == null ? null : user?.toJson(),
      };
}

class User {
  User({
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
    this.status,
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
  final String? status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        email: json["email"] == null ? null : json["email"],
        licenceNo: json["licence_no"] == null ? null : json["licence_no"],
        status: json["status"] == null ? 'null' : json["status"],
        vehicleNo: json["vehicle_no"] == null ? "null" : json["vehicle_no"],
        deviceToken: json["deviceToken"] == null ? 'null' : json["device_token"],
        deviceType: json["device_type"] == null ? "null" : json["device_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "mobile": mobile == null ? null : mobile,
        "email": email == null ? null : email,
        "licence_no": licenceNo == null ? null : licenceNo,
        "vehicle_no": vehicleNo == null ? 'null' : vehicleNo,
        "device_token": deviceToken == null ? 'null' : deviceToken,
        "status": status == null ? 'null' : status,
        "device_type": deviceType == null ? 'null' : deviceType,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
