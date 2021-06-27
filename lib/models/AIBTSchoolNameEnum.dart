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
      "ACE AVIATION AEROSPACE ACADEMY" : AIBTSchoolNameEnum.ACE,
      "BESPOKE GRAMMAR SCHOOL OF ENGLISH":AIBTSchoolNameEnum.BESPOKE,
      "BRANSON SCHOOL OF BUSINESS AND TECHNOLOGY":AIBTSchoolNameEnum.BRANSON,
      "DIANA SCHOOL OF COMMUNITY SERVICES":AIBTSchoolNameEnum.DIANA,
      "EDISON SCHOOL OF TECH SCIENCES":AIBTSchoolNameEnum.EDISON,
      "SHELDON SCHOOL OF HOSPITALITY":AIBTSchoolNameEnum.SHELDON,
      "REACH COMMUNITY COLLEGE":AIBTSchoolNameEnum.REACH
    };

    AIBTSchoolNameEnum? fromValue(String value) {
      return AIBT_SCHOOL_NAME_MAP[value];
    }
}

