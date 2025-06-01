import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

class CourseDetailPage extends StatelessWidget {
  late final Course _course;
  late final bool _isFromSearch;
  late final BuildContext _context;

  CourseDetailPage(Course input, bool isFromSearch) {
    _course = input;
    _isFromSearch = isFromSearch;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return WillPopScope(
        onWillPop: () async {
          Utils.onBackPressed(context, _isFromSearch ? true : false);
          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonWidgets.getAppBar(context, _isFromSearch ? true : false),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, AppBar().preferredSize.height + 40, 5, 10),
                  child: _buildCourseName(),
                ),
                Expanded(child: ListView(padding: EdgeInsets.zero, shrinkWrap: false, children: _getListData()))
              ],
            )));
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    widgets.add(_buildCourseDetail());
    return widgets;
  }

  Widget _buildCourseName() {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(_course.name!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))));
  }

  Widget _buildVetCode() {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [_getVetCodeText(_course), _getCricosCodeText(_course)],
          ),
        ));
  }

  Widget _buildCourseDetail() {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          _buildVetCode(),
          _buildPromotionValiditySection(),
          _buildDurationSection(),
          _buildLocationSection(),
          _buildTuitionSection(),
          _buildPlacementSection(),
          _buildNoteSection(),
          _buildTermsConditionSection()
        ],
      ),
    );
  }

  Widget _buildPromotionValiditySection() {
    if (_course.isOnPromotion && _course.promotionValidity != null && _course.promotionValidity!.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              Icons.sell_outlined,
              color: CustomColors.GOLD,
              size: 64,
            ),
          ),
          Text(
            "Promotion Validity",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              _course.promotionValidity!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          )
        ],
      );
    } else {
      return Container(
        child: null,
      );
    }
  }

  Widget _buildDurationSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(
            Icons.schedule_outlined,
            color: CustomColors.GOLD,
            size: 64,
          ),
        ),
        Text(
          "Total Duration",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: _getTotalDurationText(_course),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: _getDurationDetailText(_course),
        )
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(
            Icons.location_on_outlined,
            color: CustomColors.GOLD,
            size: 64,
          ),
        ),
        Text(
          "Location",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: _getLocationText(_course),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: _getLocationDetailText(_course),
        )
      ],
    );
  }

  Widget _buildTuitionSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(
            Icons.attach_money_outlined,
            color: CustomColors.GOLD,
            size: 64,
          ),
        ),
        Text(
          "Tuition",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: _getTuitionText(_course),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: _getTuitionDetailText(_course),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: _getTuitionHalfText(_course),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: _getTuitionHalfDetailText(_course),
        )
      ],
    );
  }

  Widget _buildPlacementSection() {
    if (_course.placementFee != null) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              Icons.work_outline_outlined,
              color: CustomColors.GOLD,
              size: 64,
            ),
          ),
          Text(
            "Placement",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: _getPlacementFeeText(_course),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: _getPlacementDurationText(_course),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: _getPlacementDetailText(_course),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildNoteSection() {
    if (_course.note != null && _course.note!.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              Icons.description_outlined,
              color: CustomColors.GOLD,
              size: 64,
            ),
          ),
          Text(
            "Note",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(_course.note!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          )
        ],
      );
    } else {
      return Container(
        child: null,
      );
    }
  }

  Widget _buildTermsConditionSection() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(CustomColors.GOLD),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text("CONTACT US",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                    onPressed: () {
                      Utils.launchURL(Utils.getContactLink(_course.group));
                    }))),
        Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(CustomColors.GOLD),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text("START A NEW SEARCH",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                    onPressed: () {
                      Utils.onBackPressed(_context, false);
                      Utils.onBackPressed(_context, false);
                      Utils.onBackPressed(_context, false);
                      Utils.onBackPressed(_context, false);
                      if (!_isFromSearch) {
                        Utils.onBackPressed(_context, false);
                      }
                      NavigationPath.PATH.clear();
                    }))),
        Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text("TERMS AND CONDITIONS",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                    onPressed: () {
                      Utils.launchURL(Utils.getTermsLink(_course.group));
                    })))
      ],
    );
  }

  Text _getVetCodeText(Course course) {
    if (course.vetCode != null) {
      return Text(
        "VET National Code:" + course.vetCode!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else {
      return Text("");
    }
  }

  Text _getCricosCodeText(Course course) {
    if (course.cricosCode != null) {
      return Text(
        "CRICOS Course Code:" + course.cricosCode!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else {
      return Text("");
    }
  }

  Widget _getTotalDurationText(Course course) {
    if (course.duration != null) {
      return Text(
        course.getDurationString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getDurationDetailText(Course course) {
    if (course.durationDetail != null && course.durationDetail!.trim().isNotEmpty) {
      return Text(
        course.durationDetail!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getLocationText(Course course) {
    if (course.location != null && course.location!.trim().isNotEmpty) {
      return Text(
        course.location!.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getLocationDetailText(Course course) {
    if (course.locationDetail != null && course.locationDetail!.trim().isNotEmpty) {
      return Text(
        course.locationDetail!.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionText(Course course) {
    if (course.tuition != null && course.tuition!.trim().isNotEmpty) {
      return Text(
        course.getTuitionString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionDetailText(Course course) {
    if (course.tuitionDetail != null && course.tuitionDetail!.trim().isNotEmpty) {
      return Text(
        course.tuitionDetail!.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionHalfText(Course course) {
    if (course.tuitionHalf != null && course.tuitionHalf!.trim().isNotEmpty) {
      return Text(
        course.getTuitionHalfString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionHalfDetailText(Course course) {
    if (course.tuitionHalfDetail != null && course.tuitionHalfDetail!.trim().isNotEmpty) {
      return Text(
        course.getTuitionHalfDetailString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getPlacementFeeText(Course course) {
    if (course.placementFee != null && course.placementFee!.trim().isNotEmpty) {
      return Text(
        course.getPlacementFeeString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getPlacementDurationText(Course course) {
    if (course.placementDuration != null && course.placementDuration!.trim().isNotEmpty) {
      return Text(
        course.getPlacementDurationString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getPlacementDetailText(Course course) {
    if (course.placementDetail != null && course.placementDetail!.trim().isNotEmpty) {
      return Text(
        course.getPlacementDetailString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }
}
