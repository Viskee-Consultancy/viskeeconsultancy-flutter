import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

class CourseDetailPage extends StatelessWidget {
  late Course _course;

  CourseDetailPage(Course input) {
    _course = input;
  }

  @override
  Widget build(BuildContext context) {
    if (_course == null) {
      _course = ModalRoute.of(context)!.settings.arguments as Course;
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CommonWidgets.getAppBar(context, false),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: _buildCourseName(),
            ),
            // Expanded(flex: 1, child: _buildVetCode()),
            Expanded(child: ListView(shrinkWrap: false, children: _getListData()))
          ],
        ));
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    // widgets.add(_buildCourseName());
    widgets.add(_buildVetCode());
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
          _course.isOnPromotion ? "Promotion Duration" : "Total Duration",
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
          _course.isOnPromotion ? "Promotion Location" : "Location",
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
          _course.isOnPromotion ? "Promotion Tuition" : "Tuition",
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
    if (_course != null && _course.placementFee != null) {
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
            _course.isOnPromotion ? "Promotion Placement" : "Placement",
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
            _course.isOnPromotion ? "Promotion Note" : "Note",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(_course.note!, textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
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
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Terms and Conditions",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
          onPressed: () {
            _launchURL("https://aibtglobal.edu.au/courses/terms-for-courses/");
          }),
    );
  }

  Text _getVetCodeText(Course? course) {
    if (course != null && course.vetCode != null) {
      return Text(
        "VET National Code:" + course.vetCode!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else {
      return Text("");
    }
  }

  Text _getCricosCodeText(Course? course) {
    if (course != null && course.cricosCode != null) {
      return Text(
        "CRICOS Course Code:" + course.cricosCode!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else {
      return Text("");
    }
  }

  Widget _getTotalDurationText(Course? course) {
    if (course != null && course.duration != null) {
      // if (course.isPromotionDurationChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getDurationString(),
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionDurationString(),
      //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
      return Text(
        course.getDurationString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      );
      // }
    } else {
      return Text("");
    }
  }

  Widget _getDurationDetailText(Course? course) {
    if (course != null && course.durationDetail != null && course.durationDetail!.trim().isNotEmpty) {
      // if (course.isPromotionDurationDetailChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.durationDetail!,
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.promotionDurationDetail!,
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getLocationText(Course? course) {
    if (course != null && course.location != null && course.location!.trim().isNotEmpty) {
      // if (course.isPromotionDurationChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.location!.toString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.promotionLocation!.toString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getLocationDetailText(Course? course) {
    if (course != null && course.locationDetail != null && course.locationDetail!.trim().isNotEmpty) {
      // if (course.isPromotionLocationDetailChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.locationDetail!.toString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.promotionLocationDetail!.toString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getTuitionText(Course? course) {
    if (course != null && course.tuition != null && course.tuition!.trim().isNotEmpty) {
      // if (course.isPromotionTuitionChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getTuitionString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionTuitionString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getTuitionDetailText(Course? course) {
    if (course != null && course.tuitionDetail != null && course.tuitionDetail!.trim().isNotEmpty) {
      // if (course.isPromotionTuitionDetailChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.tuitionDetail!.toString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.promotionTuitionDetail!.toString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getTuitionHalfText(Course? course) {
    if (course != null && course.tuitionHalf != null && course.tuitionHalf!.trim().isNotEmpty) {
      // if (course.isPromotionTuitionHalfChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getTuitionHalfString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionTuitionHalfString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getTuitionHalfDetailText(Course? course) {
    if (course != null && course.tuitionHalfDetail != null && course.tuitionHalfDetail!.trim().isNotEmpty) {
      // if (course.isPromotionTuitionHalfDetailChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getTuitionHalfDetailString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionTuitionHalfDetailString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getPlacementFeeText(Course? course) {
    if (course != null && course.placementFee != null && course.placementFee!.trim().isNotEmpty) {
      // if (course.isPromotionPlacementFeeChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getPlacementFeeString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionPlacementFeeString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getPlacementDurationText(Course? course) {
    if (course != null && course.placementDuration != null && course.placementDuration!.trim().isNotEmpty) {
      // if (course.isPromotionPlacementDurationChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getPlacementDurationString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionPlacementDurationString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  Widget _getPlacementDetailText(Course? course) {
    if (course != null && course.placementDetail != null && course.placementDetail!.trim().isNotEmpty) {
      // if (course.isPromotionPlacementDurationChange()) {
      //   return Column(
      //     children: [
      //       Text(
      //         course.getPlacementDetailString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
      //       ),
      //       Text(
      //         course.getPromotionPlacementDetailString(),
      //         textAlign: TextAlign.center,
      //         style: TextStyle(color: Colors.black, fontSize: 16),
      //       )
      //     ],
      //   );
      // } else {
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
