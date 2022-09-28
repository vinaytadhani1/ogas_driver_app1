// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:ogas_driver_app/Model/apiModel/requestModel/cancel_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/cancle_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancelOrderRepo extends BaseService {
  Future<CancelOrderResponseModel> cancelOrderRepo(
      CancelOrderRequestModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print('************$token');
    var body = model.toJson();
    print('cancelOrder Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: cancelOrderURL,
      body: body,
    );
    log("cancelOrder res :$response");
    CancelOrderResponseModel cancelOrderResponseModel =
        CancelOrderResponseModel.fromJson(response);
    print('cancelOrder res==================>>>$cancelOrderResponseModel');

    return cancelOrderResponseModel;
  }
}
