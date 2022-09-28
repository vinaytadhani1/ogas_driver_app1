// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:ogas_driver_app/Model/apiModel/requestModel/signup_request_model.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';

import '../apiModel/responseModel/signup_response_model.dart';

class SignupRepo extends BaseService {
  Future<SignupResponseModel> signupRepo(SignupRequestModel model) async {
    Map<String, dynamic> body = model.toJson();
    print('signup Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: signupURL,
      body: body,
    );
    log("signup res :$response");
    SignupResponseModel signupResponseModel =
        SignupResponseModel.fromJson(response);
    print('signup res==================>>>$signupResponseModel');

    return signupResponseModel;
  }
}
