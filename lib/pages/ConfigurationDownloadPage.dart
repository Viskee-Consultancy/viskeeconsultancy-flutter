import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Brochures.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/MainPage.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

class ConfigurationDownloadPage extends StatefulWidget {
  late final SubFolderEnum _subfolder;

  ConfigurationDownloadPage(SubFolderEnum subFolderEnum) {
    this._subfolder = subFolderEnum;
  }

  @override
  ConfigurationDownloadAsync createState() => ConfigurationDownloadAsync(_subfolder);
}

class ConfigurationDownloadAsync extends State<ConfigurationDownloadPage> {
  late SubFolderEnum _subfolder;

  ConfigurationDownloadAsync(SubFolderEnum subFolderEnum) {
    this._subfolder = subFolderEnum;
  }

  Group _aibtGroup = new Group();
  Group _reachGroup = new Group();
  Group _avtaGroup = new Group();
  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    downloadConfigurations(context).then((value) => {
          _courses.addAll(prepareCourses(_aibtGroup, GroupEnum.AIBT)),
          _courses.addAll(prepareCourses(_reachGroup, GroupEnum.REACH)),
          _courses.addAll(prepareCourses(_avtaGroup, GroupEnum.AVTA)),
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: MainPage(_aibtGroup, _reachGroup, _avtaGroup, _courses), type: PageTransitionType.rightToLeft))
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
      case SubFolderEnum.REGION_1:
        return StringConstants.OFFSHORE_URL + StringConstants.REGION_1_URL;
      case SubFolderEnum.REGION_2:
        return StringConstants.OFFSHORE_URL + StringConstants.REGION_2_URL;
      case SubFolderEnum.REGION_3:
        return StringConstants.OFFSHORE_URL + StringConstants.REGION_3_URL;
      default:
        return "";
    }
  }

  Future<Group> downloadGroupConfigurationAndMapping(var context, String subUrl, List<String> fileNames, List<String> schoolNames, String groupName) async {
    Group group = new Group();
    // School Configurations
    List<Response> responseList = [];
    for (int i = 0; i < fileNames.length; i++) {
      responseList.add(await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + subUrl + fileNames[i])));
    }

    // Promotion Configurations
    String promotionSubUrl = subUrl + StringConstants.PROMOTIONS_URL;
    List<Response> promotionResponseList = [];
    for (int i = 0; i < fileNames.length; i++) {
      promotionResponseList.add(await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + promotionSubUrl + fileNames[i])));
    }

    if (responseList.any((element) => element.statusCode != 200)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
      Navigator.of(context).pop();
    } else {
      List<School> schools = <School>[];

      for (int i = 0; i < schoolNames.length; i++) {
        School? school = await mergePromotionToBasic(responseList[i], promotionResponseList[i], schoolNames[i]);
        if (school != null && school.courses.isNotEmpty) {
          print(school.name);
          schools.add(school);
        }
      }
      group.schools = schools;
      group.name = groupName;
    }
    return group;
  }

  Future<void> downloadBrochureConfigurationAndMapping(String subUrl, Group group) async {
    final brochureResponse =
        await http.get(Uri.parse(StringConstants.BROCHURE_BASE_URL + subUrl));

    if (brochureResponse.statusCode == 200) {
      final brochureData = await json.decode(brochureResponse.body);
      Brochures brochures = Brochures.fromJson(brochureData);
      group.brochures = brochures.brochures;
    }
  }

  Future<void> downloadConfigurations(var context) async {
    String subUrl = buildSubUrl(_subfolder);
    _aibtGroup = await downloadGroupConfigurationAndMapping(context, subUrl + StringConstants.AIBT_URL, StringConstants.AIBT_FILE_NAMES, StringConstants.AIBT_SCHOOL_NAMES, StringConstants.AIBT_GROUP_NAME);
    _reachGroup = await downloadGroupConfigurationAndMapping(context, subUrl + StringConstants.REACH_URL, StringConstants.REACH_FILE_NAMES, StringConstants.REACH_SCHOOL_NAMES, StringConstants.REACH_GROUP_NAME);
    _avtaGroup = await downloadGroupConfigurationAndMapping(context, subUrl + StringConstants.AVTA_URL, StringConstants.AVTA_FILE_NAMES, StringConstants.AVTA_SCHOOL_NAMES, StringConstants.AVTA_GROUP_NAME);
    await downloadBrochureConfigurationAndMapping(subUrl+StringConstants.AIBT_BROCHURE_FILE_NAME, _aibtGroup);
    await downloadBrochureConfigurationAndMapping(subUrl+StringConstants.REACH_BROCHURE_FILE_NAME, _reachGroup);
    await downloadBrochureConfigurationAndMapping(subUrl+StringConstants.AVTA_BROCHURE_FILE_NAME, _avtaGroup);
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
      promotionCourses.forEach((element) {
        element.isOnPromotion = true;
      });
      basicSchool.courses.addAll(promotionCourses);
    }
    basicSchool.courses.sort((o1, o2) => o1.name!.compareTo(o2.name!));
    buildDepartmentList(basicSchool);
    return basicSchool;
  }

  List<Course> prepareCourses(Group group, GroupEnum groupEnum) {
    List<School> schools = group.schools;
    List<Course> courses = [];
    for (var school in schools) {
      courses.addAll(school.courses);
    }
    courses.forEach((course) => course.group = groupEnum);
    return courses;
  }

  void buildDepartmentList(School school) {
    Map<String, List<Course>> m = new Map();
    for (var i = 0; i < school.courses.length; i++) {
      var course = school.courses[i];
      course.schoolName = school.name;
      String departmentName = course.department!.toUpperCase();
      if (m[departmentName] == null) {
        List<Course> courses = [course];
        m[departmentName] = courses;
      } else {
        m[departmentName]!.add(course);
      }
    }
    m.entries.forEach((entry) => {school.departments.add(new Department(entry.key, entry.value))});
  }
}
