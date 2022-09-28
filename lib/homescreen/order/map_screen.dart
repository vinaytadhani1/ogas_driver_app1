// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use, unnecessary_null_comparison, depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_collection_literals

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/edit_profile_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/edit_profile_response_model.dart';
import 'package:ogas_driver_app/Model/apis/api_response.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/viewModel/edit_profile_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  final double? lat;
  final double? long;
  const MapScreen({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

String googleApikey = "AIzaSyAcC0VIBTRTqLZZZMs97SNy8_lJhjEoDXA";

CameraPosition? cameraPosition;
Set<Circle> circles = <Circle>{};
double? lat;
double? lng;

class _MapScreenState extends State<MapScreen> {
  EditProfileViewModel editProfileViewModel = Get.find();
  EditProfileRequestModel editProfileReq = EditProfileRequestModel();
  EditProfileResponseModel? response;
  LatLng? destinationLatlng;
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> _markers = <Marker>{};
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  late StreamSubscription<LocationData> subscription;
  LocationData? currentLocation;
  late LocationData destinationLocation;
  Uint8List? imageData;
  late Location location;
  sendLatLong(String lat, String long) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var id = pref.getString(PrefString.id);
    editProfileReq.driverId = id.toString();

    editProfileReq.lattitude = lat;
    editProfileReq.longitude = long;
    if (mounted) {
      setState(() {});
    }
    print(editProfileReq.toJson());

    await editProfileViewModel.editProfile(editProfileReq);
    if (editProfileViewModel.editProfileApiResponse.status == Status.COMPLETE) {
      EditProfileResponseModel response =
          editProfileViewModel.editProfileApiResponse.data;
      print('EDIT PROFILE status ${response.success}');

      if (response.success == true) {
        print('valid');
      } else {
        print('invalid');
      }
      if (response.success == false) {}
    } else {}
  }

  @override
  void initState() {
    setMarker();
    destinationLatlng = LatLng(widget.lat!, widget.long!);
    if (mounted) {
      setState(() {});
    }

    location = Location();
    polylinePoints = PolylinePoints();

    subscription = location.onLocationChanged.listen((clocation) {
      currentLocation = clocation;
      if (mounted) {
        setState(() {});
      }
      print('***********UPDATED***********');
      sendLatLong(currentLocation!.latitude.toString(),
          currentLocation!.longitude.toString());
      print(currentLocation);

      updatePinsOnMap(imageData!);

      setPolylinesInMap();
    });
    setInitialLocation();
    super.initState();
  }

  void setInitialLocation() async {
    await location.getLocation().then((value) {
      currentLocation = value;

      if (mounted) {
        setState(() {});
      }
      print('***********INITIAL***********');
      print(currentLocation);
    });

    currentLocation = LocationData.fromMap({
      "latitude": destinationLatlng?.latitude,
      "longitude": destinationLatlng?.longitude,
    });
    if (mounted) {
      setState(() {});
    }
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load('asset/truck.png');

    return byteData.buffer.asUint8List();
  }

  setMarker() async {
    imageData = await getMarker();
    setState(() {});
    print('IMAGEIMAGEIMAGE:$imageData');
  }

  void showLocationPins() async {
    var sourceposition =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    var destinationPosition =
        LatLng(destinationLatlng!.latitude, destinationLatlng!.longitude);
    LocationData loc = LocationData.fromMap({
      "latitude": currentLocation!.latitude!,
      "longitude": currentLocation!.longitude!,
    });
    _markers.add(Marker(
      flat: true,
      markerId: MarkerId('sourcePosition'),
      icon: BitmapDescriptor.fromBytes(imageData!),
      position: sourceposition,
      rotation: loc.heading!,
    ));

    _markers.add(
      Marker(
        markerId: MarkerId('destinationPosition'),
        position: destinationPosition,
      ),
    );
    if (mounted) {
      setState(() {});
    }
    setPolylinesInMap();
  }

  void setPolylinesInMap() async {
    var result = await polylinePoints.getRouteBetweenCoordinates(
      googleApikey,
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(destinationLatlng!.latitude, destinationLatlng!.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      result.points.forEach((pointLatLng) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    setState(() {
      _polylines.add(Polyline(
        width: 7,
        polylineId: PolylineId('polyline'),
        color: Colors.orange.shade900,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: polylineCoordinates,
      ));
    });
  }

  void updatePinsOnMap(Uint8List imageData) async {
    CameraPosition cameraPosition = CameraPosition(
      zoom: 20,
      tilt: 80,
      bearing: 30,
      target: LatLng(
          currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
    );

    final GoogleMapController controller = await mapController.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var sourcePosition =
        LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude);
    LocationData loc = LocationData.fromMap({
      "latitude": cameraPosition.target.latitude,
      "longitude": cameraPosition.target.longitude,
    });
    setState(() async {
      _markers.removeWhere((marker) => marker.mapsId.value == 'sourcePosition');

      _markers.add(Marker(
          // flat: true,
          icon: BitmapDescriptor.fromBytes(imageData),
          markerId: MarkerId('sourcePosition'),
          rotation: loc.heading ?? 0,
          anchor: Offset(0.5, 0.5),
          position: sourcePosition,
          infoWindow: InfoWindow(title: 'Source Position')));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: 20,
      tilt: 80,
      bearing: 30,
      target: currentLocation != null
          ? LatLng(currentLocation!.latitude ?? 0.0,
              currentLocation!.longitude ?? 0.0)
          : LatLng(0.0, 0.0),
    );
    return currentLocation == null
        ? Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                markers: _markers,
                polylines: _polylines,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  mapController.complete(controller);

                  showLocationPins();
                },
              ),
            ),
          );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
