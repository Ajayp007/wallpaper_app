import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/home/model/home_model.dart';
import 'package:wallpaper_app/utils/helper/api_helper.dart';

class HomeProvider with ChangeNotifier {
  ApiHelper helper = ApiHelper();
  List<HomeModel> wallpaperList =[];

  String search = "nature";
  int page = 1;

  Future<HomeModel?>? model;

  void searchWallpaper(String s) {
    search = s;
    getWallpaperApi();
  }

  void changePage() {
    page++;
    getWallpaperApi();
  }

  void getWallpaperApi() {
    model = helper.getAPI(q: search,page: page);
    model!.then(
      (value) {
        if (value != null) {
          notifyListeners();
        }
      },
    );
  }
}
