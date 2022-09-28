// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/cancel_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/cancle_order_response_model.dart';
import 'package:ogas_driver_app/Model/repo/cancel_order_repo.dart';
import '../Model/apis/api_response.dart';

class CancelOrderViewModel extends GetxController {
  ApiResponse cancelOrderApiResponse = ApiResponse.initial('Initial');

  /// cancelOrder...
  Future<void> cancelOrder(CancelOrderRequestModel model) async {
    cancelOrderApiResponse = ApiResponse.loading('Loading');
    update();
    print('cancelOrder Status :${cancelOrderApiResponse.status}');
    try {
      CancelOrderResponseModel response = await CancelOrderRepo().cancelOrderRepo(model);
      cancelOrderApiResponse = ApiResponse.complete(response);
      print("cancelOrderApiResponse RES:$response");
    } catch (e) {
      print('cancelOrderApiResponse.....$e');
      CancelOrderResponseModel response = await CancelOrderRepo().cancelOrderRepo(model);
      cancelOrderApiResponse = ApiResponse.complete(response);
      print("cancelOrderApiResponse RES:$response");

      cancelOrderApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
