// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderCoustomHistory extends StatelessWidget {
  final String? orderNum;
  final String? type;
  final String? orderDate;
  final String? deliverDate;
  final String? smallQty;
  final String? largeQty;
  final String? paymentmethod;
  final String? totalOmr;
  final Color? color;
  final String? orderStatus;
  final String? orderReason;
  final bool? cancel;
  final Widget? child;

  const OrderCoustomHistory(
      {Key? key,
      this.orderNum,
      this.type,
      this.orderDate,
      this.deliverDate,
      this.smallQty,
      this.largeQty,
      this.paymentmethod,
      this.totalOmr,
      this.color,
      this.orderStatus,
      this.orderReason,
      this.child,
      this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 1.0,
            spreadRadius: 0.5,
          ),
          BoxShadow(
            color: Colors.white,
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
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Color(0xFFE5E5E5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderNum.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'total'.tr} :",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$totalOmr OMR",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'orderDate'.tr} :",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$orderDate",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'deliveredOn'.tr} :",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$deliverDate",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'paymentMethod'.tr} :",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$paymentmethod",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          child ?? SizedBox(),
          Divider(
            height: 22,
            thickness: 1,
            color: ColorConstnt.grey.withOpacity(0.3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Text(
                "${'orderstatus'.tr} : ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                orderStatus.toString(),
                style: TextStyle(
                    fontSize: 15, color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          cancel == true
              ? Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${'reason'.tr} :",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        orderReason.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: ColorConstnt.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          const SizedBox(height: 13),
        ],
      ),
    );
  }
}
