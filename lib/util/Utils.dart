import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_html/html.dart' as html;
import 'package:viskeeconsultancy/models/SchoolNameEnum.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

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

  static getGroupPrimaryColor(String? groupName) {
      if (groupName == StringConstants.AIBT_GROUP_NAME) {
        return CustomColors.AIBT_PRIMARY_COLOR;
      }
      if (groupName == StringConstants.REACH_GROUP_NAME) {
        return CustomColors.REACH_PRIMARY_COLOR;
      }
      return CustomColors.GOLD;
  }

  static getGroupSecondaryColor(String? groupName) {
    if (groupName == StringConstants.AIBT_GROUP_NAME) {
      return CustomColors.AIBT_SECONDARY_COLOR;
    }
    if (groupName == StringConstants.REACH_GROUP_NAME) {
      return CustomColors.REACH_SECONDARY_COLOR;
    }
    return CustomColors.GOLD_HINT;
  }

  static isRunningOnMobileBrowser() {
    final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
    // smartphone
    if( userAgent.contains("iphone"))  return true;
    if( userAgent.contains("android"))  return true;

    // tablet
    if( userAgent.contains("ipad")) return true;
    if( html.window.navigator.platform!.toLowerCase().contains("macintel") && html.window.navigator.maxTouchPoints! > 0 ) return true;

    return false;
  }
}
