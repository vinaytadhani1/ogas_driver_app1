// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/all_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/all_order_response_model.dart';
import 'package:ogas_driver_app/Model/repo/all_order_repo.dart';
import '../Model/apis/api_response.dart';

class AllOrderViewModel extends GetxController {
  ApiResponse allOrderApiResponse = ApiResponse.initial('Initial');

  /// allOrder...
  Future<void> allOrder(AllOrderRequestModel model) async {
    allOrderApiResponse = ApiResponse.loading('Loading');
    update();
    print('allOrder Status :${allOrderApiResponse.status}');
    try {
      AllOrderResponseModel response = await AllOrderRepo().allOrderRepo(model);
      allOrderApiResponse = ApiResponse.complete(response);
      print("allOrderApiResponse RES:$response");
    } catch (e) {
      print('allOrderApiResponse.....$e');
      AllOrderResponseModel response = await AllOrderRepo().allOrderRepo(model);
      allOrderApiResponse = ApiResponse.complete(response);
      print("allOrderApiResponse RES:$response");

      allOrderApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
