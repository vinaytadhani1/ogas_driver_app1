// ignore_for_file: avoid_print, unnecessary_cast

import 'package:ogas_driver_app/Model/apiModel/requestModel/edit_profile_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/edit_profile_response_model.dart';
import 'package:ogas_driver_app/Model/services/api_service.dart';
import 'package:ogas_driver_app/Model/services/base_service.dart';

class EditProfileRepo extends BaseService {
  Future<EditProfileResponseModel> editProfileRepo(
      EditProfileRequestModel model) async {
    Map<String, dynamic> body = model.toJson() as Map<String, dynamic>;
    print('edit profile Req :$body');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: editProfileURL,
      body: body as Map<String, dynamic>,
    );
    print("edit profile res :$response");
    print("edit profile body :$body");
    EditProfileResponseModel editProfileResponseModel =
        EditProfileResponseModel.fromJson(response);
    print('edit profile res==================>>>$editProfileResponseModel');

    return editProfileResponseModel;
  }
}
