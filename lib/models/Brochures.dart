import 'Brochure.dart';

class Brochures {
  List<Brochure> brochures =List.empty();

  Brochures.fromJson(Map<String, dynamic> json) {
    var brochureJsonList = json['brochures'] as List;
    brochures = brochureJsonList.map((i) => Brochure.fromJson(i)).toList();
  }
}