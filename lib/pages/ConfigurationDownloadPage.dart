import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viskeeconsultancy/models/Brochures.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/MainPage.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

class MyAppOne extends StatefulWidget {
  late SubFolderEnum subfolder;

  MyAppOne(SubFolderEnum subFolderEnum) {
    this.subfolder = subFolderEnum;
  }

  @override
  ConfigurationDownloadPage createState() =>
      ConfigurationDownloadPage(subfolder);
}

class ConfigurationDownloadPage extends State<MyAppOne> {
  late SubFolderEnum subfolder;

  ConfigurationDownloadPage(SubFolderEnum subFolderEnum) {
    this.subfolder = subFolderEnum;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    downloadConfigurations(context).then((value) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MainPage(aibtGroup, reachGroup))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
        Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.center,
              child: Image.asset("images/vc_logo_landscape.png")),
        ),
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
        SizedBox(
          height: 5,
          child: new LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.GOLD),
            backgroundColor: Colors.white,
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
      ])),
    );
  }

  Group aibtGroup = new Group();
  Group aibtPromotionGroup = new Group();
  Group reachGroup = new Group();
  Group reachPromotionGroup = new Group();
  List<Course> courses = [];

  String buildSubUrl(SubFolderEnum subFolderEnum) {
    switch (subFolderEnum) {
      case SubFolderEnum.COE:
        return StringConstants.ONSHORE_URL + StringConstants.COE_URL;
      case SubFolderEnum.NON_COE:
        return StringConstants.ONSHORE_URL + StringConstants.NON_COE_URL;
      case SubFolderEnum.SEAPAE:
        return StringConstants.OFFSHORE_URL + StringConstants.SEAPAE_URL;
      case SubFolderEnum.SISMIC:
        return StringConstants.OFFSHORE_URL + StringConstants.SISMIC_URL;
      default:
        return "";
    }
  }

  Future<void> downloadBasicConfigurationFiles(
      var context, String subUrl) async {
    String aibtSubUrl = subUrl + StringConstants.AIBT_URL;
    // AIBT School Configurations
    final aceResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtSubUrl +
            StringConstants.ACE_FILE_NAME));
    final bespokeResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtSubUrl +
            StringConstants.BESPOKE_FILE_NAME));
    final bransonResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtSubUrl +
            StringConstants.BRANSON_FILE_NAME));
    final dianaResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtSubUrl +
            StringConstants.DIANA_FILE_NAME));
    final edisonResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtSubUrl +
            StringConstants.EDISON_FILE_NAME));
    final sheldonResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtSubUrl +
            StringConstants.SHELDON_FILE_NAME));
    // REACH School Configurations
    String reachSubUrl = subUrl + StringConstants.REACH_URL;
    final reachResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            reachSubUrl +
            StringConstants.REACH_FILE_NAME));

    String aibtPromotionSubUrl =
        subUrl + StringConstants.AIBT_URL + StringConstants.PROMOTIONS_URL;
    // AIBT School Promotion Configurations
    final acePromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtPromotionSubUrl +
            StringConstants.ACE_FILE_NAME));
    final bespokePromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtPromotionSubUrl +
            StringConstants.BESPOKE_FILE_NAME));
    final bransonPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtPromotionSubUrl +
            StringConstants.BRANSON_FILE_NAME));
    final dianaPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtPromotionSubUrl +
            StringConstants.DIANA_FILE_NAME));
    final edisonPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtPromotionSubUrl +
            StringConstants.EDISON_FILE_NAME));
    final sheldonPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            aibtPromotionSubUrl +
            StringConstants.SHELDON_FILE_NAME));
    // REACH School Promotion Configurations
    String reachPromotionSubUrl =
        subUrl + StringConstants.REACH_URL + StringConstants.PROMOTIONS_URL;
    final reachPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL +
            reachPromotionSubUrl +
            StringConstants.REACH_FILE_NAME));

    if (aceResponse.statusCode != 200 &&
        bespokeResponse.statusCode != 200 &&
        bransonResponse.statusCode != 200 &&
        dianaResponse.statusCode != 200 &&
        edisonResponse.statusCode != 200 &&
        sheldonResponse.statusCode != 200 &&
        reachResponse.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text(
            'Cannot load configuration file successfully, please try later.'),
      ));
    } else {
      List<School> aibtSchools = <School>[];
      List<School> reachSchools = <School>[];

      School? ace = await mergePromotionToBasic(
          aceResponse, acePromotionResponse, "ACE AVIATION AEROSPACE ACADEMY");
      School? bespoke = await mergePromotionToBasic(bespokeResponse,
          bespokePromotionResponse, "BESPOKE GRAMMAR SCHOOL OF ENGLISH");
      School? branson = await mergePromotionToBasic(
          bransonResponse,
          bransonPromotionResponse,
          "BRANSON SCHOOL OF BUSINESS AND TECHNOLOGY");
      School? diana = await mergePromotionToBasic(dianaResponse,
          dianaPromotionResponse, "DIANA SCHOOL OF COMMUNITY SERVICES");
      School? edison = await mergePromotionToBasic(edisonResponse,
          edisonPromotionResponse, "EDISON SCHOOL OF TECH SCIENCES");
      School? sheldon = await mergePromotionToBasic(sheldonResponse,
          sheldonPromotionResponse, "SHELDON SCHOOL OF HOSPITALITY");
      School? reach = await mergePromotionToBasic(
          reachResponse, reachPromotionResponse, "REACH COMMUNITY COLLEGE");

      if (ace != null) {
        aibtSchools.add(ace);
      }
      if (bespoke != null) {
        aibtSchools.add(bespoke);
      }
      if (branson != null) {
        aibtSchools.add(branson);
      }
      if (diana != null) {
        aibtSchools.add(diana);
      }
      if (edison != null) {
        aibtSchools.add(edison);
      }
      if (sheldon != null) {
        aibtSchools.add(sheldon);
      }
      if (reach != null) {
        reachSchools.add(reach);
      }
      aibtGroup.schools = aibtSchools;
      aibtGroup.name = "AIBT";

      reachGroup.schools = reachSchools;
      reachGroup.name = "REACH";
    }
  }

  Future<void> downloadBrochureConfigurationFiles(String subUrl) async {
    // AIBT Brochure Configuration
    final aibtBrochureResponse = await http.get(Uri.parse(
        StringConstants.BROCHURE_BASE_URL +
            subUrl +
            StringConstants.AIBT_BROCHURE_FILE_NAME));

    // REACH Brochure Configuration
    final reachBrochureResponse = await http.get(Uri.parse(
        StringConstants.BROCHURE_BASE_URL +
            subUrl +
            StringConstants.REACH_BROCHURE_FILE_NAME));

    if (aibtBrochureResponse.statusCode == 200) {
      final aibtBrochureData = await json.decode(aibtBrochureResponse.body);
      Brochures aibtBrochures = Brochures.fromJson(aibtBrochureData);
      aibtGroup.brochures = aibtBrochures.brochures;
    }

    if (reachBrochureResponse.statusCode == 200) {
      final reachBrochureData = await json.decode(reachBrochureResponse.body);
      Brochures reachBrochures = Brochures.fromJson(reachBrochureData);
      reachGroup.brochures = reachBrochures.brochures;
    }
  }

  Future<void> downloadConfigurations(var context) async {
    String subUrl = buildSubUrl(subfolder);
    await downloadBasicConfigurationFiles(context, subUrl);
    await downloadBrochureConfigurationFiles(subUrl);
  }

  Future<School?> mergePromotionToBasic(
      var basicResponse, var promotionResponse, String schoolName) async {
    School? basicSchool;
    if (basicResponse.statusCode == 200) {
      final basicData = await json.decode(basicResponse.body);
      basicSchool = School.fromJson(basicData);
      basicSchool.name = schoolName;
    } else {
      return basicSchool;
    }
    School? promotionSchool;
    if (promotionResponse.statusCode == 200) {
      final promotionData = await json.decode(promotionResponse.body);
      promotionSchool = School.fromJson(promotionData);

      List<Course> promotionCourses = promotionSchool.courses;
      Map<String, Course> map = new Map();
      for (Course promotionCourse in promotionCourses) {
        String key = buildCourseKey(promotionCourse);
        map[key] = promotionCourse;
      }
      for (Course course in basicSchool.courses) {
        String courseKey = buildCourseKey(course);
        Course? promotionCourse = map[courseKey];
        if (promotionCourse != null) {
          course.isOnPromotion = true;
          course.promotionDuration = promotionCourse.duration;
          course.promotionDurationDetail = promotionCourse.durationDetail;
          course.promotionTuition = promotionCourse.tuition;
        }
      }
    } else {
      return basicSchool;
    }
    return basicSchool;
  }

  String buildCourseKey(Course course) {
    String key = "";
    if (course.vetCode != null) {
      key += "_" + course.vetCode!;
    }
    if (course.cricosCode != null) {
      key += "_" + course.cricosCode!;
    }
    if (course.name != null) {
      key += "_" + course.name!.trim().toLowerCase();
    }
    return key;
  }
}
