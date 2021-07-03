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

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../values/CustomColors.dart';

class MainPage extends StatelessWidget {
  Group? aibt;
  Group? reach;
  List<Course> courses = [];

  Future<void> readJson() async {
    final String aibtJsonString =
        await rootBundle.loadString('assets/AIBT.json');
    final String reachJsonString =
        await rootBundle.loadString('assets/REACH.json');
    final aibtData = await json.decode(aibtJsonString);
    final reachData = await json.decode(reachJsonString);
    aibt = Group.fromJson(aibtData);
    reach = Group.fromJson(reachData);

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
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Flutter layout demo'),
        // ),
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
                Expanded(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
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
                          Expanded(flex: 2, child: Container(child: null)),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(8)),
                                  ),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.grey),
                                      ),
                                      child: Image.asset(
                                          "images/aibt_portrait.png"),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            "/school_logo_page",
                                            arguments: aibt);
                                      }))),
                          Expanded(flex: 2, child: Container(child: null)),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(8)),
                                  ),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.grey),
                                      ),
                                      child: Image.asset(
                                          "images/reach_portrait.png"),
                                      onPressed: () {
                                        readJson();
                                      }))),
                          Expanded(flex: 2, child: Container(child: null))
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
    searchText.replaceAll("\\+", "");
    print("courses size:" + courses.length.toString());
    for (var course in courses) {
      List<String> splitList = searchText.split(" ");
      num? year = SearchUtils.extractYear(splitList);
      num? week = SearchUtils.extractWeek(splitList);
      bool isDurationMatch =
          SearchUtils.isDurationMatch(course.duration!, year, week);
      // print("isDuration" + isDurationMatch.toString());
      bool isLocationMatch =
          SearchUtils.isLocationMatch(course.location, splitList);
      // print("isLocation" + isLocationMatch.toString());
      bool isTextMatch =
          SearchUtils.isTextMatch(course.toString().toLowerCase(), splitList);
      print("isTextMatch" + isTextMatch.toString());
      if (isDurationMatch && isLocationMatch && isTextMatch) {
        suggestions.add(course);
      }
    }
    print("Suggestions: " + suggestions.toString());
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
    searchResult.searchResults[GroupEnum.AIBT] = aibtCourses;
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
                                        // Navigator.of(context).pushNamed(
                                        //     "/school_logo_page",
                                        //     arguments: new Group());

          Navigator.of(context).pushNamed("/search_result_page",
              arguments: _buildSearchResult(query, suggestions));

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
