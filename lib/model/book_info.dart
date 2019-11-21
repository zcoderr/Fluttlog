class BookInfo {
  String title;
  String desc;
  String thumb;
  String location;
  String time;
  String catalog;
  String path;

  BookInfo(this.title, this.desc, this.thumb, this.location, this.time,
      this.catalog, this.path);

  static BookInfo fromJson(Map<String, dynamic> jsonMap) {
    BookInfo data = BookInfo(
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
