// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:find_trashcan/screen_page/location.dart';
import 'package:find_trashcan/screen_page/bottombar.dart';
// import 'package:permission_handler/permission_handler.dart';

class MapHome extends StatefulWidget {
  const MapHome({Key? key}) : super(key: key);
  @override
  State<MapHome> createState() => MapHomeState();
}

class MapHomeState extends State<MapHome> {
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _initialCameraPosition;

  UserLocation mylocation = UserLocation();
  Location location = Location();

  static CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(35.2288, 126.8475),
    zoom: 17,
  );

  Set<Marker> currentMarker = {};

  void currentMarkerUpdate() {
    setState(() {
      currentMarker.remove(Marker(markerId: MarkerId("current")));
      currentMarker.add(Marker(
        markerId: const MarkerId("current"),
        draggable: false,
        onTap: () {},
        position: LatLng(mylocation.currentlocation!.latitude!,
            mylocation.currentlocation!.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(180),
      ));
    });
  }

  void _onMapCreated(GoogleMapController ctrlr) async {
    _controller.complete(ctrlr);

    location.onLocationChanged.listen((userlocation) {
      mylocation.currentlocation = userlocation;
      mylocation.latitude = userlocation.latitude;
      mylocation.longitude = userlocation.longitude;
      currentMarkerUpdate();
    });
  }

  void getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      mylocation.currentlocation = await location.getLocation();
    } catch (error) {
      print(error);
    }
  }

  // 현재 위치로 카메라 포지션 옮기기
  void moveCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(mylocation.currentlocation!.latitude!,
              mylocation.currentlocation!.longitude!),
          zoom: 17,
        ),
      ),
    );
  }

  @override
  void initState() {
    // 나중에 시도해보자

    // 위치 정보 얻고 UserLocation Class의 위치 정보 초기화
    // getCurrentLocation();
    // UserLocation Class 변수 바탕으로 카메라 포지션 변경
    // moveCameraPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          markers: currentMarker, //Set.from(_markers)
          zoomControlsEnabled: false,
        ),
        Positioned(
          right: 20,
          bottom: 90,
          child: InkWell(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color(0xff4B9B77),
                borderRadius: BorderRadius.all(
                  Radius.circular(180.0),
                ),
              ),
              child: Center(
                child: Image.asset(
                  "assets/location_icon.png",
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            onTap: () {
              getCurrentLocation();
              currentMarkerUpdate();
              moveCameraPosition();
            },
          ),
        ),
        BottomBar(),
      ],
    ));
  }
}
