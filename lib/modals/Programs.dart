class Program {
  String? name;
  String? image;
  String? link;
  String? description;

  Program({this.name, this.image, this.link, this.description});

  Program.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    link = json['link'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['link'] = this.link;
    data['description'] = this.description;
    return data;
  }
}