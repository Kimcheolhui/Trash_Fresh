// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:find_trashcan/screen_page/location.dart';
// import 'package:find_trashcan/screen_page/bottombar.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:find_trashcan/screen_page/trashcan_location.dart';

class MapHome extends StatefulWidget {
  const MapHome({Key? key}) : super(key: key);
  @override
  State<MapHome> createState() => MapHomeState();
}

class MapHomeState extends State<MapHome> {
  // Completer<GoogleMapController> _controller = Completer();
  // late CameraPosition _initialCameraPosition;

  late GoogleMapController _controller;

  // Location Plugin & 사용자 위치 정보 Class 생성자 설정
  UserLocation mylocation = UserLocation();
  Location location = Location();

  // 초기 위치 설정
  static CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(35.5276, 127.0406),
    zoom: 17,
  );

  // 현재 위치 커스텀 아이콘 설정
  late BitmapDescriptor myIcon;
  void setCustomIcon() async {
    myIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 4), "assets/myicon.png");
  }

  // 모든 마커 데이터 변수
  Set<Marker> marker = {};
  Marker mymarker = Marker(markerId: MarkerId("current"));
  List<Marker> trashmarker = [];

  // 실시간 마커 업데이트 전에 마커 데이터 합쳐주기
  void sumMarker() {
    setState(() {
      marker = {};
      marker.add(mymarker);
      marker.addAll(trashmarker);
    });
  }

  // 현재 위치 및 마커 실시간 업데이트
  void currentMarkerUpdate() {
    setState(() {
      mymarker = Marker(
        markerId: const MarkerId("current"),
        draggable: false,
        onTap: () {},
        position: LatLng(mylocation.currentlocation!.latitude!,
            mylocation.currentlocation!.longitude!),
        icon: myIcon,
      );
    });
    sumMarker();
  }

  // 사용할 쓰레기통 데이터 설정
  void trashcanMarkerUpdate(List<Marker> trashcan) {
    setState(() {
      trashmarker = [];
      trashmarker = trashcan;
    });
    sumMarker();
  }

  //
  double opacity_normal = 1;
  double opacity_recycle = 0.5;
  double opacity_food = 0.5;
  double opacity_battery = 0.5;
  double opacity_cloth = 0.5;

  // 사용자가 쓰레기통을 추가할 건지 묻는 팝업창
  void checkAddMarker(LatLng pos) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text("해당 위치에 쓰레기통을 추가할겨?"),
            actions: [
              TextButton(
                  onPressed: () {
                    addMarker(pos);
                    Navigator.pop(context);
                  },
                  child: Text("네")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("아뇨? 뚱인데요?")),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }

  // 사용자가 쓰레기통 위치를 추가할 때 사용
  void addMarker(LatLng pos) {
    if (currentTrashType == "normal") {
      setState(() {
        normaltrashcanInfo.add(
          Marker(
            markerId: MarkerId(normalcount.toString()),
            icon: normalicon,
            position: pos,
            onTap: () {},
          ),
        );
      });
      normalcount++;
      trashcanMarkerUpdate(normaltrashcanInfo);
    } else if (currentTrashType == "recycle") {
      setState(() {
        recycletrashcanInfo.add(
          Marker(
            markerId: MarkerId(recyclecount.toString()),
            icon: recycleicon,
            position: pos,
            onTap: () {},
          ),
        );
      });
      recyclecount++;
      trashcanMarkerUpdate(recycletrashcanInfo);
    } else if (currentTrashType == "food") {
      setState(() {
        foodtrashcanInfo.add(
          Marker(
            markerId: MarkerId(foodcount.toString()),
            icon: foodicon,
            position: pos,
            onTap: () {},
          ),
        );
      });
      foodcount++;
      trashcanMarkerUpdate(foodtrashcanInfo);
    } else if (currentTrashType == "battery") {
      setState(() {
        batterytrashcanInfo.add(
          Marker(
            markerId: MarkerId(batterycount.toString()),
            icon: batteryicon,
            position: pos,
            onTap: () {},
          ),
        );
      });
      batterycount++;
      trashcanMarkerUpdate(batterytrashcanInfo);
    } else if (currentTrashType == "cloth") {
      setState(() {
        clothtrashcanInfo.add(
          Marker(
            markerId: MarkerId(clothcount.toString()),
            icon: clothicon,
            position: pos,
            onTap: () {},
          ),
        );
      });
      clothcount++;
      trashcanMarkerUpdate(clothtrashcanInfo);
    }
  }

  // 현재 화면에 보여지는 쓰레기통의 종류
  String currentTrashType = "";

  void _onMapCreated(GoogleMapController ctrlr) async {
    setState(() {
      _controller = ctrlr;
    });

    // 수정할 수 있을 것 같은데? $사용해서
    if (currentTrashType == "normal") {
      trashcanMarkerUpdate(normaltrashcanInfo);
    } else if (currentTrashType == "recycle") {
      trashcanMarkerUpdate(recycletrashcanInfo);
    } else if (currentTrashType == "food") {
      trashcanMarkerUpdate(foodtrashcanInfo);
    } else if (currentTrashType == "battery") {
      trashcanMarkerUpdate(batterytrashcanInfo);
    } else if (currentTrashType == "cloth") {
      trashcanMarkerUpdate(clothtrashcanInfo);
    } else {
      trashcanMarkerUpdate(normaltrashcanInfo);
    }

    location.onLocationChanged.listen((userlocation) {
      mylocation.currentlocation = userlocation;
      mylocation.latitude = userlocation.latitude;
      mylocation.longitude = userlocation.longitude;
      currentMarkerUpdate();
    });
  }

  // 현재 위치 정보 얻기
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
    _controller.animateCamera(
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
    setCustomIcon();
    // 위치 정보 얻고 UserLocation Class의 위치 정보 초기화
    // getCurrentLocation();
    // UserLocation Class 변수 바탕으로 카메라 포지션 변경
    // moveCameraPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 구글맵
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          markers: marker,
          onLongPress: checkAddMarker,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
        ),
        // 현재 위치 설정 버튼
        Positioned(
          left: 20,
          bottom: 20,
          child: InkWell(
            child: Opacity(
              opacity: 0.65,
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
            ),
            onTap: () {
              getCurrentLocation();
              currentMarkerUpdate();
              moveCameraPosition();
            },
          ),
        ),
        // 쓰레기통 종류 선택 버튼
        Positioned(
          left: 0,
          top: 50,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 55,
                  height: 30,
                  child: Opacity(
                    opacity: opacity_normal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Material(
                        color: Colors.yellow[700],
                        child: InkWell(
                          onTap: () {
                            trashcanMarkerUpdate(normaltrashcanInfo);
                            setState(() {
                              currentTrashType = "normal";
                              opacity_normal = 1;
                              opacity_recycle = 0.5;
                              opacity_food = 0.5;
                              opacity_battery = 0.5;
                              opacity_cloth = 0.5;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.miscellaneous_services,
                                  size: 13, color: Colors.white),
                              Text("일반",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: Opacity(
                    opacity: opacity_recycle,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Material(
                        color: Colors.green[400],
                        child: InkWell(
                          onTap: () {
                            trashcanMarkerUpdate(recycletrashcanInfo);
                            setState(() {
                              currentTrashType = "recycle";
                              opacity_normal = 0.5;
                              opacity_recycle = 1;
                              opacity_food = 0.5;
                              opacity_battery = 0.5;
                              opacity_cloth = 0.5;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.eco_outlined,
                                  size: 13, color: Colors.white),
                              Text(
                                "재활용",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: Opacity(
                    opacity: opacity_food,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Material(
                        color: Colors.blue[600],
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            trashcanMarkerUpdate(foodtrashcanInfo);
                            setState(() {
                              currentTrashType = "food";
                              opacity_normal = 0.5;
                              opacity_recycle = 0.5;
                              opacity_food = 1;
                              opacity_battery = 0.5;
                              opacity_cloth = 0.5;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.invert_colors,
                                  size: 13, color: Colors.white),
                              Text(
                                "음식물",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: Opacity(
                    opacity: opacity_battery,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Material(
                        color: Colors.red[500],
                        child: InkWell(
                          onTap: () {
                            trashcanMarkerUpdate(batterytrashcanInfo);
                            setState(() {
                              currentTrashType = "battery";
                              opacity_normal = 0.5;
                              opacity_recycle = 0.5;
                              opacity_food = 0.5;
                              opacity_battery = 1;
                              opacity_cloth = 0.5;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.battery_std_sharp,
                                  size: 13, color: Colors.white),
                              Text(
                                "건전지",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: Opacity(
                    opacity: opacity_cloth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Material(
                        color: Colors.green[700],
                        child: InkWell(
                          onTap: () {
                            trashcanMarkerUpdate(clothtrashcanInfo);
                            setState(() {
                              currentTrashType = "cloth";
                              opacity_normal = 0.5;
                              opacity_recycle = 0.5;
                              opacity_food = 0.5;
                              opacity_battery = 0.5;
                              opacity_cloth = 1;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.local_mall_sharp,
                                  size: 13, color: Colors.white),
                              Text(
                                "의류",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
