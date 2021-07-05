import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/util/SearchUtils.dart';

import '../values/CustomColors.dart';
import 'SchoolCoursesPage.dart';
import 'SchoolLogoPage.dart';
import 'SearchResultPage.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatelessWidget {
  Group? aibt;
  Group? reach;
  List<Course> courses = [];

  Future<void> readJson(var context) async {
           
    final responseAIBT = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/configuration/AIBT.json"));

    final responseREACH = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/configuration/REACH.json"));
    if (responseAIBT.statusCode == 200 && responseREACH.statusCode == 200) {
      final aibtData = await json.decode(responseAIBT.body);
      aibt = Group.fromJson(aibtData);
      final reachData = await json.decode(responseREACH.body);

      reach = Group.fromJson(reachData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
    }

    prepareCourses();
  }

  void prepareCourses() {
    List<School> aibtSchools = aibt!.schools;
    List<School> reachSchools = reach!.schools;

    List<Course> aibtCourses = [];
    for (var school in aibtSchools) {
      aibtCourses.addAll(school.courses);
    }

    aibtCourses.forEach((course) => course.group = GroupEnum.AIBT);

    List<Course> reachCourses = [];
    for (var school in reachSchools) {
      reachCourses.addAll(school.courses);
    }
    reachCourses.forEach((course) => course.group = GroupEnum.REACH);

    courses.addAll(aibtCourses);
    courses.addAll(reachCourses);
  }

  @override
  Widget build(BuildContext context) {
    readJson(context);
    return MaterialApp(
      title: 'Viskee Consultancy',
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background_portrait.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset("images/vc_logo_landscape.png"),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(child: null),
                ),
                Expanded(
                  flex: 6,
                  child: Text("Explore Over 90+ Courses and Promotions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.GOLD)),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 60, maxHeight: 100),
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: CustomColors.GOLD),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(8)),
                            ),
                            child: new AutocompleteBasicExample(courses)))),
                Expanded(
                  flex: 2,
                  child: Container(child: null),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(flex: 1, child: Container(child: null)),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  child: Ink(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: CustomColors.GOLD),
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(8)),
                                    ),
                                    child:
                                        Image.asset("images/aibt_portrait.png"),
                                  )),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SchoolLogoPage(aibt!)));
                                  })),
                          Expanded(flex: 2, child: Container(child: null)),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  child: Ink(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: CustomColors.GOLD),
                                            color: Colors.grey,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    const Radius.circular(8)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Image.asset(
                                                "images/reach_portrait.png"),
                                          ))),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SchoolCoursesPage(
                                                    reach!.schools[0],
                                                    reach!.promotions)));
                                  })),
                          Expanded(flex: 1, child: Container(child: null))
                        ]))
              ],
            )),
      ),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  List<Course> courses = [];
  AutocompleteBasicExample(List<Course> courses) {
    this.courses = courses;
  }

  final TextEditingController _typeAheadController = TextEditingController();

  List<Course> _getCourseSuggestions(
      String query, List<Course> courses, List<Course> suggestions) {
    if (query == '') {
      return List.empty();
    }
    suggestions.clear();
    String searchText = query.toLowerCase();
    searchText = searchText.replaceAll("+", "");
    searchText = searchText.replaceAll("(", "");
    searchText = searchText.replaceAll(")", "");
    for (var course in courses) {
      List<String> splitList = searchText.split(" ");
      num? year = SearchUtils.extractYear(splitList);
      num? week = SearchUtils.extractWeek(splitList);
      bool isDurationMatch =
          SearchUtils.isDurationMatch(course.duration!, year, week);
      bool isLocationMatch =
          SearchUtils.isLocationMatch(course.location, splitList);
      bool isTextMatch =
          SearchUtils.isTextMatch(course.toString().toLowerCase(), splitList);
      if (isDurationMatch && isLocationMatch && isTextMatch) {
        suggestions.add(course);
      }
    }
    return suggestions;
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
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SearchResultPage(_buildSearchResult(query, suggestions))));
          }
        },
      ),
      itemBuilder: (context, suggestion) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(suggestion!.name!),
      ),
      suggestionsCallback: (query) =>
          _getCourseSuggestions(query, courses, suggestions),
      onSuggestionSelected: (suggestion) =>
          {this._typeAheadController.text = suggestion!.name!},
    );
  }
}
