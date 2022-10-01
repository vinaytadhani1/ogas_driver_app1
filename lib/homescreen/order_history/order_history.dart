// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/ongoing_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/util/loading_dialog.dart';
import 'package:ogas_driver_app/widgets/background.dart';
import 'package:ogas_driver_app/widgets/order_history_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;

import '../../util/colors.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  OngoingOrderResponseModel? ongoingOrderResponse = OngoingOrderResponseModel();
  List<OnDatum>? onData;
  getOngoingOrders() async {
    showLoadingDialog(context: context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print(token);
    var response = await http.post(
      Uri.parse('http://ogas.adsumoriginator.com/api/driver-orders'),
      headers: {
        'Authorization': token.toString(),
      },
      body: {"status": ""},
    );
    var body = json.decode(response.body);
    print('*****************');
    print(body);
    if (response.statusCode == 200) {
      ongoingOrderResponse = OngoingOrderResponseModel.fromJson(body);
      onData = ongoingOrderResponse?.data;
      setState(() {});
    }
    hideLoadingDialog(context: context);
  }

  @override
  void initState() {
    getOngoingOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      imagename: "asset/icons/drawerList_icon/leftarrow2x.png",
      text: 'orderHistory'.tr,
      onTap: () {
        Get.back();
      },
      child: onData == null || onData!.isEmpty
          ? Center(
              child: Text(
                'noOrderHistory'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: onData?.length ?? 1,
              shrinkWrap: true,
              itemBuilder: (c, i) {
                return OrderCoustomHistory(
                  orderNum:
                      "# ${'order'.tr} ${onData![i].orderInvoice}",
                  orderDate:
                      '${DateFormat('dd-MM-yyyy').format(onData![i].createdAt!)}',
                  paymentmethod: onData![i].paymentMethod,
                  deliverDate:
                      '${DateFormat('dd-MM-yyyy').format(onData![i].date!)}',
                  totalOmr: "${onData?[i].total}",
                  smallQty: "2",
                  largeQty: "1",
                  orderStatus:
                      "${onData?[i].status == "5" ? 'orderStatus5'.tr : onData?[i].status == "4" ? 'orderStatus4'.tr : onData?[i].status == "0" ? 'orderStatus0'.tr : onData?[i].status == "1" ? 'orderStatus1'.tr : 'orderStatus2'.tr}",
                  color:
                      onData?[i].status == "5" ? Colors.red : Color(0xff4CAF50),
                  orderReason: onData?[i].cancelReason,
                  child: onData![i].orderHistory!.isEmpty ||
                          onData![i].orderHistory == null ||
                          onData![i].orderHistory == []
                      ? SizedBox()
                      : ListView.builder(
                          itemCount: onData![i].orderHistory?.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (c, i2) {
                            return Container(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${onData![i].orderHistory![i2].product?.productName} (${onData![i].orderHistory![i2].product?.category?.category} Kg)",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${'qty'.tr} : ${onData![i].orderHistory![i2].quantity}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff656565),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }),
                );
              }),
    );
  }
}
