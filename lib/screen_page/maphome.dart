import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

class UserLocation {
  LocationData? currentlocation;
  double? latitude;
  double? longitude;

  UserLocation({this.latitude, this.longitude, this.currentlocation});
}

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
  // Set<Marker> currentMarker = {};

  static CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(35.2288, 126.8475),
    zoom: 17,
  );

  Set<Marker> currentMarker = {};

  void currentMarkerUpdate() {
    setState(() {
      currentMarker.remove(Marker(markerId: MarkerId("current")));
      currentMarker.add(Marker(
        markerId: MarkerId("current"),
        draggable: false,
        onTap: () {},
        position: LatLng(mylocation.currentlocation!.latitude!,
            mylocation.currentlocation!.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(180),
      ));
    });
    print(currentMarker);
  }

  void _onMapCreated(GoogleMapController ctrlr) async {
    _controller.complete(ctrlr);

    final GoogleMapController controller = await _controller.future;

    location.onLocationChanged.listen((userlocation) {
      mylocation.currentlocation = userlocation;
      // mylocation.latitude = userlocation.latitude;
      // mylocation.longitude = userlocation.longitude;

      // 사용자가 다른 부분을 계속 보고싶을 수도 있으니까 이건 빼자
      // moveCameraPosition();
      currentMarkerUpdate();
      print(currentMarker);
    });
  }

  void getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;

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
      // LocationData _currentPosition = await location.getLocation();
      mylocation.currentlocation = await location.getLocation();

      // mylocation.latitude = _currentPosition.latitude;
      // mylocation.latitude = _currentPosition.longitude;
    } catch (error) {
      print(error);
    }

    // _initialCameraPosition = CameraPosition(
    //   target: LatLng(mylocation.latitude!, mylocation.longitude!),
    //   zoom: 18,
    // );
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
      // backgroundColor: Colors.transparent,
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: _onMapCreated,
        zoomGesturesEnabled: true,
        markers: currentMarker, //Set.from(_markers)
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          getCurrentLocation();
          currentMarkerUpdate();
          moveCameraPosition();
        },
        child: Image(
          image: AssetImage("assets/location_icon.png"),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
