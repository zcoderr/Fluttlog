class ProjectInfoBean {
  String title;
  String desc;
  String logo;
  String url;
  String status;

  ProjectInfoBean(this.title, this.desc, this.logo, this.url,this.status);

  static ProjectInfoBean fromJson(Map<String, dynamic> jsonMap) {
    ProjectInfoBean data = ProjectInfoBean(
      jsonMap["title"],
      jsonMap["desc"],
      jsonMap["logo"],
      jsonMap["url"],
      jsonMap["status"],
    );
    return data;
  }
}
