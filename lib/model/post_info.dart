class PostInfoBean {
  String title;
  String desc;
  String thumb;
  String location;
  String time;
  String catalog;
  List tags;
  String url;
  String path;

  PostInfoBean(this.title, this.desc, this.thumb, this.location, this.time,
      this.catalog, this.tags, this.url,this.path);

  static PostInfoBean fromJson(Map<String, dynamic> jsonMap) {
    PostInfoBean data = PostInfoBean(
        jsonMap["title"],
        jsonMap["desc"],
        jsonMap["thumb"],
        jsonMap["location"],
        jsonMap["time"],
        jsonMap["catalog"],
        jsonMap["tags"],
        jsonMap["url"],
        jsonMap["path"]);
    return data;
  }
}
