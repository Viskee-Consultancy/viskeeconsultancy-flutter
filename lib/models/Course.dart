import 'GroupEnum.dart';

class Course {
  /**
   * Basic attributes
   */
  GroupEnum? group;
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
    tuitionDetail = json["tuitionDetail"];
    tuitionHalf = json["tuitionHalf"];
    tuitionHalfDetail = json["tuitionHalfDetail"];
    location = json["location"];
    locationDetail = json["locationDetail"];
    if (location == null) {
      location = "";
    }
    locationList = location!.split("/");
    placementFee = json["placementFee"];
    placementDuration = json["placementDuration"];
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

  String getPromotionDurationString() {
    if (promotionDuration != null && promotionDuration != 0) {
      return promotionDuration.toString() + " Weeks";
    } else {
      return promotionMinDuration.toString() + " - " + promotionMaxDuration.toString() + " Weeks";
    }
  }

  String getTuitionString() {
    if (tuition != null && tuition!.isNotEmpty) {
      return "\$ " + tuition.toString();
    }
    return "";
  }

  String getPromotionTuitionString() {
    if (promotionTuition != null && promotionTuition!.isNotEmpty) {
      return "\$ " + promotionTuition.toString();
    }
    return "";
  }

  String getTuitionHalfString() {
    if (tuitionHalf != null && tuitionHalf!.isNotEmpty) {
      return "Tuition Half Payment: \$ " + tuitionHalf.toString();
    }
    return "";
  }

  String getPromotionTuitionHalfString() {
    if (promotionTuitionHalf != null && promotionTuitionHalf!.isNotEmpty) {
      return "Tuition Half Payment: \$ " + promotionTuitionHalf.toString();
    }
    return "";
  }

  String getTuitionHalfDetailString() {
    if (tuitionHalfDetail != null) {
      return tuitionHalfDetail.toString();
    }
    return "";
  }

  String getPromotionTuitionHalfDetailString() {
    if (promotionTuitionHalfDetail != null) {
      return promotionTuitionHalfDetail.toString();
    }
    return "";
  }

  String getPlacementFeeString() {
    if (placementFee != null && placementFee!.isNotEmpty) {
      return "Placement Fee: \$ " + placementFee.toString();
    }
    return "";
  }

  String getPromotionPlacementFeeString() {
    if (promotionPlacementFee != null && promotionPlacementFee!.isNotEmpty) {
      return "Placement Fee: \$ " + promotionPlacementFee.toString();
    }
    return "";
  }

  String getPlacementDurationString() {
    if (placementDuration != null && placementDuration!.isNotEmpty) {
      return "Placement Duration: \$ " + placementDuration.toString();
    }
    return "";
  }

  String getPromotionPlacementDurationString() {
    if (promotionPlacementDuration != null && promotionPlacementDuration!.isNotEmpty) {
      return "Placement Duration: " + promotionPlacementDuration.toString() + " hours";
    }
    return "";
  }

  String getPlacementDetailString() {
    if (placementDuration != null) {
      return placementDetail.toString();
    }
    return "";
  }

  String getPromotionPlacementDetailString() {
    if (promotionPlacementDetail != null) {
      return promotionPlacementDetail.toString();
    }
    return "";
  }

  bool isPromotionDurationChange() {
    if (isOnPromotion) {
      if (promotionDuration != null) {
        return duration != promotionDuration;
      }
      if (promotionMinDuration != null) {
        return durationMin != promotionMinDuration;
      }
      if (promotionMaxDuration != null) {
        return durationMax != promotionMaxDuration;
      }
    }
    return false;
  }

  bool isPromotionDurationDetailChange() {
    if (isOnPromotion) {
      if (promotionDurationDetail != null) {
        return promotionDurationDetail!.trim().toLowerCase() != durationDetail!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionLocationChange() {
    if (isOnPromotion) {
      if (promotionLocation != null) {
        return promotionLocation!.trim().toLowerCase() != location!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionLocationDetailChange() {
    if (isOnPromotion) {
      if (promotionLocationDetail != null) {
        return promotionLocationDetail!.trim().toLowerCase() != locationDetail!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionTuitionChange() {
    if (isOnPromotion) {
      if (promotionTuition != null) {
        return promotionTuition!.trim().toLowerCase() != tuition!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionTuitionDetailChange() {
    if (isOnPromotion) {
      if (promotionTuitionDetail != null) {
        return promotionTuitionDetail!.trim().toLowerCase() != tuitionDetail!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionTuitionHalfChange() {
    if (isOnPromotion) {
      if (promotionTuitionHalf != null) {
        return promotionTuitionHalfDetail!.trim().toLowerCase() != tuitionHalfDetail!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionTuitionHalfDetailChange() {
    if (isOnPromotion) {
      if (promotionTuitionHalfDetail != null) {
        return promotionTuitionHalfDetail!.trim().toLowerCase() != tuitionHalfDetail!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionPlacementDurationChange() {
    if (isOnPromotion) {
      if (promotionPlacementDuration != null) {
        return promotionPlacementDuration!.trim().toLowerCase() != placementDuration!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionPlacementFeeChange() {
    if (isOnPromotion) {
      if (promotionPlacementFee != null) {
        return promotionPlacementFee!.trim().toLowerCase() != placementFee!.trim().toLowerCase();
      }
    }
    return false;
  }

  bool isPromotionPlacementDetailChange() {
    if (isOnPromotion) {
      if (promotionPlacementDetail != null) {
        return promotionPlacementDetail!.trim().toLowerCase() != placementDetail!.trim().toLowerCase();
      }
    }
    return false;
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
