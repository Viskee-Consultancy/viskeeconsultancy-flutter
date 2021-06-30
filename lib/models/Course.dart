import 'GroupEnum.dart';

class Course {
  GroupEnum? group;
  String? vetCode;
  String? cricosCode;
  String? department;
  String? name;
  int? duration;
  String? durationDetail;
  int? offshoreTuition;
  int? onshoreTuition;
  List<String> location = List.empty();
  int? unpaidPlacement;
  String? completeServicePeriods;

    Course.fromJson(Map<String, dynamic> json) {
    vetCode = json["vetCode"];
    cricosCode = json["cricosCode"];
    department = json["department"];
    name = json["name"];
    duration = json["duration"];
    durationDetail = json["durationDetail"];
    offshoreTuition = json["offshoreTuition"];
    onshoreTuition = json["onshoreTuition"];
    var locationList = json["location"] as List;
    location = new List<String>.from(locationList);
    unpaidPlacement = json["unpaidPlacement"];
    completeServicePeriods = json["completeServicePeriods"];
  }
}