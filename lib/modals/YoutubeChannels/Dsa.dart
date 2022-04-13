class DSA {
  String? name;
  String? image;
  String? description;
  String? link;

  DSA({this.name, this.image, this.description, this.link});

  DSA.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    image = json['Image'];
    description = json['Description'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Image'] = this.image;
    data['Description'] = this.description;
    data['Link'] = this.link;
    return data;
  }
}