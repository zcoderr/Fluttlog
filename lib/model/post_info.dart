class PostInfo {
  String title;
  String desc;
  String thumb;
  String location;
  String time;
  String catalog;
  String path;

  PostInfo(this.title, this.desc, this.thumb, this.location, this.time,
      this.catalog, this.path);

  static PostInfo fromJson(Map<String, dynamic> jsonMap) {
    PostInfo data = PostInfo(
        jsonMap["title"],
        jsonMap["desc"],
        jsonMap["thumb"],
        jsonMap["location"],
        jsonMap["time"],
        jsonMap["catalog"],
        jsonMap["path"]);
    return data;
  }
}
