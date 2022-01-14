class MembersList {
  String name;
  String img_url;
  String skills;
  String batch;
  String linkedin_url;

  MembersList(
      this.name, this.img_url, this.skills, this.batch, this.linkedin_url);

  factory MembersList.fromJson(dynamic json) {
    return MembersList("${json['name']}", "${json['img_url']}",
        "${json['skills']}", "${json['batch']}", "${json['linkedin_url']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'img_url': img_url,
        'skills': skills,
        'batch': batch,
        'linkedin_url': linkedin_url,
      };
}
