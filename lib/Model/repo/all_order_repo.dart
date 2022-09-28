// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:ogas_driver_app/Model/apiModel/requestModel/all_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/all_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllOrderRepo extends BaseService {
  Future<AllOrderResponseModel> allOrderRepo(AllOrderRequestModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print('************$token');
    var body = {"": ""};
    print('allOrder Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: allOrderURL,
      headers: {
        "Authorization": token.toString(),
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        HttpHeaders.acceptHeader: "application/json",
      },
      // body: body,
    );
    log("allOrder res :$response");
    AllOrderResponseModel allOrderResponseModel = AllOrderResponseModel.fromJson(response);
    print('allOrder res==================>>>$allOrderResponseModel');

    return allOrderResponseModel;
  }
}
