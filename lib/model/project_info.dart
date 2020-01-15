class ProjectInfoBean {
  String title;
  String desc;
  String logo;
  String url;

  ProjectInfoBean(this.title, this.desc, this.logo, this.url);

  static ProjectInfoBean fromJson(Map<String, dynamic> jsonMap) {
    ProjectInfoBean data = ProjectInfoBean(
      jsonMap["title"],
      jsonMap["desc"],
      jsonMap["logo"],
      jsonMap["url"],
    );
    return data;
  }
}
