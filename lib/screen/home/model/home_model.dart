class HomeModel {
  int? total, totalHits;
  List<HitsModel>? hitsList = [];

  HomeModel({this.total, this.totalHits, this.hitsList});

  factory HomeModel.mapToModel(Map m1) {
    List h1 = m1['hits'];
    return HomeModel(
        total: m1['total'],
        totalHits: m1['totalHits'],
        hitsList: h1
            .map(
              (e) => HitsModel.mapToModel(e),
            )
            .toList());
  }
}

class HitsModel {
  String? tags, previewURL, largeImageURL;

  HitsModel({this.tags, this.previewURL, this.largeImageURL});

  factory HitsModel.mapToModel(Map m1) {
    return HitsModel(
        tags: m1['tags'],
        largeImageURL: m1['largeImageURL'],
        previewURL: m1['previewURL']);
  }
}
