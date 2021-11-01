import 'package:viskeeconsultancy/values/StringConstants.dart';

enum SchoolNameEnum {
  ACE,
  BESPOKE,
  BRANSON,
  DIANA,
  EDISON,
  SHELDON,
  BUSINESS_AND_TECHNOLOGY_FACULTY,
  EARLY_CHILDHOOD_FACULTY,
  ENGLISH_FACULTY,
  HOSPITALITY_FACULTY,
  TECH_SCIENCES_FACULTY
}

class SchoolNameEnumUtils {
  static const Map<String, SchoolNameEnum> AIBT_SCHOOL_NAME_MAP = const {
    StringConstants.ACE_SCHOOL_NAME: SchoolNameEnum.ACE,
    StringConstants.BESPOKE_SCHOOL_NAME: SchoolNameEnum.BESPOKE,
    StringConstants.BRANSON_SCHOOL_NAME: SchoolNameEnum.BRANSON,
    StringConstants.DIANA_SCHOOL_NAME: SchoolNameEnum.DIANA,
    StringConstants.EDISON_SCHOOL_NAME: SchoolNameEnum.EDISON,
    StringConstants.SHELDON_SCHOOL_NAME: SchoolNameEnum.SHELDON,
    StringConstants.BUSINESS_AND_TECHNOLOGY_SCHOOL_NAME: SchoolNameEnum.BUSINESS_AND_TECHNOLOGY_FACULTY,
    StringConstants.EARLY_CHILDHOOD_SCHOOL_NAME: SchoolNameEnum.EARLY_CHILDHOOD_FACULTY,
    StringConstants.ENGLISH_SCHOOL_NAME: SchoolNameEnum.ENGLISH_FACULTY,
    StringConstants.HOSPITALITY_SCHOOL_NAME: SchoolNameEnum.HOSPITALITY_FACULTY,
    StringConstants.TECH_SCIENCES_SCHOOL_NAME: SchoolNameEnum.TECH_SCIENCES_FACULTY,
  };

  static SchoolNameEnum? fromValue(String value) {
    return AIBT_SCHOOL_NAME_MAP[value];
  }
}
