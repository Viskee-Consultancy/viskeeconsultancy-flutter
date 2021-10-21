import 'Course.dart';

class School {
  String? name;
  List<Course> courses = List.empty();

  School.fromJson(Map<String, dynamic> json) {
    // name = json["name"];
    var courseJsonList = json['courses'] as List;
    courses = courseJsonList.map((i) => Course.fromJson(i)).toList();
  }
}
