import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screen/home/model/home_model.dart';

class ApiHelper {
  Future<HomeModel?> getAPI() async {
    String? wallpaperString =
        "https://pixabay.com/api/?key=44141976-1225dbf54b78845c69eb0b2e1&q=birds&orientation=vertical";

    var response = await http.get(Uri.parse(wallpaperString));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      HomeModel model = HomeModel.mapToModel(json);

      return model;
    }
    return null;
  }
}
