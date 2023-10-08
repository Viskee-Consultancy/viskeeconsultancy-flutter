import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/util/SearchUtils.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

import '../values/CustomColors.dart';
import 'SchoolLogoPage.dart';
import 'SearchResultPage.dart';

class MainPage extends StatelessWidget {
  late final Group _aibt;
  late final Group _aibt_i;
  late final Group _reach;
  late final Group _avta;
  late final Group _npa;
  late final List<Course> _courses = [];

  MainPage(Group aibtGroup, Group aibtIGroup, Group reachGroup, Group avtaGroup, Group npaGroup, List<Course> totalCourses) {
    this._aibt = aibtGroup;
    this._aibt_i = aibtIGroup;
    this._reach = reachGroup;
    this._avta = avtaGroup;
    this._npa = npaGroup;
    this._courses.addAll(totalCourses);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Utils.onBackPressed(context, true);
          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonWidgets.getAppBar(context, true),
            body: Stack(
              children: [
                Image.network(
                  "https://github.com/Viskee-Consultancy/Viskee-Consultancy-Configuration/raw/master/background/background.png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(
                      "images/background.png",
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(child: null),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text("Explore Over 90+ Courses and Promotions",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 60, maxHeight: 100),
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: CustomColors.GOLD),
                                    borderRadius: const BorderRadius.all(const Radius.circular(8)),
                                  ),
                                  child: new CourseSearchAutocomplete(_courses)))),
                      Expanded(
                        flex: 1,
                        child: Container(child: null),
                      ),
                      Expanded(
                          flex: 5,
                          child: Column(children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              Expanded(flex: 1, child: Container(child: null)),
                              Container(
                                constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                                child: new OutlinedButton(
                                  onPressed: () {
                                    NavigationPath.PATH.add(StringConstants.PATH_AIBT);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: SchoolLogoPage(_aibt), type: PageTransitionType.rightToLeft));
                                  },
                                  child: Utils.isRunningOnMobileBrowser()
                                      ? Padding(padding: EdgeInsets.all(10), child: Image.asset("images/aibt.png"))
                                      : SvgPicture.asset("images/aibt.svg"),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.grey,
                                    backgroundColor: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15),
                                    side: BorderSide(width: 1.0, color: CustomColors.GOLD),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container(child: null)),
                              Container(
                                constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                                child: new OutlinedButton(
                                  onPressed: () {
                                    NavigationPath.PATH.add(StringConstants.PATH_REACH);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: SchoolLogoPage(_reach), type: PageTransitionType.rightToLeft));
                                  },
                                  child: Utils.isRunningOnMobileBrowser()
                                      ? Padding(padding: EdgeInsets.all(10), child: Image.asset("images/reach.png"))
                                      : SvgPicture.asset("images/reach.svg"),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.grey,
                                    backgroundColor: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15),
                                    side: BorderSide(width: 1.0, color: CustomColors.GOLD),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container(child: null))
                            ]),
                            Spacer(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              Expanded(flex: 1, child: Container(child: null)),
                              Container(
                                constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                                child: new OutlinedButton(
                                  onPressed: () {
                                    NavigationPath.PATH.add(StringConstants.PATH_AVTA);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: SchoolLogoPage(_avta), type: PageTransitionType.rightToLeft));
                                  },
                                  child: Utils.isRunningOnMobileBrowser()
                                      ? Padding(padding: EdgeInsets.all(10), child: Image.asset("images/avta.png"))
                                      : SvgPicture.asset("images/avta.svg"),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.grey,
                                    backgroundColor: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15),
                                    side: BorderSide(width: 1.0, color: CustomColors.GOLD),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container(child: null)),
                              Container(
                                constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                                child: new OutlinedButton(
                                  onPressed: () {
                                    NavigationPath.PATH.add(StringConstants.PATH_NPA);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: SchoolLogoPage(_npa), type: PageTransitionType.rightToLeft));
                                  },
                                  child: Utils.isRunningOnMobileBrowser()
                                      ? Padding(padding: EdgeInsets.all(10), child: Image.asset("images/npa.png"))
                                      : SvgPicture.asset("images/npa.svg"),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.grey,
                                    backgroundColor: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15),
                                    side: BorderSide(width: 1.0, color: CustomColors.GOLD),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container(child: null)),
                              Container(
                                constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                                child: new OutlinedButton(
                                  onPressed: () {
                                    NavigationPath.PATH.add(StringConstants.PATH_AIBT_I);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: SchoolLogoPage(_aibt_i), type: PageTransitionType.rightToLeft));
                                  },
                                  child: Utils.isRunningOnMobileBrowser()
                                      ? Padding(padding: EdgeInsets.all(10), child: Image.asset("images/aibt-i.png"))
                                      : SvgPicture.asset("images/aibt.svg"),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.grey,
                                    backgroundColor: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15),
                                    side: BorderSide(width: 1.0, color: CustomColors.GOLD),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container(child: null))
                            ],)
                          ],)),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: null,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

class CourseSearchAutocomplete extends StatelessWidget {
  late final List<Course> _courses = [];

  CourseSearchAutocomplete(List<Course> courses) {
    this._courses.addAll(courses);
  }

  final TextEditingController _typeAheadController = TextEditingController();

  List<Course> _getCourseSuggestions(String query, List<Course> courses, List<Course> suggestions) {
    if (query.trim().isEmpty) {
      return List.empty();
    }
    suggestions.clear();
    String searchText = query.toLowerCase();
    searchText = searchText.replaceAll("+", "");
    searchText = searchText.replaceAll("(", "");
    searchText = searchText.replaceAll(")", "");
    searchText = searchText.replaceAll("\r", "");
    searchText = searchText.replaceAll("\n", "");
    searchText = searchText.replaceAll("#", "");
    for (var course in courses) {
      List<String> splitList = searchText.split(" ");
      num? year = SearchUtils.extractYear(splitList);
      num? week = SearchUtils.extractWeek(splitList);
      bool isDurationMatch = SearchUtils.isDurationMatch(course, year, week);
      bool isLocationMatch = SearchUtils.isLocationMatch(course.locationList, splitList);
      bool isTextMatch = SearchUtils.isTextMatch(course.toString().toLowerCase(), splitList);
      if (isDurationMatch && isLocationMatch && isTextMatch) {
        suggestions.add(course);
      }
    }
    suggestions.sort((o1, o2) => o1.name!.compareTo(o2.name!));
    List<Course> suggestionsWithoutDuplicate = List.from(suggestions);
    Set<String> duplicates = new Set();
    suggestionsWithoutDuplicate.removeWhere((e) => !duplicates.add(e.name!));
    return suggestionsWithoutDuplicate;
  }

  SearchResult _buildSearchResult(String query, List<Course> suggestions) {
    List<Course> aibtCourses = [];
    List<Course> aibtICourses = [];
    List<Course> reachCourses = [];
    List<Course> avtaCourses = [];
    List<Course> npaCourses = [];
    for (Course course in suggestions) {
      if (course.group == GroupEnum.AIBT) {
        aibtCourses.add(course);
      } else if (course.group == GroupEnum.AIBT_I) {
        aibtICourses.add(course);
      } else if (course.group == GroupEnum.REACH) {
        reachCourses.add(course);
      } else if (course.group == GroupEnum.AVTA){
        avtaCourses.add(course);
      } else {
        npaCourses.add(course);
      }
    }

    List<School> aibtSchools = [];
    Map<String, List<Course>> m = new Map();
    for (var i = 0; i < aibtCourses.length; i++) {
      var course = aibtCourses[i];
      if (m[course.schoolName] == null) {
        List<Course> courses = [course];
        m[course.schoolName!] = courses;
      } else {
        m[course.schoolName!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {aibtSchools.add(new School(entry.key, entry.value))});

    List<School> aibtISchools = [];
    m = new Map();
    for (var i = 0; i < aibtICourses.length; i++) {
      var course = aibtICourses[i];
      if (m[course.schoolName] == null) {
        List<Course> courses = [course];
        m[course.schoolName!] = courses;
      } else {
        m[course.schoolName!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {aibtISchools.add(new School(entry.key, entry.value))});

    List<School> reachSchools = [];
    m = new Map();
    for (var i = 0; i < reachCourses.length; i++) {
      var course = reachCourses[i];
      if (m[course.schoolName] == null) {
        List<Course> courses = [course];
        m[course.schoolName!] = courses;
      } else {
        m[course.schoolName!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {reachSchools.add(new School(entry.key, entry.value))});

    List<School> avtaSchools = [];
    m = new Map();
    for (var i = 0; i < avtaCourses.length; i++) {
      var course = avtaCourses[i];
      if (m[course.schoolName] == null) {
        List<Course> courses = [course];
        m[course.schoolName!] = courses;
      } else {
        m[course.schoolName!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {avtaSchools.add(new School(entry.key, entry.value))});

    List<School> npaSchools = [];
    m = new Map();
    for (var i = 0; i < npaCourses.length; i++) {
      var course = npaCourses[i];
      if (m[course.schoolName] == null) {
        List<Course> courses = [course];
        m[course.schoolName!] = courses;
      } else {
        m[course.schoolName!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {npaSchools.add(new School(entry.key, entry.value))});

    SearchResult searchResult = new SearchResult();
    searchResult.searchResults[GroupEnum.AIBT] = aibtSchools;
    searchResult.searchResults[GroupEnum.AIBT_I] = aibtISchools;
    searchResult.searchResults[GroupEnum.REACH] = reachSchools;
    searchResult.searchResults[GroupEnum.AVTA] = avtaSchools;
    searchResult.searchResults[GroupEnum.NPA] = npaSchools;
    searchResult.searchText = query;
    return searchResult;
  }

  void _itemSelected(Course? suggestion, List<Course> suggestions, BuildContext context) {
    String query = suggestion!.name!;
    query = query.replaceAll("\r", "");
    query = query.replaceAll("\n", "");
    this._typeAheadController.text = query;
    _getCourseSuggestions(query, _courses, suggestions);
    Navigator.push(
        context,
        PageTransition(
            child: SearchResultPage(_buildSearchResult(query, suggestions)), type: PageTransitionType.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    List<Course> suggestions = [];
    return TypeAheadFormField<Course?>(
      textFieldConfiguration: TextFieldConfiguration(
        cursorColor: CustomColors.GOLD,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            prefixIcon: Theme(
              data: Theme.of(context).copyWith(primaryColor: CustomColors.GREY),
              child: Icon(
                Icons.search_outlined,
              ),
            ),
            hintText: "Search for a course",
            focusColor: CustomColors.GOLD,
            fillColor: CustomColors.GOLD),
        controller: this._typeAheadController,
        onSubmitted: (query) {
          if (query.trim().isEmpty) {
            suggestions.clear();
          }
          if (suggestions.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: CustomColors.GOLD,
              duration: Duration(milliseconds: 2000),
              content: Text('Please enter the search text'),
            ));
          } else {
            Navigator.push(
                context,
                PageTransition(
                    child: SearchResultPage(_buildSearchResult(query, suggestions)),
                    type: PageTransitionType.rightToLeft));
          }
        },
      ),
      itemBuilder: (context, suggestion) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(suggestion!.name!),
      ),
      suggestionsCallback: (query) => _getCourseSuggestions(query, _courses, suggestions),
      onSuggestionSelected: (suggestion) => {_itemSelected(suggestion, suggestions, context)},
    );
  }
}
