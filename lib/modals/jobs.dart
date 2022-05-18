// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class Jobs {
  String? name;
  String? role;
  String? image;
  String? link;

  Jobs({this.name, this.role, this.image, this.link});
  

  Jobs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['role'] = this.role;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
