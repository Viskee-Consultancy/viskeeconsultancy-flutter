import 'package:viskeeconsultancy/models/Department.dart';

import 'Course.dart';

class School {
  String? name;
  List<Course> courses = List.empty();
  List<Department> departments = [];

  School(String name, List<Course> courses) {
    this.name = name;
    this.courses = courses;
  }

  School.fromJson(Map<String, dynamic> json) {
    // name = json["name"];
    if (json['courses'] == null) return;
    var courseJsonList = json['courses'] as List;
    courses = courseJsonList.map((i) => Course.fromJson(i)).toList();
  }
}
