class PostInfoBean {
  String title;
  String desc;
  String thumb;
  String location;
  String time;
  String catalog;
  List tags;
  String path;

  PostInfoBean(this.title, this.desc, this.thumb, this.location, this.time,
      this.catalog, this.tags, this.path);

  static PostInfoBean fromJson(Map<String, dynamic> jsonMap) {
    PostInfoBean data = PostInfoBean(
        jsonMap["title"],
        jsonMap["desc"],
        jsonMap["thumb"],
        jsonMap["location"],
        jsonMap["time"],
        jsonMap["catalog"],
        jsonMap["tags"],
        jsonMap["path"]);
    return data;
  }
}
