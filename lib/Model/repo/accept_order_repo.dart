// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:ogas_driver_app/Model/apiModel/requestModel/accept_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/accept_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptOrderRepo extends BaseService {
  Future<AcceptOrderResponseModel> acceptOrderRepo(AcceptOrderRequestModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print('************$token');
    var body = model.toJson();
    print('acceptOrder Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: acceptOrderURL,
      body: body,
    );
    log("acceptOrder res :$response");
    AcceptOrderResponseModel acceptOrderResponseModel = AcceptOrderResponseModel.fromJson(response);
    print('acceptOrder res==================>>>$acceptOrderResponseModel');

    return acceptOrderResponseModel;
  }
}
