import 'Course.dart';

class Department {
  String? name;
  List<Course> courses =List.empty();

  Department(name, List<Course> courses) {
    this.name = name;
    this.courses =courses;
  }
}