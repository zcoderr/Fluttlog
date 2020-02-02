class GalleryInfoBean {
  String title;
  String desc;
  String thumb;
  String location;
  String time;
  String catalog;
  List tags;
  String path;
  String play_url;

  GalleryInfoBean(this.title, this.desc, this.thumb, this.location, this.time,
      this.catalog, this.tags, this.path, this.play_url);

  static GalleryInfoBean fromJson(Map<String, dynamic> jsonMap) {
    GalleryInfoBean data = GalleryInfoBean(
        jsonMap["title"],
        jsonMap["desc"],
        jsonMap["thumb"],
        jsonMap["location"],
        jsonMap["time"],
        jsonMap["catalog"],
        jsonMap["tags"],
        jsonMap["path"],
        jsonMap['play_url']);
    return data;
  }
}

class ImageBean {
  String thumb;
  String originalImg;

  ImageBean(this.thumb, this.originalImg);

  static ImageBean fromJson(Map<String, dynamic> jsonMap) {
    ImageBean data = ImageBean(jsonMap["thumb"], jsonMap["originalImg"]);
    return data;
  }
}
