// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/check_driver_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/check_driver_response_model.dart';
import 'package:ogas_driver_app/Model/repo/check_driver_repo.dart';
import '../Model/apis/api_response.dart';

class CheckDriverViewModel extends GetxController {
  ApiResponse checkDriverApiResponse = ApiResponse.initial('Initial');

  /// checkDriver...
  Future<void> checkDriver(CheckDriverRequestModel model) async {
    checkDriverApiResponse = ApiResponse.loading('Loading');
    update();
    print('checkDriver Status :${checkDriverApiResponse.status}');
    try {
      CheckDriverResponseModel response =
          await CheckDriverRepo().checkDriverRepo(model);
      checkDriverApiResponse = ApiResponse.complete(response);
      print("checkDriverApiResponse RES:$response");
    } catch (e) {
      print('checkDriverApiResponse.....$e');
      CheckDriverResponseModel response =
          await CheckDriverRepo().checkDriverRepo(model);
      checkDriverApiResponse = ApiResponse.complete(response);
      print("checkDriverApiResponse RES:$response");

      checkDriverApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
