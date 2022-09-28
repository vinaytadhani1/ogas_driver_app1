// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/accept_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/accept_order_response_model.dart';
import 'package:ogas_driver_app/Model/repo/accept_order_repo.dart';
import '../Model/apis/api_response.dart';

class AcceptOrderViewModel extends GetxController {
  ApiResponse acceptOrderApiResponse = ApiResponse.initial('Initial');

  /// acceptOrder...
  Future<void> acceptOrder(AcceptOrderRequestModel model) async {
    acceptOrderApiResponse = ApiResponse.loading('Loading');
    update();
    print('acceptOrder Status :${acceptOrderApiResponse.status}');
    try {
      AcceptOrderResponseModel response = await AcceptOrderRepo().acceptOrderRepo(model);
      acceptOrderApiResponse = ApiResponse.complete(response);
      print("acceptOrderApiResponse RES:$response");
    } catch (e) {
      print('acceptOrderApiResponse.....$e');
      AcceptOrderResponseModel response = await AcceptOrderRepo().acceptOrderRepo(model);
      acceptOrderApiResponse = ApiResponse.complete(response);
      print("acceptOrderApiResponse RES:$response");

      acceptOrderApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
