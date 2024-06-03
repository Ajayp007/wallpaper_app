import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/home/view/home_screen.dart';
import 'package:wallpaper_app/screen/wallpaper/wallpaper_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  'wallpaper': (context) => const WallpaperScreen(),
};
