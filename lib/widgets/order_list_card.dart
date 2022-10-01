// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:ogas_driver_app/widgets/grey_shadow_border_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderListCard extends StatelessWidget {
  final String? orderNumber;
  final String? omr;
  final String? address;
  final void Function()? onTap;
  const OrderListCard(
      {Key? key, this.orderNumber, this.omr, this.address, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GreyborderCont(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 15,
        ),
        height: MediaQuery.of(context).size.height / 8.0,
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  orderNumber.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OMR : ${omr.toString()}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff656565),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${'address'.tr} : ${address.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,

                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xff656565),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: ColorConstnt.mainorange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'orderdetails'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstnt.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
