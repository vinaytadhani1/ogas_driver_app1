// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/login_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/login_response_model.dart';
import 'package:ogas_driver_app/Model/repo/login_repo.dart';
import '../Model/apis/api_response.dart';

class LoginViewModel extends GetxController {
  ApiResponse loginApiResponse = ApiResponse.initial('Initial');

  /// login...
  Future<void> login(LoginRequestModel model) async {
    loginApiResponse = ApiResponse.loading('Loading');
    update();
    print('login Status :${loginApiResponse.status}');
    try {
      LoginResponseModel response = await LoginRepo().loginRepo(model);
      loginApiResponse = ApiResponse.complete(response);
      print("loginApiResponse RES:$response");
    } catch (e) {
      print('loginApiResponse.....$e');
      LoginResponseModel response = await LoginRepo().loginRepo(model);
      loginApiResponse = ApiResponse.complete(response);
      print("loginApiResponse RES:$response");

      loginApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
