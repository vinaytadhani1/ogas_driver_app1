// ignore_for_file: avoid_print, unused_field, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/edit_profile_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/edit_profile_response_model.dart';
import 'package:ogas_driver_app/Model/apis/api_response.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/viewModel/edit_profile_view_model.dart';
import 'package:ogas_driver_app/widgets/background.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:ogas_driver_app/util/loading_dialog.dart';
import 'package:ogas_driver_app/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final TextEditingController fullnamecontroller = TextEditingController();
final TextEditingController emailcontroller = TextEditingController();
final TextEditingController licensecontroller = TextEditingController();
final TextEditingController vehiclecontroller = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? naam;
  String? emaill;
  String? licenseNumberr;
  String? vehicleNumberr;
  String? driverId;
  String? phoneNumber;
  EditProfileViewModel editProfileViewModel = Get.find();
  EditProfileRequestModel editProfileReq = EditProfileRequestModel();
  EditProfileResponseModel? response;
  getprofileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    naam = pref.getString(PrefString.name);
    emaill = pref.getString(PrefString.email);
    licenseNumberr = pref.getString(PrefString.licenseNumber);
    vehicleNumberr = pref.getString(PrefString.vehicleNumber);
    phoneNumber = pref.getString(PrefString.phoneNumber);
    driverId = pref.getString(PrefString.id);
    setState(() {});
    print("++++++========+========++++++");
    fullnamecontroller.text = naam.toString();
    print(fullnamecontroller.text);
    emailcontroller.text = emaill.toString();
    print(emailcontroller.text);
    licensecontroller.text = licenseNumberr.toString();
    print(licensecontroller.text);
    vehiclecontroller.text = vehicleNumberr.toString();
    print(vehiclecontroller.text);
    phoneNumberController.text = phoneNumber.toString();
    print(phoneNumberController.text);
    print("++++++========+========++++++");
  }

  @override
  void initState() {
    super.initState();
    getprofileData();
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        imagename: "asset/icons/drawerList_icon/leftarrow2x.png",
        text: AppLocalizations.of(context)!.profile,
        onTap: () {
          Get.back();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  CustomTextField(
                    controller: fullnamecontroller,
                    mName: AppLocalizations.of(context)!.fullName,
                    hintText: AppLocalizations.of(context)!.john,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailcontroller,
                    validator: (_) {
                      if (!_!.contains('@') || !_.contains('.')) {
                        return AppLocalizations.of(context)!.validEmail;
                      }
                      return null;
                    },
                    mName: AppLocalizations.of(context)!.email,
                    hintText: "johnsmith24@example.com",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: licensecontroller,
                    mName: AppLocalizations.of(context)!.licensenumber,
                    hintText: "211699209",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: vehiclecontroller,
                    mName: AppLocalizations.of(context)!.vehiclenumber,
                    hintText: "5429LK",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: phoneNumberController,
                    mName: AppLocalizations.of(context)!.phoneNumber,
                    hintText: "(+91) 1212121212",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(280, 50),
          primary: const Color(0xff1C75BC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () async {
          showLoadingDialog(context: context);
          if (_form.currentState!.validate()) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString(PrefString.name, fullnamecontroller.text);
            pref.setString(PrefString.email, emailcontroller.text);
            pref.setString(PrefString.vehicleNumber, vehiclecontroller.text);
            pref.setString(PrefString.licenseNumber, licensecontroller.text);
            editProfileReq.driverId = driverId.toString();
            editProfileReq.name = fullnamecontroller.text.toString();
            editProfileReq.mobile = phoneNumberController.text.toString();
            editProfileReq.vehicalNo = vehiclecontroller.text.toString();
            editProfileReq.licenceNo = licensecontroller.text.toString();
            editProfileReq.email = emailcontroller.text.toString();
            setState(() {});
            print(editProfileReq.toJson());
            FocusScope.of(context).unfocus();
            await editProfileViewModel.editProfile(editProfileReq);
            if (editProfileViewModel.editProfileApiResponse.status ==
                Status.COMPLETE) {
              EditProfileResponseModel response =
                  editProfileViewModel.editProfileApiResponse.data;
              print('EDIT PROFILE status ${response.success}');

              if (response.success == true) {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(
                    PrefString.email, response.data!.email.toString());
                pref.setString(PrefString.name, response.data!.name.toString());
                pref.setString(PrefString.vehicleNumber,
                    response.data!.vehicleNo.toString());
                pref.setString(PrefString.licenseNumber,
                    response.data!.licenceNo.toString());
                pref.setString(
                    PrefString.phoneNumber, response.data!.mobile.toString());

                Get.showSnackbar(GetSnackBar(
                  backgroundColor: ColorConstnt.whitegrey,
                  duration: Duration(seconds: 2),
                  snackPosition: SnackPosition.TOP,
                  messageText: Text(
                    'Profile Saved Successfuly',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ));
                hideLoadingDialog(context: context);
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                print('invalid');
              }
              if (response.success == false) {
                Get.showSnackbar(GetSnackBar(
                  backgroundColor: Color(0xffF2F3F2),
                  duration: Duration(seconds: 2),
                  snackPosition: SnackPosition.TOP,
                  messageText: Text(
                    response.message.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ));
                return;
              }
            } else {}
          }
        },
        child: Text(
          AppLocalizations.of(context)!.save,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
