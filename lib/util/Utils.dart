import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viskeeconsultancy/models/SchoolNameEnum.dart';

class Utils {
  static getSchoolLogo(String? schoolName) {
    var schoolNameEnum = SchoolNameEnumUtils.fromValue(schoolName!);
    switch (schoolNameEnum) {
      case SchoolNameEnum.ACE:
        return Image.asset('images/ace_landscape.png');
      case SchoolNameEnum.BESPOKE:
        return SvgPicture.asset('images/bespoke.svg');
      case SchoolNameEnum.BRANSON:
        return SvgPicture.asset('images/branson.svg');
      case SchoolNameEnum.DIANA:
        return SvgPicture.asset('images/diana.svg');
      case SchoolNameEnum.EDISON:
        return SvgPicture.asset('images/edison.svg');
      case SchoolNameEnum.SHELDON:
        return SvgPicture.asset('images/sheldon.svg');
      case SchoolNameEnum.BUSINESS_AND_TECHNOLOGY_FACULTY:
        return Image.asset('images/business_technology.png');
      case SchoolNameEnum.EARLY_CHILDHOOD_FACULTY:
        return Image.asset('images/early_childhood.png');
      case SchoolNameEnum.ENGLISH_FACULTY:
        return Image.asset('images/english.png');
      case SchoolNameEnum.HOSPITALITY_FACULTY:
        return Image.asset('images/hospitality.png');
      case SchoolNameEnum.TECH_SCIENCES_FACULTY:
        return Image.asset('images/tech_sciences.png');
      default:
    }
  }
}
