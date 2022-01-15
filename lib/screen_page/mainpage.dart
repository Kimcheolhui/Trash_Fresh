import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);
  @override
  State<MainHome> createState() => MainHomeState();
}

class MainHomeState extends State<MainHome> {
  Completer<GoogleMapController> _controller = Completer();

  late LocationData lastknownlocation;

  // 현재 위치 정보 얻기
  void _getcurrentLocation() async {
    final Location location = new Location();

    LocationData currentLocation;
    double lat;
    double lon;

    currentLocation = await location.getLocation();

    setState(() {
      lastknownlocation = currentLocation;
    });
    _moveCameraPosition(lastknownlocation);
    _setMarker(lastknownlocation);
  }

  // 현재 위치로 카메라 포지션 옮기기
  void _moveCameraPosition(LocationData lastknownlocation) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target:
            LatLng(lastknownlocation.latitude!, lastknownlocation.longitude!),
        zoom: 17,
      ),
    ));
  }

  // 현재 위치에 마커를 표시
  void _setMarker(LocationData lastknownlocation) async {
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
          position:
              LatLng(lastknownlocation.latitude!, lastknownlocation.longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(180),
        ),
      );
    });
  }

  // 마커 리스트
  List<Marker> _markers = [];

  // 현재 위치에 마커 표시

  @override
  void initState() {
    super.initState();
    _getcurrentLocation();
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
          _getcurrentLocation();
        },
        child: Image(
          image: AssetImage("assets/location_icon.png"),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
