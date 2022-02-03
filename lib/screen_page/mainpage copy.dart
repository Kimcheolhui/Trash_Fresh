// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';

// class Locationfunction {
//   UserLocation? _currentLocation;

//   Location location = Location();

//   StreamController<UserLocation> _locationController =
//       StreamController<UserLocation>();
//   Stream<UserLocation> get locationStream => _locationController.stream;

//   LocationService() {
//     location.onLocationChanged.listen((locationData) {
//       if (locationData != null) {
//         _locationController.add(UserLocation(
//           latitude: locationData.latitude,
//           longitude: locationData.longitude,
//         ));
//       }
//     });
//   }

//   Future<UserLocation?> getLocation() async {
//     try {
//       var userLocation = await location.getLocation();
//       _currentLocation = UserLocation(
//         latitude: userLocation.latitude,
//         longitude: userLocation.longitude,
//       );
//     } on Exception catch (e) {
//       print('Could not get location: ${e.toString()}');
//     }

//     return _currentLocation;
//   }
// }

// class UserLocation {
//   final double? latitude;
//   final double? longitude;

//   UserLocation({this.latitude, this.longitude});
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//   @override
//   State<Home> createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   Completer<GoogleMapController> _controller = Completer();

//   LocationData? lastknownlocation;
//   LocationData? currentLocation;

//   // 마커 리스트
//   List<Marker> _markers = [];

//   Set<Marker> currentMarker = {};

//   currentMarkerUpdate() {
//     currentMarker.add(Marker(
//       markerId: MarkerId("current"),
//       draggable: false,
//       onTap: () {},
//       position:
//           LatLng(lastknownlocation!.latitude!, lastknownlocation!.longitude!),
//       icon: BitmapDescriptor.defaultMarkerWithHue(180),
//     ));
//   }

//   // 현재 위치 정보 얻기
//   void getcurrentLocation() async {
//     Location location = Location();
//     try {
//       currentLocation = await location.getLocation();
//       setState(() {
//         lastknownlocation = currentLocation;
//       });
//     } catch (e) {
//       print(e);
//     }

//     moveCameraPosition(lastknownlocation!);
//     // setMarker(lastknownlocation);
//   }

//   // 현재 위치로 카메라 포지션 옮기기
//   void moveCameraPosition(LocationData lastknownlocation) async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           bearing: 0,
//           target:
//               LatLng(lastknownlocation.latitude!, lastknownlocation.longitude!),
//           zoom: 17,
//         ),
//       ),
//     );
//   }

//   // 현재 위치에 마커를 표시
//   void setMarker(LocationData lastknownlocation) async {
//     setState(() {
//       // _markers.add(
//       //   Marker(
//       //     markerId: MarkerId("current"),
//       //     draggable: true,
//       //     onTap: () => print("Now you are here!"),
//       //     position:
//       //         LatLng(lastknownlocation.latitude!, lastknownlocation.longitude!),
//       //     icon: BitmapDescriptor.defaultMarkerWithHue(180),
//       //   ),
//       // );
//       // currentMarker.position = LatLng(latitude, longitude);
//     });
//   }

//   // 앱 실행하자마자 현재 위치에 마커 표시
//   @override
//   void initState() {
//     getcurrentLocation();
//     super.initState();
//   }

//   static final CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(35.2288, 126.8475),
//     zoom: 17,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _initialCameraPosition,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         zoomGesturesEnabled: true,
//         markers: currentMarker, //Set.from(_markers)
//         zoomControlsEnabled: false,
//       ),
//       floatingActionButton: FloatingActionButton(
//         elevation: 0,
//         onPressed: () {
//           getcurrentLocation();
//         },
//         child: Image(
//           image: AssetImage("assets/location_icon.png"),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//     );
//   }
// }
