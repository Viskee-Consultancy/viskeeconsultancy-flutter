import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/Promotions.dart';
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
    final responseACE = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/AIBT/ACE_AVIATION_AEROSPACE_ACADEMY.json"));

    final responseBESPOKE = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/AIBT/BESPOKE_GRAMMAR_SCHOOL_OF_ENGLISH.json"));

    final responseBRANSON = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/AIBT/BRANSON_SCHOOL_OF_BUSINESS_AND_TECHNOLOGY.json"));

    final responseDIANA = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/AIBT/DIANA_SCHOOL_OF_COMMUNITY_SERVICES.json"));

    final responseEDISON = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/AIBT/EDISON_SCHOOL_OF_TECH_SCIENCES.json"));

    final responseSHELDON = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/AIBT/SHELDON_SCHOOL_OF_HOSPITALITY.json"));

    final responseREACH = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Course/JSON/REACH/REACH_COMMUNITY_COLLEGE.json"));

    final aibtPromotionResponse = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Promotion/JSON/aibt-promotions.json"));

    final reachPromotionResponse = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/AibtGlobal/Viskee-Consultancy-Configuration/master/Promotion/JSON/reach-promotions.json"));

    if (responseACE.statusCode == 200 && responseBESPOKE.statusCode == 200 && responseBRANSON.statusCode == 200 
    && responseDIANA.statusCode == 200 && responseEDISON.statusCode == 200 && responseSHELDON.statusCode == 200 
    && responseREACH.statusCode == 200) {
      final aceData = await json.decode(responseACE.body);
      School ace = School.fromJson(aceData);
      ace.name = "ACE AVIATION AEROSPACE ACADEMY";

      final bespokeData = await json.decode(responseBESPOKE.body);
      School bespoke = School.fromJson(bespokeData);
      bespoke.name = "BESPOKE GRAMMAR SCHOOL OF ENGLISH";

      final bransonData = await json.decode(responseBRANSON.body);
      School branson = School.fromJson(bransonData);
      branson.name = "BRANSON SCHOOL OF BUSINESS AND TECHNOLOGY";

      final dianaData = await json.decode(responseDIANA.body);
      School diana = School.fromJson(dianaData);
      diana.name = "DIANA SCHOOL OF COMMUNITY SERVICES";

      final edisonData = await json.decode(responseEDISON.body);
      School edison = School.fromJson(edisonData);
      edison.name = "EDISON SCHOOL OF TECH SCIENCES";

      final sheldonData = await json.decode(responseSHELDON.body);
      School sheldon = School.fromJson(sheldonData);
      sheldon.name = "SHELDON SCHOOL OF HOSPITALITY";

      final reachData = await json.decode(responseREACH.body);
      School reachSchool = School.fromJson(reachData);
      reachSchool.name = "REACH COMMUNITY COLLEGE";
      
      aibt = new Group();
      List<School> aibtSchools = <School>[];
      aibtSchools.add(ace);
      aibtSchools.add(bespoke);
      aibtSchools.add(branson);
      aibtSchools.add(diana);
      aibtSchools.add(edison);
      aibtSchools.add(sheldon);
      aibt!.schools = aibtSchools;
      aibt!.name = "AIBT";
      if (aibtPromotionResponse.statusCode == 200) {
        final aibtPromotionData = await json.decode(aibtPromotionResponse.body);
        Promotions aibtPromotion = Promotions.fromJson(aibtPromotionData);
        aibt!.promotions = aibtPromotion.promotions;
      }

      reach = new Group();
      List<School> reachSchools = <School>[];
      reachSchools.add(reachSchool);
      reach!.schools = reachSchools;
      reach!.name = "REACH";
      if (reachPromotionResponse.statusCode == 200) {
        final reachPromotionData = await json.decode(reachPromotionResponse.body);
        Promotions reachPromotion = Promotions.fromJson(reachPromotionData);
        reach!.promotions = reachPromotion.promotions;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text(
            'Cannot load configuration file successfully, please try later.'),
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
                            child: new Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: CustomColors.GOLD),
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(8),
                                  )),
                              child: new Material(
                                child: new InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SchoolLogoPage(aibt!)));
                                    },
                                    child: Image.asset(
                                        "images/aibt_portrait.png")),
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          Expanded(flex: 2, child: Container(child: null)),
                          Expanded(
                            flex: 1,
                            child: new Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: CustomColors.GOLD),
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(8),
                                  )),
                              child: new Material(
                                child: new InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SchoolCoursesPage(
                                                      reach!.schools[0],
                                                      reach!.promotions)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                          "images/reach_portrait.png"),
                                    )),
                                color: Colors.transparent,
                              ),
                            ),
                          ),
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
          SearchUtils.isDurationMatch(course, year, week);
      bool isLocationMatch =
          SearchUtils.isLocationMatch(course.locationList, splitList);
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

  void _itemSelected(
      Course? suggestion, List<Course> suggestions, BuildContext context) {
    String query = suggestion!.name!;
    this._typeAheadController.text = query;
    suggestions = _getCourseSuggestions(query, courses, suggestions);
    if (suggestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Please enter the search text'),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SearchResultPage(
              _buildSearchResult(query, suggestions))));
    }
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
          {_itemSelected(suggestion, suggestions, context)},
    );
  }
}
