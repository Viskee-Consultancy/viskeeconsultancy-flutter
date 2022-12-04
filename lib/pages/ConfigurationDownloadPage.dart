import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
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
          _courses = prepareCourses(_aibtGroup, _reachGroup, _avtaGroup),
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

  Future<Group> downloadAibtBasicConfigurationFiles(var context, String subUrl) async {
    String aibtSubUrl = subUrl + StringConstants.AIBT_URL;
    // AIBT School Configurations
    final aceResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.AIBT_ACE_FILE_NAME));
    final bespokeResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.AIBT_BESPOKE_FILE_NAME));
    final bransonResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.AIBT_BRANSON_FILE_NAME));
    final dianaResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.AIBT_DIANA_FILE_NAME));
    final edisonResponse =
        await http.get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.AIBT_EDISON_FILE_NAME));
    final sheldonResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtSubUrl + StringConstants.AIBT_SHELDON_FILE_NAME));

    String aibtPromotionSubUrl = subUrl + StringConstants.AIBT_URL + StringConstants.PROMOTIONS_URL;
    // AIBT School Promotion Configurations
    final acePromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.AIBT_ACE_FILE_NAME));
    final bespokePromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.AIBT_BESPOKE_FILE_NAME));
    final bransonPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.AIBT_BRANSON_FILE_NAME));
    final dianaPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.AIBT_DIANA_FILE_NAME));
    final edisonPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.AIBT_EDISON_FILE_NAME));
    final sheldonPromotionResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + aibtPromotionSubUrl + StringConstants.AIBT_SHELDON_FILE_NAME));

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

      School? ace =
          await mergePromotionToBasic(aceResponse, acePromotionResponse, StringConstants.AIBT_ACE_SCHOOL_NAME);
      School? bespoke = await mergePromotionToBasic(
          bespokeResponse, bespokePromotionResponse, StringConstants.AIBT_BESPOKE_SCHOOL_NAME);
      School? branson = await mergePromotionToBasic(
          bransonResponse, bransonPromotionResponse, StringConstants.AIBT_BRANSON_SCHOOL_NAME);
      School? diana =
          await mergePromotionToBasic(dianaResponse, dianaPromotionResponse, StringConstants.AIBT_DIANA_SCHOOL_NAME);
      School? edison =
          await mergePromotionToBasic(edisonResponse, edisonPromotionResponse, StringConstants.AIBT_EDISON_SCHOOL_NAME);
      School? sheldon = await mergePromotionToBasic(
          sheldonResponse, sheldonPromotionResponse, StringConstants.AIBT_SHELDON_SCHOOL_NAME);

      if (ace != null && ace.courses.isNotEmpty) {
        aibtSchools.add(ace);
      }
      if (bespoke != null && bespoke.courses.isNotEmpty) {
        aibtSchools.add(bespoke);
      }
      if (branson != null && branson.courses.isNotEmpty) {
        aibtSchools.add(branson);
      }
      if (diana != null && diana.courses.isNotEmpty) {
        aibtSchools.add(diana);
      }
      if (edison != null && edison.courses.isNotEmpty) {
        aibtSchools.add(edison);
      }
      if (sheldon != null && sheldon.courses.isNotEmpty) {
        aibtSchools.add(sheldon);
      }
      _aibtGroup.schools = aibtSchools;
      _aibtGroup.name = StringConstants.AIBT_GROUP_NAME;
    }
    return _aibtGroup;
  }

  Future<Group> downloadReachBasicConfigurationFiles(var context, String subUrl) async {
    String reachSubUrl = subUrl + StringConstants.REACH_URL;
    // REACH School Configurations
    final businessTechnologyResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_BUSINESS_AND_TECHNOLOGY_FILE_NAME));
    final earlyChildhoodResponse = await http.get(
        Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_EARLY_CHILDHOOD_FILE_NAME));
    final englishResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_ENGLISH_FILE_NAME));
    final hospitalityResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_HOSPITALITY_FILE_NAME));
    final techScienceResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + reachSubUrl + StringConstants.REACH_TECH_SCIENCES_FILE_NAME));

    String reachPromotionSubUrl = subUrl + StringConstants.REACH_URL + StringConstants.PROMOTIONS_URL;
    // REACH School Promotion Configurations
    final businessTechnologyPromotionResponse = await http.get(Uri.parse(StringConstants.COURSE_BASE_URL +
        reachPromotionSubUrl +
        StringConstants.REACH_BUSINESS_AND_TECHNOLOGY_FILE_NAME));
    final earlyChildhoodPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + reachPromotionSubUrl + StringConstants.REACH_EARLY_CHILDHOOD_FILE_NAME));
    final englishPromotionResponse = await http.get(
        Uri.parse(StringConstants.COURSE_BASE_URL + reachPromotionSubUrl + StringConstants.REACH_ENGLISH_FILE_NAME));
    final hospitalityPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + reachPromotionSubUrl + StringConstants.REACH_HOSPITALITY_FILE_NAME));
    final techSciencePromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + reachPromotionSubUrl + StringConstants.REACH_TECH_SCIENCES_FILE_NAME));

    if (businessTechnologyResponse.statusCode != 200 &&
        earlyChildhoodResponse.statusCode != 200 &&
        englishResponse.statusCode != 200 &&
        hospitalityResponse.statusCode != 200 &&
        techScienceResponse.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
      Navigator.of(context).pop();
    } else {
      List<School> reachSchools = <School>[];

      School? businessTechnologyFaculty = await mergePromotionToBasic(businessTechnologyResponse,
          businessTechnologyPromotionResponse, StringConstants.REACH_BUSINESS_AND_TECHNOLOGY_SCHOOL_NAME);
      School? earlyChildhoodFaculty = await mergePromotionToBasic(
          earlyChildhoodResponse, earlyChildhoodPromotionResponse, StringConstants.REACH_EARLY_CHILDHOOD_SCHOOL_NAME);
      School? englishFaculty = await mergePromotionToBasic(
          englishResponse, englishPromotionResponse, StringConstants.REACH_ENGLISH_SCHOOL_NAME);
      School? hospitalityFaculty = await mergePromotionToBasic(
          hospitalityResponse, hospitalityPromotionResponse, StringConstants.REACH_HOSPITALITY_SCHOOL_NAME);
      School? techScienceFaculty = await mergePromotionToBasic(
          techScienceResponse, techSciencePromotionResponse, StringConstants.REACH_TECH_SCIENCES_SCHOOL_NAME);

      if (businessTechnologyFaculty != null && businessTechnologyFaculty.courses.isNotEmpty) {
        reachSchools.add(businessTechnologyFaculty);
      }
      if (earlyChildhoodFaculty != null && earlyChildhoodFaculty.courses.isNotEmpty) {
        reachSchools.add(earlyChildhoodFaculty);
      }
      if (englishFaculty != null && englishFaculty.courses.isNotEmpty) {
        reachSchools.add(englishFaculty);
      }
      if (hospitalityFaculty != null && hospitalityFaculty.courses.isNotEmpty) {
        reachSchools.add(hospitalityFaculty);
      }
      if (techScienceFaculty != null && techScienceFaculty.courses.isNotEmpty) {
        reachSchools.add(techScienceFaculty);
      }

      _reachGroup.schools = reachSchools;
      _reachGroup.name = StringConstants.REACH_GROUP_NAME;
    }
    return _reachGroup;
  }

  Future<Group> downloadAvtaBasicConfigurationFiles(var context, String subUrl) async {
    String avtaSubUrl = subUrl + StringConstants.AVTA_URL;
    // AVTA School Configurations
    final businessTechnologyResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + avtaSubUrl + StringConstants.AVTA_BUSINESS_AND_TECHNOLOGY_FILE_NAME));
    final earlyChildhoodResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + avtaSubUrl + StringConstants.AVTA_EARLY_CHILDHOOD_FILE_NAME));
    final englishResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + avtaSubUrl + StringConstants.AVTA_ENGLISH_FILE_NAME));
    final horticultureResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + avtaSubUrl + StringConstants.AVTA_HORTICULTURE_FILE_NAME));
    final hospitalityResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + avtaSubUrl + StringConstants.AVTA_HOSPITALITY_FILE_NAME));
    final techScienceResponse = await http
        .get(Uri.parse(StringConstants.COURSE_BASE_URL + avtaSubUrl + StringConstants.AVTA_TECH_SCIENCES_FILE_NAME));

    String avtaPromotionSubUrl = subUrl + StringConstants.AVTA_URL + StringConstants.PROMOTIONS_URL;
    // AVTA School Promotion Configurations
    final businessTechnologyPromotionResponse = await http.get(Uri.parse(StringConstants.COURSE_BASE_URL +
        avtaPromotionSubUrl +
        StringConstants.AVTA_BUSINESS_AND_TECHNOLOGY_FILE_NAME));
    final earlyChildhoodPromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + avtaPromotionSubUrl + StringConstants.AVTA_EARLY_CHILDHOOD_FILE_NAME));
    final englishPromotionResponse = await http.get(
        Uri.parse(StringConstants.COURSE_BASE_URL + avtaPromotionSubUrl + StringConstants.AVTA_ENGLISH_FILE_NAME));
    final horticulturePromotionResponse = await http.get(
        Uri.parse(StringConstants.COURSE_BASE_URL + avtaPromotionSubUrl + StringConstants.AVTA_HORTICULTURE_FILE_NAME));
    final hospitalityPromotionResponse = await http.get(
        Uri.parse(StringConstants.COURSE_BASE_URL + avtaPromotionSubUrl + StringConstants.AVTA_HOSPITALITY_FILE_NAME));
    final techSciencePromotionResponse = await http.get(Uri.parse(
        StringConstants.COURSE_BASE_URL + avtaPromotionSubUrl + StringConstants.AVTA_TECH_SCIENCES_FILE_NAME));

    if (businessTechnologyResponse.statusCode != 200 &&
        earlyChildhoodResponse.statusCode != 200 &&
        englishResponse.statusCode != 200 &&
        horticultureResponse.statusCode != 200 &&
        hospitalityResponse.statusCode != 200 &&
        techScienceResponse.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('Cannot load configuration file successfully, please try later.'),
      ));
      Navigator.of(context).pop();
    } else {
      List<School> avtaSchools = <School>[];

      print(businessTechnologyResponse);
      School? businessTechnologyFaculty = await mergePromotionToBasic(businessTechnologyResponse,
          businessTechnologyPromotionResponse, StringConstants.AVTA_BUSINESS_AND_TECHNOLOGY_SCHOOL_NAME);
      School? earlyChildhoodFaculty = await mergePromotionToBasic(
          earlyChildhoodResponse, earlyChildhoodPromotionResponse, StringConstants.AVTA_EARLY_CHILDHOOD_SCHOOL_NAME);
      School? englishFaculty = await mergePromotionToBasic(
          englishResponse, englishPromotionResponse, StringConstants.AVTA_ENGLISH_SCHOOL_NAME);
      School? horticultureFaculty = await mergePromotionToBasic(
          hospitalityResponse, horticulturePromotionResponse, StringConstants.AVTA_HORTICULTURE_SCHOOL_NAME);
      School? hospitalityFaculty = await mergePromotionToBasic(
          hospitalityResponse, hospitalityPromotionResponse, StringConstants.AVTA_HOSPITALITY_SCHOOL_NAME);
      School? techScienceFaculty = await mergePromotionToBasic(
          techScienceResponse, techSciencePromotionResponse, StringConstants.AVTA_TECH_SCIENCES_SCHOOL_NAME);

      if (businessTechnologyFaculty != null && businessTechnologyFaculty.courses.isNotEmpty) {
        avtaSchools.add(businessTechnologyFaculty);
      }
      if (earlyChildhoodFaculty != null && earlyChildhoodFaculty.courses.isNotEmpty) {
        avtaSchools.add(earlyChildhoodFaculty);
      }
      if (englishFaculty != null && englishFaculty.courses.isNotEmpty) {
        avtaSchools.add(englishFaculty);
      }
      if (horticultureFaculty != null && horticultureFaculty.courses.isNotEmpty) {
        avtaSchools.add(horticultureFaculty);
      }
      if (hospitalityFaculty != null && hospitalityFaculty.courses.isNotEmpty) {
        avtaSchools.add(hospitalityFaculty);
      }
      if (techScienceFaculty != null && techScienceFaculty.courses.isNotEmpty) {
        avtaSchools.add(techScienceFaculty);
      }

      _avtaGroup.schools = avtaSchools;
      _avtaGroup.name = StringConstants.AVTA_GROUP_NAME;
    }
    return _avtaGroup;
  }

  Future<void> downloadBrochureConfigurationFiles(String subUrl) async {
    // AIBT Brochure Configuration
    final aibtBrochureResponse =
        await http.get(Uri.parse(StringConstants.BROCHURE_BASE_URL + subUrl + StringConstants.AIBT_BROCHURE_FILE_NAME));

    // REACH Brochure Configuration
    final reachBrochureResponse = await http
        .get(Uri.parse(StringConstants.BROCHURE_BASE_URL + subUrl + StringConstants.REACH_BROCHURE_FILE_NAME));

    // AVTA Brochure Configuration
    final avtaBrochureResponse =
        await http.get(Uri.parse(StringConstants.BROCHURE_BASE_URL + subUrl + StringConstants.AVTA_BROCHURE_FILE_NAME));

    if (aibtBrochureResponse.statusCode == 200) {
      final aibtBrochureData = await json.decode(aibtBrochureResponse.body);
      Brochures aibtBrochures = Brochures.fromJson(aibtBrochureData);
      _aibtGroup.brochures = aibtBrochures.brochures;
    }

    if (reachBrochureResponse.statusCode == 200) {
      final reachBrochureData = await json.decode(reachBrochureResponse.body);
      Brochures reachBrochures = Brochures.fromJson(reachBrochureData);
      _reachGroup.brochures = reachBrochures.brochures;
    }

    if (avtaBrochureResponse.statusCode == 200) {
      final avtaBrochureData = await json.decode(avtaBrochureResponse.body);
      Brochures avtaBrochures = Brochures.fromJson(avtaBrochureData);
      _avtaGroup.brochures = avtaBrochures.brochures;
    }
  }

  Future<void> downloadConfigurations(var context) async {
    String subUrl = buildSubUrl(_subfolder);
    await downloadAibtBasicConfigurationFiles(context, subUrl);
    await downloadReachBasicConfigurationFiles(context, subUrl);
    await downloadAvtaBasicConfigurationFiles(context, subUrl);
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
      promotionCourses.forEach((element) {
        element.isOnPromotion = true;
      });
      basicSchool.courses.addAll(promotionCourses);
    }
    buildDepartmentList(basicSchool);
    return basicSchool;
  }

  List<Course> prepareCourses(Group aibtGroup, Group reachGroup, Group avtaGroup) {
    List<School> aibtSchools = aibtGroup.schools;
    List<School> reachSchools = reachGroup.schools;
    List<School> avtaSchools = avtaGroup.schools;

    List<Course> totalCourses = [];

    // Setup aibt courses
    List<Course> aibtCourses = [];
    for (var school in aibtSchools) {
      aibtCourses.addAll(school.courses);
    }
    aibtCourses.forEach((course) => course.group = GroupEnum.AIBT);

    // Setup reach courses
    List<Course> reachCourses = [];
    for (var school in reachSchools) {
      reachCourses.addAll(school.courses);
    }
    reachCourses.forEach((course) => course.group = GroupEnum.REACH);

    // Setup avta courses
    List<Course> avtaCourses = [];
    for (var school in avtaSchools) {
      avtaCourses.addAll(school.courses);
    }
    avtaCourses.forEach((course) => course.group = GroupEnum.AVTA);

    totalCourses.addAll(aibtCourses);
    totalCourses.addAll(reachCourses);
    totalCourses.addAll(avtaCourses);
    return totalCourses;
  }

  void buildDepartmentList(School school) {
    Map<String, List<Course>> m = new Map();
    for (var i = 0; i < school.courses.length; i++) {
      var course = school.courses[i];
      course.schoolName = school.name;
      if (m[course.department] == null) {
        List<Course> courses = [course];
        m[course.department!] = courses;
      } else {
        m[course.department!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {school.departments.add(new Department(entry.key, entry.value))});
  }
}
