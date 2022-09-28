// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:ogas_driver_app/Model/apiModel/requestModel/login_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/login_response_model.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';

class LoginRepo extends BaseService {
  Future<LoginResponseModel> loginRepo(LoginRequestModel model) async {
    Map<String, dynamic> body = model.toJson();
    print('login Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: loginURL,
      body: body,
    );
    log("login res :$response");
    LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(response);
    print('login res==================>>>$loginResponseModel');

    return loginResponseModel;
  }
}
