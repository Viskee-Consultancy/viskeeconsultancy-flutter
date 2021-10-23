import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viskeeconsultancy/models/AIBTSchoolNameEnum.dart';

class Utils {
  static getSchoolLogo(String? schoolName) {
    var aibtSchoolNameEnum = AIBTSchoolNameEnumUtils.fromValue(schoolName!);
    switch (aibtSchoolNameEnum) {
      case AIBTSchoolNameEnum.ACE:
        return Image.asset('images/ace_landscape.png');
      case AIBTSchoolNameEnum.BESPOKE:
        return SvgPicture.asset('images/bespoke.svg');
      case AIBTSchoolNameEnum.BRANSON:
        return SvgPicture.asset('images/branson.svg');
      case AIBTSchoolNameEnum.DIANA:
        return SvgPicture.asset('images/diana.svg');
      case AIBTSchoolNameEnum.EDISON:
        return SvgPicture.asset('images/edison.svg');
      case AIBTSchoolNameEnum.SHELDON:
        return SvgPicture.asset('images/sheldon.svg');
      case AIBTSchoolNameEnum.REACH:
        return SvgPicture.asset('images/reach.svg');
      default:
    }
  }
}
