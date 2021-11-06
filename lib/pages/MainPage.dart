import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/util/SearchUtils.dart';

import '../values/CustomColors.dart';
import 'SchoolCoursesPage.dart';
import 'SchoolLogoPage.dart';
import 'SearchResultPage.dart';

class MainPage extends StatelessWidget {
  Group? _aibt;
  Group? _reach;
  List<Course> _courses = [];

  MainPage(Group aibtGroup, Group reachGroup, List<Course> totalCourses) {
    this._aibt = aibtGroup;
    this._reach = reachGroup;
    this._courses = totalCourses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonWidgets.getAppBarWhite(context),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: null,
                    )),
                Expanded(
                  flex: 2,
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
                  flex: 2,
                  child: Container(child: null),
                ),
                Expanded(
                  flex: 4,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Expanded(flex: 1, child: Container(child: null)),
                  Container(
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                    child: new OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: SchoolLogoPage(_aibt!), type: PageTransitionType.topToBottom));
                      },
                      child: Utils.isRunningOnMobileBrowser() ? Padding(padding: EdgeInsets.all(10),child: Image.asset("images/aibt.png")) : SvgPicture.asset("images/aibt.svg"),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.grey,
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                        side: BorderSide(width: 1.0, color: CustomColors.GOLD),
                      ),
                    ),
                  ),
                Expanded(flex: 2, child: Container(child: null)),
                Container(
                  constraints: BoxConstraints(minHeight: 50, maxHeight: 120, minWidth: 50, maxWidth: 120),
                  child: new OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: SchoolLogoPage(_reach!), type: PageTransitionType.topToBottom));
                    },
                    child: Utils.isRunningOnMobileBrowser() ? Padding(padding: EdgeInsets.all(10),child: Image.asset("images/reach.png"))  : SvgPicture.asset("images/reach.svg"),
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
              ])),
      Expanded(
        flex: 2,
        child: Container(
          child: null,
        ),
      )
      ],
    )),
    );
  }
}

class CourseSearchAutocomplete extends StatelessWidget {
  List<Course> _courses = [];

  CourseSearchAutocomplete(List<Course> courses) {
    this._courses = courses;
  }

  final TextEditingController _typeAheadController = TextEditingController();

  List<Course> _getCourseSuggestions(String query, List<Course> courses, List<Course> suggestions) {
    if (query == '') {
      return List.empty();
    }
    suggestions.clear();
    String searchText = query.toLowerCase();
    searchText = searchText.replaceAll("+", "");
    searchText = searchText.replaceAll("(", "");
    searchText = searchText.replaceAll(")", "");
    searchText = searchText.replaceAll("\r", "");
    searchText = searchText.replaceAll("\n", "");
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
    List<Course> reachCourses = [];
    for (Course course in suggestions) {
      if (course.group == GroupEnum.AIBT) {
        aibtCourses.add(course);
      } else {
        reachCourses.add(course);
      }
    }
    SearchResult searchResult = new SearchResult();
    searchResult.searchResults[GroupEnum.AIBT] = aibtCourses;
    searchResult.searchResults[GroupEnum.REACH] = reachCourses;
    searchResult.searchText = query;
    return searchResult;
  }

  void _itemSelected(Course? suggestion, List<Course> suggestions, BuildContext context) {
    String query = suggestion!.name!;
    query = query.replaceAll("\r", "");
    query = query.replaceAll("\n", "");
    this._typeAheadController.text = query;
    suggestions = _getCourseSuggestions(query, _courses, suggestions);
    Navigator.push(
        context,
        PageTransition(
            child: SearchResultPage(_buildSearchResult(query, suggestions)),
            type: PageTransitionType.topToBottom));
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
            hintText: "Search for a course",
            fillColor: CustomColors.GOLD),
        controller: this._typeAheadController,
        onSubmitted: (query) {
          if (query.isEmpty) {
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
                    type: PageTransitionType.topToBottom));
          }
        },
      ),
      itemBuilder: (context, suggestion) =>
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(suggestion!.name!),
          ),
      suggestionsCallback: (query) => _getCourseSuggestions(query, _courses, suggestions),
      onSuggestionSelected: (suggestion) => {_itemSelected(suggestion, suggestions, context)},
    );
  }
}
