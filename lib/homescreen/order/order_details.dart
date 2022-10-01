// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/accept_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/accept_order_response_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/all_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/api_response.dart';
import 'package:ogas_driver_app/homescreen/home.dart';
import 'package:ogas_driver_app/homescreen/order/map_screen.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:ogas_driver_app/viewModel/accept_order_view_model.dart';
import 'package:ogas_driver_app/widgets/background.dart';
import 'package:ogas_driver_app/widgets/grey_shadow_border_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderdetailsPage extends StatefulWidget {
  final List<OrderHistory>? orderHistory;
  final Datum? data;
  const OrderdetailsPage({Key? key, this.orderHistory, this.data})
      : super(key: key);

  @override
  State<OrderdetailsPage> createState() => _OrdedDetailsPageState();
}

class _OrdedDetailsPageState extends State<OrderdetailsPage> {
  AcceptOrderViewModel acceptOrderViewModel = Get.find();
  AcceptOrderRequestModel acceptOrderReq = AcceptOrderRequestModel();
  AcceptOrderResponseModel acceptOrderRes = AcceptOrderResponseModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        imagename: "asset/icons/drawerList_icon/leftarrow2x.png",
        onTap: () {
          Get.back();
        },
        text: 'orderdetails'.tr,
        child: SingleChildScrollView(physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              children: [
                GreyborderCont(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '# ${'newtext'.tr} ${widget.data!.orderId}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: widget.orderHistory?.length,
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.orderHistory?[i].type == '1' ? 'refill'.tr : 'newtext'.tr} ${widget.orderHistory?[i].product?.productName} (${widget.orderHistory?[i].product?.category?.category} kg)",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${'qty'.tr} : ${widget.orderHistory?[i].quantity}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff656565),
                                      height: 1.5),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 230),
                      const Divider(color: ColorConstnt.whitegrey),
                      SizedBox(height: MediaQuery.of(context).size.height / 230),
                      Text('delivereydate'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy').format(widget.data!.date!),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff656565),
                            height: 1.5),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 230),
                      const Divider(color: ColorConstnt.whitegrey),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 230),
                      Text(
                        'deliverytime'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.data!.timeSlot == '1'
                            ? "NOW"
                            : widget.data!.timeSlot == '2'
                                ? "9AM - 12PM"
                                : widget.data!.timeSlot == '3'
                                    ? "12PM - 3PM"
                                    : "3PM - 6PM",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff656565),
                            height: 1.5),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 230),
                      const Divider(color: ColorConstnt.whitegrey),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 230),
                      Text(
                        'locatiion'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${widget.data?.address?.location}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff656565),
                            height: 1.5),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 230),
                      const Divider(color: ColorConstnt.whitegrey),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 230),
                      GestureDetector(
                        onTap: () {
                          Get.to(MapScreen(
                            lat: double.parse(
                                widget.data!.address!.latitude.toString()),
                            long: double.parse(
                                widget.data!.address!.longitude.toString()),
                          ));
                        },
                        child: Text(
                          'viewmap'.tr,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: ColorConstnt.mainorange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(155, 50),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  side: const BorderSide(color: Color(0xffF44336), width: 1.5)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xffF44336),
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(155, 50),
                primary: const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () async {
                acceptOrderReq.orderId = widget.data?.id.toString();
                acceptOrderReq.status = '1';
                await acceptOrderViewModel.acceptOrder(acceptOrderReq);
                if (acceptOrderViewModel.acceptOrderApiResponse.status ==
                    Status.COMPLETE) {
                  AcceptOrderResponseModel response =
                      acceptOrderViewModel.acceptOrderApiResponse.data;
                  print('ACCEPT ORDER status ${response.success}');

                  if (response.success == false) {
                    Get.showSnackbar(GetSnackBar(
                      backgroundColor: Color(0xffF2F3F2),
                      duration: Duration(seconds: 2),
                      snackPosition: SnackPosition.TOP,
                      messageText: Text(
                        response.message.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ));

                    return;
                  }
                  if (response.success == true) {
                    Get.showSnackbar(GetSnackBar(
                      backgroundColor: Color(0xffF2F3F2),
                      duration: Duration(seconds: 2),
                      snackPosition: SnackPosition.TOP,
                      messageText: Text(
                        response.message.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ));

                    Get.offAll(HomePage());

                    print('valid');
                  } else {
                    print('invalid');
                  }
                } else {}
              },
              child: Text(
                'accept'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
