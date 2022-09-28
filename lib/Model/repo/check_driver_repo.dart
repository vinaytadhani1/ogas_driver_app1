// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:ogas_driver_app/Model/apiModel/requestModel/check_driver_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/check_driver_response_model.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';

class CheckDriverRepo extends BaseService {
  Future<CheckDriverResponseModel> checkDriverRepo(
      CheckDriverRequestModel model) async {
    Map<String, dynamic> body = model.toJson();
    print('checkDriver Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: checkDriverURL,
      body: body,
    );
    log("checkDriver res :$response");
    CheckDriverResponseModel checkDriverResponseModel =
        CheckDriverResponseModel.fromJson(response);
    print('checkDriver res==================>>>$checkDriverResponseModel');

    return checkDriverResponseModel;
  }
}
