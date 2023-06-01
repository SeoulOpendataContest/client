import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/client.dart';
import '../api/log_interceptor.dart';

class KindStorePage extends StatefulWidget {
  const KindStorePage({super.key});
  @override
  KindStorePageState createState() => KindStorePageState();
}

class KindStorePageState extends State<KindStorePage> {
  bool screenIndex = true;
  bool dataloading = true;

  Set<Marker> markers = {};
  Set<Circle> circles = {};

  late KakaoMapController mapController;
  String myAddress = '내 주소';
  double mylat = 37.541;
  double mylong = 126.986;
  int currentFilter = 0;
  int tmp = 0;

  List<StoreInfo> storeInfo = [];
  List<String> storeFilter = [
    '전체',
    '기타서비스',
    '병원',
    '식당',
    '의류,잡화',
    '이미용업',
    '카페,디저트',
    '학원'
  ];

  List<String> searchFilter = [
    'all',
    '기타서비스',
    '병원',
    '식당',
    '의류,잡화',
    '이미용업',
    '카페,디저트',
    '학원'
  ];

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
    var jsondata1 = {
      'latitude': mylat.toString(),
      'longitude': mylong.toString(),
    };
    restClient.getMapMyLocation(jsondata: jsondata1).then((value) {
      setState(() {
        myAddress = value.addressName;
      });
    });
    var jsondata2 = {
      'latitude': mylat.toString(),
      'longitude': mylong.toString(),
      'distance': '100',
      'category': searchFilter[currentFilter],
    };
    restClient.getMapGoodVibeStoreFind(jsondata: jsondata2).then((value) {
      // save
      storeInfo = value;
      setState(() {
        markers.clear();
        circles.clear();
        circles.add(Circle(
            circleId: UniqueKey().toString(),
            center: LatLng(mylat, mylong),
            radius: 1000,
            strokeColor: const Color(0xFFFFC842),
            strokeWidth: 2,
            fillColor: const Color(0xFFFFC842).withOpacity(0.2)));
        for (var i = 0; i < value.length; i++) {
          markers.add(Marker(
            markerId: UniqueKey().toString(),
            latLng: LatLng(storeInfo[i].latitude, storeInfo[i].longitude),
          ));
        }
      });
    });

    // while loading map, return

    return position;
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildBottomSheet(BuildContext context,
      ScrollController scrollController, double bottomSheetOffset) {
    return Material(
        child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 2,
            // border
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFFC842))),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "가맹업 업종을 선택해주세요",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: storeFilter.length,
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () {
                  setState(() {
                    tmp = index;
                  });
                },
                child: Column(
                  children: [
                    Image.asset(
                      'asset/kindstore/선한가게-${storeFilter[index]}.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      storeFilter[index],
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.35, 60)),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFFE3E3E3),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  )),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                '취소',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.65, 60)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFFC842)),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  )),
              onPressed: () {
                setState(() {
                  dataloading = true;
                });
                setState(() {
                  currentFilter = tmp;
                  getMyLocation();
                });
                setState(() {
                  dataloading = false;
                });
                Navigator.pop(context);
              },
              child: const Text(
                '적용',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    AuthRepository.initialize(appKey: '1e890a87547af4d8f1032a5697419319');
    //getMyLocation();

    return screenIndex
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
              elevation: 0,
              leading: const SizedBox(
                width: 10,
              ),
              title: Text(
                myAddress,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
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
                      setState(() {
                        dataloading = true;
                      });
                      await getMyLocation();
                      setState(() {
                        dataloading = false;
                      });

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
                    onPressed: () {
                      setState(() {
                        screenIndex = false;
                      });
                    },
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
            ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              shape: const Border(bottom: BorderSide(color: Color(0xFFABABAB))),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    screenIndex = true;
                  });
                },
              ),
              title: Text(
                myAddress,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
            body: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      currentFilter == 0
                          ? const SizedBox()
                          : Image.asset(
                              'asset/kindstore/선한가게-${storeFilter[currentFilter]}.png',
                              width: 30,
                              height: 30,
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "  ${storeFilter[currentFilter]}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      fixedSize: MaterialStateProperty.all(const Size(35, 35)),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    onPressed: () {
                      showFlexibleBottomSheet(
                        bottomSheetColor: Colors.white,
                        minHeight: 0,
                        initHeight: 0.75,
                        maxHeight: 0.75,
                        context: context,
                        builder: _buildBottomSheet,
                        anchors: [0, 0.75],
                        isSafeArea: true,
                      );
                    },
                    child: const Icon(Icons.tune, color: Colors.black),
                  ),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: const Color(0xFFE2E2E2)),
              if (dataloading)
                const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black))
              else
                Expanded(
                    child: ListView.separated(
                        itemCount: storeInfo.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              height: 2,
                              color: Color(0xFFE2E2E2),
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //image
                                        Image.asset(
                                          'asset/categorylist/${storeInfo[index].category} 리스트.jpg',
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          storeInfo[index].name,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          storeInfo[index].storeaddress,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF696969)),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          storeInfo[index].benefit ?? "정보 없음",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF696969)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                        Geolocator.distanceBetween(
                                                      mylat,
                                                      mylong,
                                                      storeInfo[index].latitude,
                                                      storeInfo[index]
                                                          .longitude,
                                                    ) /
                                                    1000 <
                                                1
                                            ? "${Geolocator.distanceBetween(
                                                mylat,
                                                mylong,
                                                storeInfo[index].latitude,
                                                storeInfo[index].longitude,
                                              ).round()} m"
                                            : "${(Geolocator.distanceBetween(
                                                  mylat,
                                                  mylong,
                                                  storeInfo[index].latitude,
                                                  storeInfo[index].longitude,
                                                ) / 1000).round()} km",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF696969))),
                                    RawMaterialButton(
                                      onPressed: () {
                                        _launchUrl(Uri.parse(
                                            storeInfo[index].storeurl));
                                      },
                                      fillColor: const Color(0xFFFFC842),
                                      elevation: 0,
                                      shape: const CircleBorder(),
                                      child: const Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }))
            ]));
  }
}
