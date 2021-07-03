class SearchUtils {
  static const String YEAR = "year";
  static const String YEARS = "years";
  static const String WEEK = "week";
  static const String WEEKS = "weeks";
  static const String WKS = "wks";

  static const Map<String, List<String>> LOCATION_MAP = {
    "nsw": ["nsw", "new south wales", "sydney"],
    "new south wales": ["nsw", "new south wales", "sydney"],
    "sydney": ["nsw", "new south wales", "sydney"],
    "tas": ["tas", "tasmania", "hobart"],
    "tasmania": ["tas", "tasmania", "hobart"],
    "hobart": ["tas", "tasmania", "hobart"],
    "qld": ["qld", "queensland", "brisbane"],
    "queensland": ["qld", "queensland", "brisbane"],
    "brisbane": ["qld", "queensland", "brisbane"],
  };

  static const List<String> LOCATION_NAME_LIST = [
    "nsw",
    "new south wales",
    "sydney",
    "tas",
    "tasmania",
    "hobart",
    "qld",
    "queensland",
    "brisbane"
  ];

  static extractYear(List<String> splitList) {
    int yearTextIndex = splitList.indexOf(YEAR);
    int yearNumberIndex;
    if (yearTextIndex < 1) {
      yearTextIndex = splitList.indexOf(YEARS);
    }
    if (yearTextIndex >= 1) {
      print("Year Text Index:" + yearTextIndex.toString());
      yearNumberIndex = yearTextIndex - 1;
      String year = splitList[yearNumberIndex];
      if (num.tryParse(year) != null) {
        splitList.removeAt(yearTextIndex);
        splitList.removeAt(yearNumberIndex);
        return num.tryParse(year);
      }
    } else {
      print("Year Text Index:" + yearTextIndex.toString());
      String? splitToRemove;
      num? year;
      print("Split List " + splitList.toString());
      for (var split in splitList) {
        if (split.contains(YEAR)) {
          List<String> strings = split.split(YEAR);
          if (num.tryParse(strings[0]) != null) {
            year = num.tryParse(strings[0]);
            splitToRemove = split;
            break;
          }
        }
        if (split.contains(YEARS)) {
          List<String> strings = split.split(YEARS);
          if (num.tryParse(strings[0]) != null) {
            year = num.tryParse(strings[0]);
            splitToRemove = split;
            break;
          }
        }
      }
      if (splitToRemove != null) {
        print("Split to Remove " + splitToRemove);
        print("Split List before Remove " + splitList.toString());
        splitList.remove(splitToRemove);
        print("Split List after Remove " + splitList.toString());
      }

      return year;
    }
    return null;
  }

  static extractWeek(List<String> splitList) {
    int weekTextIndex = splitList.indexOf(WEEK);
    int weekNumberIndex;
    if (weekTextIndex < 1) {
      weekTextIndex = splitList.indexOf(WEEKS);
    }
    if (weekTextIndex < 1) {
      weekTextIndex = splitList.indexOf(WKS);
    }
    if (weekTextIndex > 1) {
      weekNumberIndex = weekTextIndex - 1;
      String week = splitList[weekNumberIndex];
      if (num.tryParse(week) != null) {
        splitList.remove(weekTextIndex);
        splitList.remove(weekNumberIndex);
        return num.tryParse(week);
      }
    } else {
      String? splitToRemove;
      int? week;
      for (var split in splitList) {
        if (split.contains(WKS)) {
          List<String> strings = split.split(WKS);
          if (num.tryParse(strings[0]) != null) {
            week = int.tryParse(strings[0]);
            splitToRemove = split;
          }
        }
        if (split.contains(WEEK)) {
          List<String> strings = split.split(WEEK);
          if (num.tryParse(strings[0]) != null) {
            week = int.tryParse(strings[0]);
            splitToRemove = split;
          }
        }
        if (split.contains(WEEKS)) {
          List<String> strings = split.split(WEEKS);
          if (num.tryParse(strings[0]) != null) {
            week = int.tryParse(strings[0]);
            splitToRemove = split;
          }
        }
      }
      splitList.remove(splitToRemove);
      return week;
    }
    return null;
  }

  static isDurationMatch(num duration, num? year, num? week) {
    if (year == null && week == null) {
      return true;
    }
    if (week != null) {
      return duration <= week;
    }
    if (year != null) {
      if (year == 1 && duration <= 52) {
        return true;
      }
      if (year == 2 && duration > 52 && duration <= 104) {
        return true;
      }
      if (year > 2 && duration > 104) {
        return true;
      }
    }
    return false;
  }

  static isLocationMatch(List<String> locations, List<String> splitList) {
    bool isLocationSearchTextProvided = false;
    bool isLocationSearchMatch = false;

    String searchText = splitList.join(" ");
    List<String> locationsLowerCase =
        locations.map((location) => location.toLowerCase()).toList();
    for (var locationName in LOCATION_NAME_LIST) {
      if (searchText.contains(locationName)) {
        isLocationSearchTextProvided = true;
        searchText = searchText.replaceFirst(locationName, "");
        List<String>? locationNameList = LOCATION_MAP[locationName];
        if (locationNameList != null &&
            locationNameList.any((item) => locationsLowerCase.contains(item))) {
          isLocationSearchMatch = true;
        }
      }
    }
    splitList.clear();
    splitList.addAll(searchText.split(" "));
    splitList.remove("");
    splitList.remove(" ");
    splitList.remove("  ");
    if (isLocationSearchMatch) {
      return true;
    } else {
      return !isLocationSearchTextProvided;
    }
  }

  static bool isTextMatch(String courseString, List<String> splitList) {
    print("Split List" + splitList.toString());
    if (splitList.isEmpty) return true;
    String searchText = "(.*?)" + splitList.join("(.*?)") + "(.*?)";
    print("Search Text:" + courseString);
    RegExp regExp =
        new RegExp(searchText, caseSensitive: false, multiLine: false);
    return regExp.hasMatch(courseString);
  }
}
