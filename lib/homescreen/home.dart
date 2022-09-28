// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogas_driver_app/Model/apiModel/responseModel/all_order_response_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/ongoing_order_response_model.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/homescreen/order/complete_order.dart';
import 'package:ogas_driver_app/homescreen/order/order_details.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:ogas_driver_app/util/loading_dialog.dart';
import 'package:ogas_driver_app/widgets/background.dart';
import 'package:ogas_driver_app/widgets/order_list_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldd = GlobalKey();

  List<Datum> data = [];

  List<OnDatum> onData = [];

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print('***************$token');
  }

  LatLng? currentPostion;
  LatLng? orderPosition;

  void getUserLocation() async {
    Geolocator.requestPermission();
    Geolocator.isLocationServiceEnabled().then((value) async {
      if (value == true) {
        var position = await GeolocatorPlatform.instance.getCurrentPosition(
            locationSettings:
                LocationSettings(accuracy: LocationAccuracy.high));

        setState(() {
          currentPostion = LatLng(position.latitude, position.longitude);
        });
        print('*************$currentPostion');
      }
    });
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double totalDistance = 0.0;
  AllOrderResponseModel? allOrderResponse = AllOrderResponseModel();
  OngoingOrderResponseModel? ongoingOrderResponse = OngoingOrderResponseModel();
  
  getNewOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print(token);
    var response = await http.post(
        Uri.parse('http://ogas.adsumoriginator.com/api/orders'),
        headers: {
          'Authorization': token.toString(),
        });
    var body = json.decode(response.body);
    print('*****************');
    print(body);
    if (response.statusCode == 200) {
      allOrderResponse = AllOrderResponseModel.fromJson(body);
      data = allOrderResponse!.data!;
      setState(() {});
    }
  }

  getOngoingOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(PrefString.token);
    print(token);
    var response = await http.get(
      Uri.parse('http://ogas.adsumoriginator.com/api/ongoing-orders'),
      headers: {
        'Authorization': token.toString(),
      },
    );
    var body = json.decode(response.body);
    print('*****************');
    print(body);
    if (response.statusCode == 200) {
      ongoingOrderResponse = OngoingOrderResponseModel.fromJson(body);
      onData = ongoingOrderResponse!.data!;
      setState(() {});
    }
  }

  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      getNewOrders();
      getOngoingOrders();
    });
    setState(() {});
    getUserLocation();
    getNewOrders();
    getOngoingOrders();
    getToken();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final TextEditingController messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawerpage(),
      key: scaffoldd,
      body: RefreshIndicator(
        onRefresh: () async {
          getNewOrders();
          getOngoingOrders();
        },
        child: DefaultTabController(
          length: 2,
          child: Background(
            imagename: "asset/icons/Union.png",
            onTap: () {
              scaffoldd.currentState!.openDrawer();
            },
            text: AppLocalizations.of(context)!.orderdetails,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                  child: TabBar(
                    indicatorColor: ColorConstnt.mainorange,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          "${AppLocalizations.of(context)!.newtext} (${data.length})",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "${AppLocalizations.of(context)!.ongoing} (${onData.length})",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          getNewOrders();
                        },
                        child: data == null || data.isEmpty
                            ? Center(
                                child: Text(
                                  AppLocalizations.of(context)!.noNew,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: data.length,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, i) {
                                  if (currentPostion != null) {
                                    double totalDistance = this.totalDistance +
                                        _coordinateDistance(
                                          double.parse(data[i]
                                              .address!
                                              .latitude
                                              .toString()),
                                          double.parse(data[i]
                                              .address!
                                              .longitude
                                              .toString()),
                                          currentPostion!.latitude,
                                          currentPostion!.latitude,
                                        );
                                    double distanse = GeolocatorPlatform
                                        .instance
                                        .distanceBetween(
                                      double.parse(
                                          data[i].address!.latitude.toString()),
                                      double.parse(data[i]
                                          .address!
                                          .longitude
                                          .toString()),
                                      currentPostion!.latitude,
                                      currentPostion!.latitude,
                                    );
                                    print('distanse***************');
                                    print(distanse);
                                    print(totalDistance);
                                  }
                                  return OrderListCard(
                                    orderNumber:
                                        "${AppLocalizations.of(context)!.newOrder} ${data[i].orderId}",
                                    address: data[i].address?.location,
                                    omr: data[i].total.toString(),
                                    onTap: () {
                                      Get.to(OrderdetailsPage(
                                        orderHistory: data[i].orderHistory,
                                        data: data[i],
                                      ));
                                    },
                                  );
                                },
                              ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          getOngoingOrders();
                        },
                        child: onData == null || onData.isEmpty
                            ? Center(
                                child: Text(
                                  AppLocalizations.of(context)!.noOngoing,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: onData.length,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, i) {
                                  return OrderListCard(
                                    orderNumber:
                                        "${AppLocalizations.of(context)!.ongoingOrder} ${onData[i].orderInvoice}",
                                    address: onData[i].address?.location,
                                    omr: onData[i].total.toString(),
                                    onTap: () {
                                      Get.to(CompleteOrderPage(
                                        data: onData[i],
                                        orderHistory: onData[i].orderHistory,
                                        id: (i + 1).toString(),
                                      ));
                                    },
                                  );
                                },
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
    );
  }
}
