import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Brochures.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/MainPage.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

class ConfigurationDownloadPage extends StatefulWidget {
  late SubFolderEnum subfolder;

  ConfigurationDownloadPage(SubFolderEnum subFolderEnum) {
    this.subfolder = subFolderEnum;
  }

  @override
  ConfigurationDownloadAsync createState() => ConfigurationDownloadAsync(subfolder);
}

class ConfigurationDownloadAsync extends State<ConfigurationDownloadPage> {
  late SubFolderEnum subfolder;

  ConfigurationDownloadAsync(SubFolderEnum subFolderEnum) {
    this.subfolder = subFolderEnum;
  }

  Group aibtGroup = new Group();
  Group aibtPromotionGroup = new Group();
  Group reachGroup = new Group();
  Group reachPromotionGroup = new Group();
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    downloadConfigurations(context).then((value) => {
          courses = prepareCourses(aibtGroup, reachGroup),
          Navigator.pushReplacement(context,
              PageTransition(child: MainPage(aibtGroup, reachGroup, courses), type: PageTransitionType.topToBottom))
        });
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
          child: Align(alignment: Alignment.center, child: SvgPicture.asset("images/vc_logo_landscape.svg")),
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
            backgroundColor: CustomColors.GOLD_HINT,
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

  Future<Group> downloadAibtBasicConfigurationFiles(var context, String subUrl) async {
    String aibtSubUrl = subUrl + StringConstants.AIBT_URL;
    // AIBT School Configurations
    final aceResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.ACE_FILE_NAME));
    final bespokeResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.BESPOKE_FILE_NAME));
    final bransonResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.BRANSON_FILE_NAME));
    final dianaResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.DIANA_FILE_NAME));
    final edisonResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.EDISON_FILE_NAME));
    final sheldonResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.SHELDON_FILE_NAME));

    String aibtPromotionSubUrl = subUrl + StringConstants.AIBT_URL + StringConstants.PROMOTIONS_URL;
    // AIBT School Promotion Configurations
    final acePromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.ACE_FILE_NAME));
    final bespokePromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.BESPOKE_FILE_NAME));
    final bransonPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.BRANSON_FILE_NAME));
    final dianaPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.DIANA_FILE_NAME));
    final edisonPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.EDISON_FILE_NAME));
    final sheldonPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.SHELDON_FILE_NAME));

    if (aceResponse.statusCode != 200 &&
        bespokeResponse.statusCode != 200 &&
        bransonResponse.statusCode != 200 &&
        dianaResponse.statusCode != 200 &&
        edisonResponse.statusCode != 200 &&
        sheldonResponse.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
      Navigator.of(context).pop();
    } else {
      List<School> aibtSchools = <School>[];

      School? ace = await mergePromotionToBasic(aceResponse, acePromotionResponse, StringConstants.ACE_SCHOOL_NAME);
      School? bespoke =
          await mergePromotionToBasic(bespokeResponse, bespokePromotionResponse, StringConstants.BESPOKE_SCHOOL_NAME);
      School? branson =
          await mergePromotionToBasic(bransonResponse, bransonPromotionResponse, StringConstants.BRANSON_SCHOOL_NAME);
      School? diana =
          await mergePromotionToBasic(dianaResponse, dianaPromotionResponse, StringConstants.DIANA_SCHOOL_NAME);
      School? edison =
          await mergePromotionToBasic(edisonResponse, edisonPromotionResponse, StringConstants.EDISON_SCHOOL_NAME);
      School? sheldon =
          await mergePromotionToBasic(sheldonResponse, sheldonPromotionResponse, StringConstants.SHELDON_SCHOOL_NAME);

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
      aibtGroup.schools = aibtSchools;
      aibtGroup.name = StringConstants.AIBT_GROUP_NAME;
    }
    return aibtGroup;
  }

  Future<Group> downloadReachBasicConfigurationFiles(var context, String subUrl) async {
    // REACH School Configurations
    String reachSubUrl = subUrl + StringConstants.REACH_URL;
    final reachResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_FILE_NAME));

    // REACH School Promotion Configurations
    String reachPromotionSubUrl = subUrl + StringConstants.REACH_URL + StringConstants.PROMOTIONS_URL;
    final reachPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + reachPromotionSubUrl + StringConstants.REACH_FILE_NAME));

    if (reachResponse.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
      Navigator.of(context).pop();
    } else {
      List<School> reachSchools = <School>[];
      School? reach =
          await mergePromotionToBasic(reachResponse, reachPromotionResponse, StringConstants.REACH_SCHOOL_NAME);

      if (reach != null) {
        reachSchools.add(reach);
      }

      reachGroup.schools = reachSchools;
      reachGroup.name = StringConstants.REACH_GROUP_NAME;
    }
    return reachGroup;
  }

  Future<void> downloadBrochureConfigurationFiles(String subUrl) async {
    // AIBT Brochure Configuration
    final aibtBrochureResponse =
        await http.get(Uri.parse(StringConstants.BROCHURE_BASE_URL + subUrl + StringConstants.AIBT_BROCHURE_FILE_NAME));

    // REACH Brochure Configuration
    final reachBrochureResponse = await http
        .get(Uri.parse(StringConstants.BROCHURE_BASE_URL + subUrl + StringConstants.REACH_BROCHURE_FILE_NAME));

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
    await downloadAibtBasicConfigurationFiles(context, subUrl);
    await downloadReachBasicConfigurationFiles(context, subUrl);
    await downloadBrochureConfigurationFiles(subUrl);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<School?> mergePromotionToBasic(var basicResponse, var promotionResponse, String schoolName) async {
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

  List<Course> prepareCourses(Group aibtGroup, Group reachGroup) {
    List<School> aibtSchools = aibtGroup.schools;
    List<School> reachSchools = reachGroup.schools;

    List<Course> totalCourses = [];
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

    totalCourses.addAll(aibtCourses);
    totalCourses.addAll(reachCourses);
    return totalCourses;
  }
}
