class Brochure {
  String? name;
  String? link;

  Brochure.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    link = json["link"];
  }
}
