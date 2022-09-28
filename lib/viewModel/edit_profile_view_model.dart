// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/edit_profile_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/edit_profile_response_model.dart';
import 'package:ogas_driver_app/Model/repo/edit_profile_repo.dart';

import '../Model/apis/api_response.dart';

class EditProfileViewModel extends GetxController {
  ApiResponse editProfileApiResponse = ApiResponse.initial('Initial');

  /// editProfile...
  Future<void> editProfile(EditProfileRequestModel model) async {
    editProfileApiResponse = ApiResponse.loading('Loading');
    update();
    print('edit profile Status :${editProfileApiResponse.status}');

    try {
      EditProfileResponseModel response =
          await EditProfileRepo().editProfileRepo(model);
      editProfileApiResponse = ApiResponse.complete(response);
      print("editProfileApiResponse RES:$response");
    } catch (e) {
      print('editProfileApiResponse.....$e');
      EditProfileResponseModel response =
          await EditProfileRepo().editProfileRepo(model);
      editProfileApiResponse = ApiResponse.complete(response);
      print("editProfileApiResponse RES:$response");

      editProfileApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
