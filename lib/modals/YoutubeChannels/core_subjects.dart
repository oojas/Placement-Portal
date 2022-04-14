class Core {
  String? name;
  String? image;
  String? description;
  String? link;

  Core({this.name, this.image, this.description, this.link});

  Core.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['link'] = this.link;
    return data;
  }
}
