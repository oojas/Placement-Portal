class Articles {
  String? description;
  String? image;
  String? link;

  Articles({this.description, this.image, this.link});

  Articles.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}