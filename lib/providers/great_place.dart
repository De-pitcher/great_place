import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  void addPlace(String pickedTitle, File pickedImage) {
    print(pickedImage);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
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
              location: null),
        )
        .toList();
    notifyListeners();
  }
}
