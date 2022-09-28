// To parse this JSON data, do
//
//     final checkDriverResponseModel = checkDriverResponseModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

CheckDriverResponseModel checkDriverResponseModelFromJson(String str) =>
    CheckDriverResponseModel.fromJson(json.decode(str));

String checkDriverResponseModelToJson(CheckDriverResponseModel data) =>
    json.encode(data.toJson());

class CheckDriverResponseModel {
  CheckDriverResponseModel({
    this.success,
    this.message,
  });

  final bool? success;
  final String? message;

  factory CheckDriverResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckDriverResponseModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
      };
}
