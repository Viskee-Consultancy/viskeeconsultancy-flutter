
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viskeeconsultancy/models/SchoolNameEnum.dart';
import 'package:viskeeconsultancy/pages/PDFViewer.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

class Utils {

  static getGroupLogoLandscape(String? groupName) {
    if (groupName == StringConstants.AIBT_GROUP_NAME) {
      return Image.asset("images/aibt_landscape.png");
    } else if (groupName == StringConstants.REACH_GROUP_NAME) {
      return Image.asset("images/reach_landscape.png");
    } else {
      return Image.asset("images/avta_landscape.png");
    }
  }

  static getGroupLogoSVG(String? groupName) {
    if (groupName == StringConstants.AIBT_GROUP_NAME) {
      return SvgPicture.asset("images/aibt.svg");
    } else if (groupName == StringConstants.REACH_GROUP_NAME) {
      return SvgPicture.asset("images/reach.svg");
    } else {
      return SvgPicture.asset("images/avta.svg");
    }
  }

  static getSchoolTitle(String? schoolName) {
    var schoolNameEnum = SchoolNameEnumUtils.fromValue(schoolName!);
    switch (schoolNameEnum) {
      case SchoolNameEnum.ACE:
        return "AVIATION";
      case SchoolNameEnum.BESPOKE:
        return "ENGLISH";
      case SchoolNameEnum.BRANSON:
        return "BUSINESS AND TECHNOLOGY";
      case SchoolNameEnum.DIANA:
        return "COMMUNITY SERVICES";
      case SchoolNameEnum.EDISON:
        return "TECH SCIENCES";
      case SchoolNameEnum.SHELDON:
        return "HOSPITALITY";
      case SchoolNameEnum.BUSINESS_AND_TECHNOLOGY_FACULTY:
        return "BUSINESS";
      case SchoolNameEnum.EARLY_CHILDHOOD_FACULTY:
        return "COMMUNITY SERVICES";
      case SchoolNameEnum.ENGLISH_FACULTY:
        return "ENGLISH";
      case SchoolNameEnum.HORTICULTURE_FACULTY:
        return "HORTICULTURE";
      case SchoolNameEnum.HOSPITALITY_FACULTY:
        return "HOSPITALITY";
      case SchoolNameEnum.TECH_SCIENCES_FACULTY:
        return "TECH SCIENCES";
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
    if (groupName == StringConstants.AVTA_GROUP_NAME) {
      return CustomColors.AVTA_PRIMARY_COLOR;
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
    if (groupName == StringConstants.AVTA_GROUP_NAME) {
      return CustomColors.AVTA_SECONDARY_COLOR;
    }
    return CustomColors.GOLD_HINT;
  }

  static getGroupVideoLink(String? groupName) {
    if (groupName == StringConstants.AIBT_GROUP_NAME) {
      return StringConstants.AIBT_VIDEOS_URL;
    }
    if (groupName == StringConstants.REACH_GROUP_NAME) {
      return StringConstants.REACH_VIDEOS_URL;
    }
    if (groupName == StringConstants.AVTA_GROUP_NAME) {
      return StringConstants.AVTA_VIDEOS_URL;
    }
    return StringConstants.AIBT_VIDEOS_URL;
  }

  static isRunningOnMobileBrowser() {
    // final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
    // // smartphone
    // if( userAgent.contains("iphone"))  return true;
    // if( userAgent.contains("android"))  return true;
    //
    // // tablet
    // if( userAgent.contains("ipad")) return true;
    // if( html.window.navigator.platform!.toLowerCase().contains("macintel") && html.window.navigator.maxTouchPoints! > 0 ) return true;

    return true;
  }

  static onBackPressed(BuildContext context, bool isRemovePath) {
    if (isRemovePath) {
      NavigationPath.PATH.removeLast();
    }
    Navigator.of(context).pop();
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  static openBrochure(String name, String url, BuildContext context) async {
    if (await canLaunch(url)) {
      if (!kIsWeb) {
        Navigator.push(context, PageTransition(child: PDFViewer(name, url), type: PageTransitionType.rightToLeft));
      } else {
        await launch(url, forceWebView: false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.GOLD,
        duration: Duration(milliseconds: 2000),
        content: Text('The Brochure selected is currently not available, please try later.'),
      ));
    }
  }

  static isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
