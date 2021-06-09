

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';

import 'ePage.dart';

class PlaceSymbolPage extends ePage {
  PlaceSymbolPage() : super(const Icon(Icons.place), 'Place symbol');

  @override
  Widget build(BuildContext context) {
    return const PlaceSymbolBody();
  }
}

class PlaceSymbolBody extends StatefulWidget {
  const PlaceSymbolBody();

  @override
  State<StatefulWidget> createState() => PlaceSymbolBodyState();
}

class PlaceSymbolBodyState extends State<PlaceSymbolBody> {
  PlaceSymbolBodyState();
  WeMapController controller;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm Nhà hàng"; //Hint text for InfoBar
  String searchPlaceName;
  LatLng myLatLng = LatLng(21.038282, 105.782885);
  static final LatLng center = const LatLng(21.038282, 105.782885);
  bool reverse = true;
  WeMapPlace place;
  void _add(String iconImage) {
    controller.addSymbol(
      SymbolOptions(
        geometry: LatLng(
          center.latitude ,
          center.longitude ,
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
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.038282, 105.782885),
              zoom: 16.0,
            ),
            // destinationIcon: "assets/symbols/destination.png",

          ),
        ],
      ),
    );
  }
}

