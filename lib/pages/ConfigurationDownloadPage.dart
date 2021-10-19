import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viskeeconsultancy/models/Brochure.dart';
import 'package:viskeeconsultancy/models/Brochures.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

class ConfigurationDownloadPage extends StatelessWidget {
  late SubFolderEnum subfolder;
  ConfigurationDownloadPage(SubFolderEnum subFolderEnum) {
    this.subfolder = subFolderEnum;
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
          child: Align(alignment: Alignment.center, child: Image.asset("images/vc_logo_landscape.png")),
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

  Future<void> downloadBasicConfigurationFiles(var context, String subUrl) async {
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
    // REACH School Configurations
    String reachSubUrl = subUrl + StringConstants.REACH_URL;
    final reachResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_FILE_NAME));

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
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
    } else {
      List<School> aibtSchools = <School>[];
      List<School> reachSchools = <School>[];

      if (aceResponse.statusCode == 200) {
        final aceData = await json.decode(aceResponse.body);
        School ace = School.fromJson(aceData);
        ace.name = "ACE AVIATION AEROSPACE ACADEMY";
        aibtSchools.add(ace);
      }

      if (bespokeResponse.statusCode == 200) {
        final bespokeData = await json.decode(bespokeResponse.body);
        School bespoke = School.fromJson(bespokeData);
        bespoke.name = "BESPOKE GRAMMAR SCHOOL OF ENGLISH";
        aibtSchools.add(bespoke);
      }
      if (bransonResponse.statusCode == 200) {
        final bransonData = await json.decode(bransonResponse.body);
        School branson = School.fromJson(bransonData);
        branson.name = "BRANSON SCHOOL OF BUSINESS AND TECHNOLOGY";
        aibtSchools.add(branson);
      }

      if (dianaResponse.statusCode == 200) {
        final dianaData = await json.decode(dianaResponse.body);
        School diana = School.fromJson(dianaData);
        diana.name = "DIANA SCHOOL OF COMMUNITY SERVICES";
        aibtSchools.add(diana);
      }

      if (edisonResponse.statusCode == 200) {
        final edisonData = await json.decode(edisonResponse.body);
        School edison = School.fromJson(edisonData);
        edison.name = "EDISON SCHOOL OF TECH SCIENCES";
        aibtSchools.add(edison);
      }

      if (sheldonResponse.statusCode == 200) {
        final sheldonData = await json.decode(sheldonResponse.body);
        School sheldon = School.fromJson(sheldonData);
        sheldon.name = "SHELDON SCHOOL OF HOSPITALITY";
        aibtSchools.add(sheldon);
      }

      if (reachResponse.statusCode == 200) {
        final reachData = await json.decode(reachResponse.body);
        School reach = School.fromJson(reachData);
        reach.name = "REACH COMMUNITY COLLEGE";
        reachSchools.add(reach);
      }

      aibtGroup.schools = aibtSchools;
      aibtGroup.name = "AIBT";

      reachGroup.schools = reachSchools;
      reachGroup.name = "REACH";
    }
  }

  Future<void> downloadPromotionConfigurationFiles(String subUrl) async {
    String aibtSubUrl = subUrl + StringConstants.AIBT_URL + StringConstants.PROMOTIONS_URL;
    // AIBT School Promotion Configurations
    final acePromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.ACE_FILE_NAME));
    final bespokePromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.BESPOKE_FILE_NAME));
    final bransonPromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.BRANSON_FILE_NAME));
    final dianaPromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.DIANA_FILE_NAME));
    final edisonPromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.EDISON_FILE_NAME));
    final sheldonPromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.SHELDON_FILE_NAME));
    // REACH School Promotion Configurations
    String reachSubUrl = subUrl + StringConstants.REACH_URL + StringConstants.PROMOTIONS_URL;
    final reachPromotionResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_FILE_NAME));

    List<School> aibtSchools = <School>[];
    List<School> reachSchools = <School>[];

    if (acePromotionResponse.statusCode == 200) {
      final aceData = await json.decode(acePromotionResponse.body);
      School ace = School.fromJson(aceData);
      ace.name = "ACE AVIATION AEROSPACE ACADEMY";
      aibtSchools.add(ace);
    }

    if (bespokePromotionResponse.statusCode == 200) {
      final bespokeData = await json.decode(bespokePromotionResponse.body);
      School bespoke = School.fromJson(bespokeData);
      bespoke.name = "BESPOKE GRAMMAR SCHOOL OF ENGLISH";
      aibtSchools.add(bespoke);
    }
    if (bransonPromotionResponse.statusCode == 200) {
      final bransonData = await json.decode(bransonPromotionResponse.body);
      School branson = School.fromJson(bransonData);
      branson.name = "BRANSON SCHOOL OF BUSINESS AND TECHNOLOGY";
      aibtSchools.add(branson);
    }

    if (dianaPromotionResponse.statusCode == 200) {
      final dianaData = await json.decode(dianaPromotionResponse.body);
      School diana = School.fromJson(dianaData);
      diana.name = "DIANA SCHOOL OF COMMUNITY SERVICES";
      aibtSchools.add(diana);
    }

    if (edisonPromotionResponse.statusCode == 200) {
      final edisonData = await json.decode(edisonPromotionResponse.body);
      School edison = School.fromJson(edisonData);
      edison.name = "EDISON SCHOOL OF TECH SCIENCES";
      aibtSchools.add(edison);
    }

    if (sheldonPromotionResponse.statusCode == 200) {
      final sheldonData = await json.decode(sheldonPromotionResponse.body);
      School sheldon = School.fromJson(sheldonData);
      sheldon.name = "SHELDON SCHOOL OF HOSPITALITY";
      aibtSchools.add(sheldon);
    }

    if (reachPromotionResponse.statusCode == 200) {
      final reachData = await json.decode(reachPromotionResponse.body);
      School reach = School.fromJson(reachData);
      reach.name = "REACH COMMUNITY COLLEGE";
      reachSchools.add(reach);
    }

    aibtPromotionGroup.schools = aibtSchools;
    aibtPromotionGroup.name = "AIBT";

    reachPromotionGroup.schools = reachSchools;
    reachPromotionGroup.name = "REACH";
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

  Future<void> readJson(var context) async {
    String subUrl = buildSubUrl(subfolder);
    downloadBasicConfigurationFiles(context, subUrl);
    downloadPromotionConfigurationFiles(subUrl);
    downloadBrochureConfigurationFiles(subUrl);
  }

  void mergePromotions() {
    List<School> aibtGroup.schools;
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
}
