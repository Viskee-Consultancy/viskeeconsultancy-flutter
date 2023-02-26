import 'GroupEnum.dart';

class Course {
  /**
   * Basic attributes
   */
  GroupEnum? group;
  String? schoolName;
  String? vetCode;
  String? cricosCode;
  String? department;
  String? name;
  // Duration section
  int? duration;
  int? durationMin;
  int? durationMax;
  String? durationDetail;
  // Tuition section
  String? tuition;
  String? tuitionDetail;
  String? tuitionHalf;
  String? tuitionHalfDetail;
  // Location section
  String? location;
  String? locationDetail;
  List<String> locationList = List.empty();
  // Placement section
  String? placementFee;
  String? placementDuration;
  String? placementDetail;
  String? note;

  /**
   * Promotion attributes
   */
  bool isOnPromotion =false;
  String? promotionValidity;
  // Duration section
  int? promotionDuration;
  int? promotionMinDuration;
  int? promotionMaxDuration;
  String? promotionDurationDetail;
  // Tuition section
  String? promotionTuition;
  String? promotionTuitionDetail;
  String? promotionTuitionHalf;
  String? promotionTuitionHalfDetail;
  // Location section
  String? promotionLocation;
  String? promotionLocationDetail;
  // Placement section
  String? promotionPlacementFee;
  String? promotionPlacementDuration;
  String? promotionPlacementDetail;

  Course.fromJson(Map<String, dynamic> json) {
    vetCode = json["vetCode"];
    cricosCode = json["cricosCode"];
    department = json["department"];
    name = json["name"];
    if (json["duration"] != null && num.tryParse(json["duration"].toString()) != null) {
      duration = int.tryParse(json["duration"].toString());
    }
    if (json["durationMin"] != null && num.tryParse(json["durationMin"].toString()) != null) {
      durationMin = int.tryParse(json["durationMin"].toString());
    }
    if (json["durationMax"] != null && num.tryParse(json["durationMax"].toString()) != null) {
      durationMax = int.tryParse(json["durationMax"].toString());
    }
    durationDetail = json["durationDetail"];
    tuition = json["tuition"].toString();
    tuitionDetail = json["tuitionDetail"];
    tuitionHalf = json["tuitionHalf"].toString();
    tuitionHalfDetail = json["tuitionHalfDetail"];
    location = json["location"];
    locationDetail = json["locationDetail"];
    if (location == null) {
      location = "";
    }
    locationList = location!.split("/");
    placementFee = json["placementFee"].toString();
    placementDuration = json["placementDuration"].toString();
    placementDetail = json["placementDetail"];
    note = json["note"];
    promotionValidity = json["promotionValidity"];
  }

  String getDurationString() {
    if (duration != null && duration != 0) {
      return duration.toString() + " Weeks";
    }
    if (durationMin != null && durationMax != null) {
      return durationMin.toString() + " - " + durationMax.toString() + " Weeks";
    }
    return "";
  }

  String getTuitionString() {
    if (tuition != null && tuition!.isNotEmpty) {
      return "\$ " + tuition.toString();
    }
    return "";
  }

  String getTuitionHalfString() {
    if (tuitionHalf != null && tuitionHalf!.isNotEmpty) {
      return "Tuition Half Payment: \$ " + tuitionHalf.toString();
    }
    return "";
  }

  String getTuitionHalfDetailString() {
    if (tuitionHalfDetail != null) {
      return tuitionHalfDetail.toString();
    }
    return "";
  }

  String getPlacementFeeString() {
    if (placementFee != null && placementFee!.isNotEmpty) {
      return "Placement Fee: \$ " + placementFee.toString();
    }
    return "";
  }

  String getPlacementDurationString() {
    if (placementDuration != null && placementDuration!.isNotEmpty) {
      return "Placement Duration: " + placementDuration.toString() + " hours";
    }
    return "";
  }

  String getPlacementDetailString() {
    if (placementDuration != null) {
      return placementDetail.toString();
    }
    return "";
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
    result = result.replaceAll("\r", "");
    result = result.replaceAll("\n", "");
    return result;
  }
}
