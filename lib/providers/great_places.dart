import 'package:flutter/foundation.dart';
import 'dart:io';

import '../model/places.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Places(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (item) => Places(
        id: item['id'],
        title: item['title'],
        location: null,
        image: File(
          item['image'],
        ),
      ),
    )
        .toList();
    notifyListeners();
  }
}
