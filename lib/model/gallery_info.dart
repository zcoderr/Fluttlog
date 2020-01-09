class GalleryInfoBean {
  String title;
  String desc;
  String thumb;
  String originalImg;
  String location;
  String time;
  String catalog;
  List tags;
  List images;

  GalleryInfoBean(this.title, this.desc, this.thumb, this.originalImg,
      this.location, this.time, this.catalog, this.tags, this.images);

  static GalleryInfoBean fromJson(Map<String, dynamic> jsonMap) {
    GalleryInfoBean data = GalleryInfoBean(
        jsonMap["title"],
        jsonMap["desc"],
        jsonMap["thumb"],
        jsonMap["originalImg"],
        jsonMap["location"],
        jsonMap["time"],
        jsonMap["catalog"],
        jsonMap["tags"],
        jsonMap["images"]);
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
