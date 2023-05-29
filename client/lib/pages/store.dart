import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

import '../api/client.dart';
import '../api/log_interceptor.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  StorePageState createState() => StorePageState();
}

class StorePageState extends State<StorePage> {
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  late KakaoMapController mapController;
  String myAddress = '내 주소';
  double mylat = 37.541;
  double mylong = 126.986;

  Future<Position> getMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    mylat = position.latitude;
    mylong = position.longitude;

    final dio = Dio()..interceptors.add(CustomLogInterceptor());
    final restClient = ClientMap(dio);
    var jsondata = {
      'latitude': mylat.toString(),
      'longitude': mylong.toString(),
    };
    restClient.getMapMyLocation(jsondata: jsondata).then((value) {
      setState(() {
        myAddress = value;
      });
      print(value);
    });
    return position;
  }

  @override
  Widget build(BuildContext context) {
    AuthRepository.initialize(appKey: '1e890a87547af4d8f1032a5697419319');
    //getMyLocation();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const SizedBox(
            width: 10,
          ),
          title: Text(
            myAddress,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Stack(children: [
            KakaoMap(
                onMapCreated: ((controller) async {
                  mapController = controller;

                  markers.add(Marker(
                    markerId: UniqueKey().toString(),
                    latLng: await mapController.getCenter(),
                  ));
                }),
                markers: markers.toList(),
                circles: circles.toList(),
                center: LatLng(mylat, mylong)),
            Positioned(
              bottom: 20,
              left: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  await getMyLocation();
                  mapController.setCenter(LatLng(mylat, mylong));

                  markers.clear();
                  markers.add(Marker(
                    markerId: UniqueKey().toString(),
                    latLng: LatLng(mylat, mylong),
                  ));
                  circles.clear();
                  circles.add(
                    Circle(
                      circleId: circles.length.toString(),
                      center: LatLng(mylat, mylong),
                      strokeWidth: 3,
                      strokeColor: const Color(0xFFFFC942),
                      strokeOpacity: 0.5,
                      fillColor: const Color(0xFFFFC942),
                      fillOpacity: 0.2,
                      radius: 150,
                    ),
                  );
                },
                child: const Icon(Icons.location_searching,
                    color: Color(0xFF1CDF53)),
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 70,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  fixedSize: MaterialStateProperty.all(const Size(140, 35)),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.menu, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      '리스트 보기',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
