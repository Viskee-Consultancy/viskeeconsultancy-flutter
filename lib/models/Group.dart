import 'Promotion.dart';
import 'School.dart';

class Group {
  String? name;
  List<Promotion> promotions = List.empty();
  List<School> schools = List.empty();

  Group();
  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    var promotionJsonList = json['promotions'] as List;
    promotions = promotionJsonList.map((i) => Promotion.fromJson(i)).toList();
    var schoolJsonList = json['schools'];
    schools = new List<School>.from(schoolJsonList.map((i) => School.fromJson(i)).toList());
  }
}
