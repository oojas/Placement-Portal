class CloudComputing {
  String? coursePic;
  String? thumbnail;
  String? name;
  String? description;
  String? link;

  CloudComputing(
      {this.coursePic, this.thumbnail, this.name, this.description, this.link});

  CloudComputing.fromJson(Map<String, dynamic> json) {
    coursePic = json['course_pic'];
    thumbnail = json['thumbnail'];
    name = json['name'];
    description = json['description'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_pic'] = this.coursePic;
    data['thumbnail'] = this.thumbnail;
    data['name'] = this.name;
    data['description'] = this.description;
    data['link'] = this.link;
    return data;
  }
}
