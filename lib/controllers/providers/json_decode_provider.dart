import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_planets/models/json_decode.dart';

class JsonDecodeProvider extends ChangeNotifier {
  String? data;

  List<JsonDecodeModel> galaxyDetails = [];

  FavoriteModel favoriteModel = FavoriteModel(favoriteList: []);

  Future<void> loadJson() async {
    data = await rootBundle.loadString('lib/json/planet_details.json');

    List decodedList = jsonDecode(data!);

    galaxyDetails = decodedList
        .map(
          (e) => JsonDecodeModel.map(data: e),
        )
        .toList();
  }

  favoritePlanet(int index) {
    if (galaxyDetails[index].favorite) {
      galaxyDetails[index].favorite = false;
      favoriteModel.favoriteList.remove(galaxyDetails[index]);
    } else {
      galaxyDetails[index].favorite = true;
      favoriteModel.favoriteList.add(galaxyDetails[index]);
    }
    notifyListeners();
  }

  removeFavoritePlanet(int index) {
    galaxyDetails[int.parse(favoriteModel.favoriteList[index].position)]
        .favorite = false;
    favoriteModel.favoriteList.remove(favoriteModel.favoriteList[index]);
    notifyListeners();
  }
}
