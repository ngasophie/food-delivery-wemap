import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';
import 'ePage.dart';

import 'dart:developer' as developer;

import 'dart:async';
import 'dart:math';

class FullMapPage extends ePage {
  LatLng initLatLng;
  FullMapPage({this.value}) : super(const Icon(Icons.map), 'Full screen map');
  final value;
  static String local;

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
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();
  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  static LatLng center;
  // WeMapController controller;
  int _symbolCount = 0;
  Symbol _selectedSymbol;
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
    mapController.onSymbolTapped.add(_onSymbolTapped);

    // this.controller = controller;
  }

  Future<WeMapPlace> getLocation(String placeName) async {
    List<WeMapPlace> places = await searchAPI.getSearchResult(
        placeName, myLatLng, WeMapGeocoder.Pelias);
    print('list places length --> ' + places.length.toString());
    print(places[0].fullJSON.runtimeType);
    print('list places length --> ' + places.length.toString());
    print('list places length --> ' + places.length.toString());
    print('list places length --> ' + places.length.toString());
    print('list places length --> ' + places.length.toString());
    print('list places length --> ' + places.length.toString());
    print('list places length --> ' + places.length.toString());
    print('list places length --> ' + places.length.toString());
    print(places[0].fullJSON['geometry']['coordinates'][1]);
    center = LatLng(places[0].fullJSON['geometry']['coordinates'][1],
        places[0].fullJSON['geometry']['coordinates'][0]);

    return places.length > 0 ? places[0] : WeMapPlace(location: myLatLng);
  }

  @override
  void dispose() {
    mapController?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  void _onSymbolTapped(Symbol symbol) {
    if (_selectedSymbol != null) {
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    }
    setState(() {
      _selectedSymbol = symbol;
    });
    _updateSelectedSymbol(
      SymbolOptions(
        iconSize: 1.4,
      ),
    );
  }

  void _updateSelectedSymbol(SymbolOptions changes) {
    mapController.updateSymbol(_selectedSymbol, changes);
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
      this._add("assets/symbols/custom-icon.png");
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: place.location,
            zoom: 16.0,
          ),
        ),
      );
      mapController.showPlaceCard(place);
    });
  }
  void _add(String iconImage) {
    print(myLatLng);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(
          center.latitude,
          center.longitude,
        ),
        iconImage: iconImage,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // return new Scaffold(
    //   body: Stack(
    //     children: <Widget>[
    //       WeMap(
    //         onMapClick: (point, latlng, _place) async {
    //           place = await _place;
    //         },
    //         onPlaceCardClose: () {
    //           print("Place Card closed");
    //         },
    //         reverse: true,
    //         onMapCreated: _onMapCreated,
    //         initialCameraPosition: const CameraPosition(
    //           target: LatLng(21.036029, 105.782950),
    //           zoom: 14.0,
    //         ),
    //         destinationIcon: "assets/symbols/destination.png",
    //       ),
    //       WeMapSearchBar(
    //         location: myLatLng,
    //         onSelected: (_place) {
    //           setState(() {
    //             place = _place;
    //           });
    //           mapController.moveCamera(
    //             CameraUpdate.newCameraPosition(
    //               CameraPosition(
    //                 target: place.location,
    //                 zoom: 14.0,
    //               ),
    //             ),
    //           );
    //           mapController.showPlaceCard(place);
    //         },
    //         onClearInput: () {
    //           setState(() {
    //             place = null;
    //             mapController.showPlaceCard(place);
    //           });
    //         },
    //       ),
    //     ],
    //   ),
    // );

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WeMap(
            onMapClick: (point, latlng, _place) async {
              place = await _place;
            },
            onPlaceCardClose: () {
              // print("Place Card closed");
            },
            reverse: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: myLatLng,
              zoom: 16.0,
            ),
            // destinationIcon: "assets/symbols/destination.png",
          ),
        ],
      ),
    );
  }
}

class PlaceSymbolBodyState extends State<PlaceSymbolBody> {
  PlaceSymbolBodyState();
  WeMapController controller;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm Nhà hàng"; //Hint text for InfoBar
  String searchPlaceName;
  LatLng myLatLng = LatLng(FullMapState.center.latitude, FullMapState.center.longitude);
  static final LatLng center = LatLng (FullMapState.center.latitude, FullMapState.center.longitude);

  bool reverse = true;
  WeMapPlace place;
  void _add(String iconImage) {
    print(myLatLng);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    print(FullMapState.center);
    controller.addSymbol(
      SymbolOptions(
        geometry: LatLng(
          center.latitude,
          center.longitude,
        ),
        iconImage: iconImage,
      ),
    );
  }

  void _onMapCreated(WeMapController controller) {
    this.controller = controller;
    this._add("assets/symbols/custom-icon.png");
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
              // print("Place Card closed");
            },
            reverse: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: myLatLng,
              zoom: 16.0,
            ),
            // destinationIcon: "assets/symbols/destination.png",
          ),
        ],
      ),
    );
  }
}

class PlaceSymbolBody extends StatefulWidget {
  const PlaceSymbolBody();

  @override
  State<StatefulWidget> createState() => PlaceSymbolBodyState();
}
