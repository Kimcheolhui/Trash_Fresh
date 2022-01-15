import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);
  @override
  State<MainHome> createState() => MainHomeState();
}

class MainHomeState extends State<MainHome> {
  Completer<GoogleMapController> _controller = Completer();

  // 행정동 좌표
  double lon = 126.8415;
  double lat = 35.2272;
  LocationPermission permission = LocationPermission.always;

  // 마커 리스트
  List<Marker> _markers = [];

  // 현재 위치 정보에 대한 승인 여부 확인 및 승인을 받는 함수
  _getPermission() {
    if (permission != LocationPermission.always) {
      Geolocator.requestPermission().then((LocationPermission value) {
        setState(() {
          permission = value;
        });
        print("나는 허락");
      }).catchError((e) => print(e));
    }
  }

  callPermission() async {
    await Permission.location.request();
  }

  // 현재 위치 정보를 가져오는 함수
  _getCurrentLocation() async {
    print("나는 위치");
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((position) {
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
      });
    }).catchError((e) {
      print(e);
    });
  }

  // 현재 위치로 카메라 포지션을 옮기는 함수
  _moveCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lon),
        zoom: 17.0,
      ),
    ));
  }

  // Marker marker = new Marker(markerId: "test", position: LatLng(latitude, longitude));

  // 현재 위치에 마커 표시
  _setMarker() async {
    // final GoogleMapController controller = await _controller.future;
    for (int i = 0; i < _markers.length; i++) {
      if (_markers[i].markerId == "current") {
        _markers.remove(MarkerId("current"));
        break;
      }
    }
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("current"),
          draggable: true,
          onTap: () => print("Now you are here!"),
          position: LatLng(lat, lon),
          icon: BitmapDescriptor.defaultMarkerWithHue(180),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    callPermission();
    _getCurrentLocation();
    // 마커 추가
    // _markers.add(Marker(
    //     markerId: MarkerId("current"),
    //     draggable: true,
    //     onTap: () => print("Marker"),
    //     position: LatLng(lat, lon)));
  }

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(35.2288, 126.8475),
    zoom: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomGesturesEnabled: true,
        markers: Set.from(_markers),
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          _getPermission();
          // callPermission();
          _getCurrentLocation();
          _moveCameraPosition();
          _setMarker();
        },
        child: Image(
          image: AssetImage("assets/location_icon.png"),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
