class Promotion {
  String? name;
  String? link;

  Promotion.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    link = json["link"];
  }
}