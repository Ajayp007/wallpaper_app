import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screen/home/model/home_model.dart';
import 'package:wallpaper_app/screen/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getWallpaperApi();

    scrollController.addListener(
      () {
        if(scrollController.position.pixels==scrollController.position.maxScrollExtent)
          {
            context.read<HomeProvider>().changePage();
          }
      },
    );
  }

  TextEditingController txtSearch = TextEditingController();
  ScrollController scrollController = ScrollController();

  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SearchBar(
              hintText: "Search",
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              trailing: [
                IconButton(
                  onPressed: () {
                    providerW!.searchWallpaper(txtSearch.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
              controller: txtSearch,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: providerW!.model,
              builder: (context, snapshot) {
                HomeModel? model = snapshot.data;

                //providerW!.wallpaperList.addAll(model);

                if (snapshot.hasError) {
                  return Text("${snapshot.hasError}");
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: model!.hitsList!.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      if (index < model.hitsList!.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'wallpaper',
                                  arguments: model.hitsList![index]);
                            },
                            child: Image.network(
                              "${model.hitsList![index].previewURL}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
