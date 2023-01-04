import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/location_helper.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Place findById(String id) => _items.firstWhere(
        (item) => item.id == id,
      );

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    // print(pickedImage);
    LocationHelper.getAddress(pickedLocation);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: pickedLocation,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      userPlaceTable,
      {
        userId: newPlace.id,
        userTitle: newPlace.title,
        userPlaceImage: newPlace.image.path,
        placeLocLat: newPlace.location!.latitude,
        placeLocLong: newPlace.location!.longitude,
        placeAddress: newPlace.location!.address,
      },
    );
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData(userPlaceTable);
    _items = dataList
        .map(
          (item) => Place(
            id: item[userId],
            title: item[userTitle],
            image: File(item[userPlaceImage]),
            location: PlaceLocation(
              latitude: item[placeLocLat],
              longitude: item[placeLocLong],
              address: item[placeAddress],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
