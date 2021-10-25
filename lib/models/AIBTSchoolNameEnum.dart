import 'package:viskeeconsultancy/values/StringConstants.dart';

enum AIBTSchoolNameEnum {
  ACE,
  BESPOKE,
  BRANSON,
  DIANA,
  EDISON,
  SHELDON,
  REACH,
}

class AIBTSchoolNameEnumUtils {
  static const Map<String, AIBTSchoolNameEnum> AIBT_SCHOOL_NAME_MAP = const {
    StringConstants.ACE_SCHOOL_NAME: AIBTSchoolNameEnum.ACE,
    StringConstants.BESPOKE_SCHOOL_NAME: AIBTSchoolNameEnum.BESPOKE,
    StringConstants.BRANSON_SCHOOL_NAME: AIBTSchoolNameEnum.BRANSON,
    StringConstants.DIANA_SCHOOL_NAME: AIBTSchoolNameEnum.DIANA,
    StringConstants.EDISON_SCHOOL_NAME: AIBTSchoolNameEnum.EDISON,
    StringConstants.SHELDON_SCHOOL_NAME: AIBTSchoolNameEnum.SHELDON,
    StringConstants.REACH_SCHOOL_NAME: AIBTSchoolNameEnum.REACH
  };

  static AIBTSchoolNameEnum? fromValue(String value) {
    return AIBT_SCHOOL_NAME_MAP[value];
  }
}
