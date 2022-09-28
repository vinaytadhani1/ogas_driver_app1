// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/accept_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/cancel_order_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/accept_order_response_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/cancle_order_response_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/ongoing_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/api_response.dart';
import 'package:ogas_driver_app/homescreen/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ogas_driver_app/homescreen/order/map_screen.dart';
import 'package:ogas_driver_app/homescreen/order_history/order_history.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:ogas_driver_app/viewModel/accept_order_view_model.dart';
import 'package:ogas_driver_app/viewModel/cancel_order_view_model.dart';
import 'package:ogas_driver_app/widgets/background.dart';

class CompleteOrderPage extends StatefulWidget {
  final List<OrderHistory>? orderHistory;
  final OnDatum? data;
  final String? id;
  CompleteOrderPage({Key? key, this.orderHistory, this.data, this.id})
      : super(key: key);

  @override
  State<CompleteOrderPage> createState() => CompleteOrdeStatePage();
}

class CompleteOrdeStatePage extends State<CompleteOrderPage> {
  int? ggvvalue = 0;
  CancelOrderViewModel cancelOrderViewModel = Get.find();
  CancelOrderRequestModel cancelOrderReq = CancelOrderRequestModel();
  CancelOrderResponseModel cancelOrderRes = CancelOrderResponseModel();
  AcceptOrderViewModel acceptOrderViewModel = Get.find();
  AcceptOrderRequestModel acceptOrderReq = AcceptOrderRequestModel();
  AcceptOrderResponseModel acceptOrderRes = AcceptOrderResponseModel();
  @override
  Widget build(BuildContext context) {
    String reason = AppLocalizations.of(context)!.customernotavailableathome;

    return Scaffold(
      body: Background(
        imagename: "asset/icons/drawerList_icon/leftarrow2x.png",
        onTap: () {
          Get.back();
        },
        text: AppLocalizations.of(context)!.orderdetails,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
                top: 50, left: 15, right: 15, bottom: 110),
            child: Container(
              margin: const EdgeInsets.only(top: 7.5, bottom: 7.5),
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 1.0,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Color(0xffE5E5E5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.ongoing} ${widget.data?.orderInvoice}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.omr} : ${widget.data?.total}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.address} : ${widget.data?.address?.location}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff656565),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2.5, crossAxisCount: 2),
                          itemCount: widget.orderHistory?.length,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.orderHistory?[i].type == "1" ? "${AppLocalizations.of(context)!.refill}" : "${AppLocalizations.of(context)!.newtext}"} ${widget.orderHistory?[i].product?.productName} (${widget.orderHistory?[i].product?.category?.category} kg)",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${AppLocalizations.of(context)!.qty} : ${widget.orderHistory?[i].quantity}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff656565),
                                      height: 1.5),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 190),
                        const Divider(color: ColorConstnt.whitegrey),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 190),
                        Text(
                          AppLocalizations.of(context)!.delivereydate,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy').format(widget.data!.date!),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff656565),
                              height: 1.5),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        const Divider(
                          color: ColorConstnt.whitegrey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        Text(
                          AppLocalizations.of(context)!.deliverytime,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.data?.timeSlot == "1"
                              ? "NOW"
                              : widget.data?.timeSlot == "2"
                                  ? "9AM - 12PM"
                                  : widget.data?.timeSlot == "3"
                                      ? "12PM - 3PM"
                                      : "3AM - 6PM",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff656565),
                              height: 1.5),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        const Divider(
                          color: ColorConstnt.whitegrey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        Text(
                          AppLocalizations.of(context)!.payment,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.data?.paymentMethod ?? "",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff656565),
                              height: 1.5),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        const Divider(
                          color: ColorConstnt.whitegrey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        Text(
                          AppLocalizations.of(context)!.total,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "OMR : ${widget.data?.total}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff656565),
                              height: 1.5),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 190,
                        ),
                        const Divider(
                          color: ColorConstnt.whitegrey,
                        ),
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
                            AppLocalizations.of(context)!.viewmap,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(130, 50),
                  primary: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  side: BorderSide(color: Color(0xffF44336), width: 1.5)),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!
                                    .selectreasonforcancelorder,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              ListTile(
                                leading: Radio(
                                  value: 0,
                                  groupValue: ggvvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      ggvvalue = 0;
                                      reason = 'Customer not available at home';
                                    });
                                  },
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return ColorConstnt.mainorange;
                                    }
                                    return ColorConstnt.mainorange;
                                  }),
                                ),
                                title: Text(
                                  AppLocalizations.of(context)!
                                      .customernotavailableathome,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Color(0xff656565),
                                  ),
                                ),
                                onTap: (() {
                                  ggvvalue = 0;
                                  reason = 'Customer not available at home';

                                  setState(() {});
                                }),
                              ),
                              ListTile(
                                leading: Radio(
                                  value: 1,
                                  groupValue: ggvvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      ggvvalue = 1;
                                      reason = 'Location not clear';
                                    });
                                  },
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return ColorConstnt.mainorange;
                                    }
                                    return ColorConstnt.mainorange;
                                  }),
                                ),
                                title: Text(
                                  AppLocalizations.of(context)!
                                      .locationnotclear,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Color(0xff656565),
                                  ),
                                ),
                                onTap: (() {
                                  ggvvalue = 1;
                                  reason = 'Location not clear';

                                  setState(() {});
                                }),
                              ),
                              ListTile(
                                leading: Radio(
                                  value: 2,
                                  groupValue: ggvvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      ggvvalue = 2;
                                      reason = 'Other reason';
                                    });
                                  },
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return ColorConstnt.mainorange;
                                    }
                                    return ColorConstnt.mainorange;
                                  }),
                                ),
                                title: Text(
                                  AppLocalizations.of(context)!.otherreason,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Color(0xff7A7A7A),
                                  ),
                                ),
                                onTap: (() {
                                  ggvvalue = 2;
                                  reason = 'Other reason';

                                  setState(() {});
                                }),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      minimumSize: const Size(150, 50),
                                      side: BorderSide(
                                          color: Color(0xff1C75BC), width: 1.5),
                                      primary: Color(0xFFFFFFFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1C75BC),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      minimumSize: const Size(150, 50),
                                      primary: Color(0xff1C75BC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () async {
                                      cancelOrderReq.orderId =
                                          widget.data?.id.toString();
                                      cancelOrderReq.status = '5';
                                      cancelOrderReq.cancelReason = reason;
                                      setState(() {});
                                      await cancelOrderViewModel
                                          .cancelOrder(cancelOrderReq);
                                      if (cancelOrderViewModel
                                              .cancelOrderApiResponse.status ==
                                          Status.COMPLETE) {
                                        CancelOrderResponseModel response =
                                            cancelOrderViewModel
                                                .cancelOrderApiResponse.data;
                                        print(
                                            'CANCEL ORDER status ${response.success}');

                                        if (response.success == false) {
                                          Get.showSnackbar(GetSnackBar(
                                            backgroundColor: Color(0xffF2F3F2),
                                            duration: Duration(seconds: 2),
                                            snackPosition: SnackPosition.TOP,
                                            messageText: Text(
                                              response.message.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ));

                                          Get.offAll(HomePage());
                                          Get.to(OrderHistoryPage());

                                          print('valid');
                                        } else {
                                          print('invalid');
                                        }
                                      } else {}
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.ok,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Text(
                AppLocalizations.of(context)!.cancelorder,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF44336),
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(width: 3),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(130, 50),
                primary: Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () async {
                acceptOrderReq.orderId = widget.data?.id.toString();
                acceptOrderReq.status = widget.data!.status == '1' ? "2" : '4';
                await acceptOrderViewModel.acceptOrder(acceptOrderReq);
                if (acceptOrderViewModel.acceptOrderApiResponse.status ==
                    Status.COMPLETE) {
                  AcceptOrderResponseModel response =
                      acceptOrderViewModel.acceptOrderApiResponse.data;
                  print('DELIVER ORDER status ${response.success}');

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
                        response.data!.status == "4"
                            ? 'Order Delivered'
                            : 'Order is On The Way',
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
                widget.data!.status != '1'
                    ? AppLocalizations.of(context)!.delivered
                    : AppLocalizations.of(context)!
                        .outfordelivery
                        .toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFFFFF),
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
