import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/home/model/home_model.dart';
import 'package:wallpaper_app/utils/helper/api_helper.dart';

class HomeProvider with ChangeNotifier {
  ApiHelper helper = ApiHelper();

  HomeModel? model;

  Future<void> getWallpaperApi() async {
    model = await helper.getAPI();
    notifyListeners();
  }
}
