class AlumniList {
  String name;
  String img_url;
  String post;
  String company;
  String linkedin_url;

  AlumniList(
      this.name, this.img_url, this.post, this.company, this.linkedin_url);

  factory AlumniList.fromJson(dynamic json) {
    return AlumniList("${json['name']}", "${json['img_url']}",
        "${json['post']}", "${json['company']}", "${json['linkedin_url']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'img_url': img_url,
        'post': post,
        'company': company,
        'linkedin_url': linkedin_url,
      };
}
