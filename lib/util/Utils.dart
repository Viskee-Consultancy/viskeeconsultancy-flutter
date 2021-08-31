import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/AIBTSchoolNameEnum.dart';

class Utils {
  static getSchoolLogoPortrait(String? schoolName) {
    var aibtSchoolNameEnum = AIBTSchoolNameEnumUtils.fromValue(schoolName!);
    switch (aibtSchoolNameEnum) {
      case AIBTSchoolNameEnum.ACE:
        return Image.asset('images/ace_landscape.png');
      case AIBTSchoolNameEnum.BESPOKE:
        return Image.asset('images/bespoke.png');
      case AIBTSchoolNameEnum.BRANSON:
        return Image.asset('images/branson.png');
      case AIBTSchoolNameEnum.DIANA:
        return Image.asset('images/diana.png');
      case AIBTSchoolNameEnum.EDISON:
        return Image.asset('images/edison.png');
      case AIBTSchoolNameEnum.SHELDON:
        return Image.asset('images/sheldon.png');
      case AIBTSchoolNameEnum.REACH:
        return Image.asset('images/reach.png');
      default:
    }
  }

  static getSchoolLogoLandscape(String? schoolName) {
    var aibtSchoolNameEnum = AIBTSchoolNameEnumUtils.fromValue(schoolName!);
    switch (aibtSchoolNameEnum) {
      case AIBTSchoolNameEnum.ACE:
        return Image.asset('images/ace_landscape.png');
      case AIBTSchoolNameEnum.BESPOKE:
        return Image.asset('images/bespoke.png');
      case AIBTSchoolNameEnum.BRANSON:
        return Image.asset('images/branson.png');
      case AIBTSchoolNameEnum.DIANA:
        return Image.asset('images/diana.png');
      case AIBTSchoolNameEnum.EDISON:
        return Image.asset('images/edison.png');
      case AIBTSchoolNameEnum.SHELDON:
        return Image.asset('images/sheldon.png');
      case AIBTSchoolNameEnum.REACH:
        return Image.asset('images/reach.png');
      default:
    }
  }
}
