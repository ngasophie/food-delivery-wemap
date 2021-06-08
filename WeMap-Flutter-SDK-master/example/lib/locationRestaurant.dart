import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';
import 'ePage.dart';

import 'dart:developer' as developer;

class FullMapPage extends ePage {
  LatLng initLatLng;
  FullMapPage({this.value}) : super(const Icon(Icons.map), 'Full screen map');
  final value;
  static String local ;
  @override
  Widget build(BuildContext context) {
    local = this.value;
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    print("The LOCATION ISS: ${FullMapPage.local}");
    return const  FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();
  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  WeMapController mapController;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm ở đây"; //Hint text for InfoBar
  String searchPlaceName;
  LatLng myLatLng = LatLng(21.038282, 105.782885);
  bool reverse = true;
  WeMapPlace place;
  WeMapSearchAPI searchAPI = WeMapSearchAPI();

  void _onMapCreated(WeMapController controller) {

    mapController = controller;
  }

  Future<WeMapPlace> getLocation(String placeName) async {
    List<WeMapPlace> places = await searchAPI.getSearchResult(
        placeName, myLatLng, WeMapGeocoder.Pelias);
    print('list places length --> ' + places.length.toString());
    print(places[0].fullJSON);
    return places.length > 0 ? places[0] : WeMapPlace(location: myLatLng);
  }

  @override
  void initState() {
    super.initState();
    // 210 Hoang Quoc Viet
    // 122 Hoàng Hoa Thám
    getLocation(FullMapPage.local).then((_place) {
      setState(() {
        place = _place;
      });
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: place.location,
            zoom: 14.0,
          ),
        ),
      );
      mapController.showPlaceCard(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WeMap(
            onMapClick: (point, latlng, _place) async {
              place = await _place;
            },
            onPlaceCardClose: () {
              print("Place Card closed");
            },
            reverse: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.036029, 105.782950),
              zoom: 16.0,
            ),
            destinationIcon: "assets/symbols/destination.png",
          ),
          WeMapSearchBar(
            location: myLatLng,
            onSelected: (_place) {
              setState(() {
                place = _place;
              });
              mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: place.location,
                    zoom: 14.0,
                  ),
                ),
              );
              mapController.showPlaceCard(place);
            },
            onClearInput: () {
              setState(() {
                place = null;
                mapController.showPlaceCard(place);
              });
            },
          ),
        ],
      ),
    );
  }
}