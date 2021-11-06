import 'Brochure.dart';
import 'School.dart';

class Group {
  String? name;
  List<Brochure> brochures = List.empty();
  List<School> schools = List.empty();

  Group();
  Group.fromJson(Map<String, dynamic> json) {
    // name = json['name'];
    var brochureJsonList = json['brochures'] as List;
    brochures = brochureJsonList.map((i) => Brochure.fromJson(i)).toList();
    var schoolJsonList = json['schools'];
    schools = new List<School>.from(schoolJsonList.map((i) => School.fromJson(i)).toList());
  }
}
