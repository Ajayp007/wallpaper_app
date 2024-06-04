import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screen/home/model/home_model.dart';

import '../home/provider/home_provider.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    HomeModel model = ModalRoute.of(context)!.settings.arguments as HomeModel;
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: providerR!.index),
        itemCount: model.hitsList!.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: "${model.hitsList![index].largeImageURL}",
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AsyncWallpaper.setWallpaper(
            url: "${model.hitsList![providerR!.index].largeImageURL}",
            goToHome: true,
            toastDetails: ToastDetails.success(),
            errorToastDetails: ToastDetails.error(),
          );
        },
        child: const Icon(Icons.download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
