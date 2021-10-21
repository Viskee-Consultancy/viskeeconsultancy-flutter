import 'GroupEnum.dart';

class Course {
  GroupEnum? group;
  String? vetCode;
  String? cricosCode;
  String? department;
  String? name;
  int? duration;
  int? durationMin;
  int? durationMax;
  String? durationDetail;
  String? tuition;
  String? location;
  List<String> locationList = List.empty();
  int? unpaidPlacement;
  String? completeServicePeriods;
  bool isOnPromotion =false;
  int? promotionDuration;
  String? promotionDurationDetail;
  String? promotionLocation;
  String? promotionTuition;

  Course.fromJson(Map<String, dynamic> json) {
    vetCode = json["vetCode"];
    cricosCode = json["cricosCode"];
    department = json["department"];
    name = json["name"];
    if (json["duration"] != null && num.tryParse(json["duration"]) != null) {
      duration = int.tryParse(json["duration"]);
    }
    if (json["durationMin"] != null && num.tryParse(json["durationMin"]) != null) {
      durationMin = int.tryParse(json["durationMin"]);
    }
    if (json["durationMax"] != null && num.tryParse(json["durationMax"]) != null) {
      durationMax = int.tryParse(json["durationMax"]);
    }
    durationDetail = json["durationDetail"];
    tuition = json["tuition"];
    location = json["location"];
    locationList = location!.split("/");
    unpaidPlacement = json["unpaidPlacement"];
    completeServicePeriods = json["completeServicePeriods"];
  }

  String getDurationString() {
    if (duration != 0) {
      return duration.toString();
    } else {
      return durationMin.toString() + " - " + durationMax.toString();
    }
  }

  @override
  String toString() {
    String result = "";
    if (vetCode != null) {
      result = result + "vetCode='" + vetCode! + "'\'";
    }
    if (cricosCode != null) {
      result = result + "cricosCode='" + cricosCode! + "'\'";
    }
    if (department != null) {
      result = result + "department='" + department! + "'\'";
    }
    if (name != null) {
      result = result + "name='" + name! + "'\'";
    }
    return result;
  }
}
