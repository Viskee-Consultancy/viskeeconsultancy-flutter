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
        appBar: CommonWidgets.getAppBar(context),
        body: Container(child: ListView(shrinkWrap: false, children: _getListData())));
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    widgets.add(_buildCourseName());
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
          padding: EdgeInsets.all(10.0),
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
          _buildDurationSection(),
          _buildLocationSection(),
          _buildTuitionSection(),
          _buildPlacementSection(),
          _buildTermsConditionSection()
        ],
      ),
    );
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
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
            "Placement",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: _getPlacementFeeText(_course),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: _getPlacementDurationText(_course),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildTermsConditionSection() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
          ),
          child: Text("Terms and Conditions"),
          onPressed: () {
            _launchURL("https://aibtglobal.edu.au/courses/terms-for-courses/");
          }),
    );
  }

  Text _getVetCodeText(Course? course) {
    if (course != null && course.vetCode != null) {
      return Text(
        "VET National Code:" + course.vetCode!,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text _getCricosCodeText(Course? course) {
    if (course != null && course.cricosCode != null) {
      return Text(
        "CRICOS Course Code:" + course.cricosCode!,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Widget _getTotalDurationText(Course? course) {
    if (course != null) {
      if (course.isOnPromotion && (course.promotionDuration != null || course.promotionMinDuration != null || course.promotionMaxDuration != null)) {
        return Column(
          children: [
            Text(
              course.getDurationString() + " Weeks",
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.getPromotionDurationString() + " Weeks",
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.getDurationString() + " Weeks",
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getDurationDetailText(Course? course) {
    if (course != null && course.durationDetail != null) {
      if (course.isOnPromotion && course.promotionDurationDetail != null) {
        return Column(
          children: [
            Text(
              course.durationDetail!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionDurationDetail!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.durationDetail!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getLocationText(Course? course) {
    if (course != null && course.location != null) {
      if (course.isOnPromotion && course.promotionLocation != null) {
        return Column(
          children: [
            Text(
              course.location!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionLocation!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.location!.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getLocationDetailText(Course? course) {
    if (course != null && course.locationDetail != null) {
      if (course.isOnPromotion && course.promotionLocationDetail != null) {
        return Column(
          children: [
            Text(
              course.locationDetail!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionLocationDetail!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.locationDetail!.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionText(Course? course) {
    if (course != null && course.tuition != null) {
      if (course.isOnPromotion && course.promotionTuition != null) {
        return Column(
          children: [
            Text(
              course.tuition!.toString() + "\$",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionTuition!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.tuition!.toString() + "\$",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionHalfText(Course? course) {
    if (course != null && course.tuitionHalf != null) {
      if (course.isOnPromotion && course.promotionTuitionHalf != null) {
        return Column(
          children: [
            Text(
              "Tuition Half Payment: " + course.tuitionHalf!.toString() + "\$",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionTuitionHalf!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.tuitionHalf!.toString() + "\$",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionHalfDetailText(Course? course) {
    if (course != null && course.tuitionHalfDetail != null) {
      if (course.isOnPromotion && course.promotionTuitionHalfDetail != null) {
        return Column(
          children: [
            Text(
              course.tuitionHalfDetail!.toString() + " \$",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionTuitionHalfDetail!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.tuitionHalfDetail!.toString() + " \$",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getTuitionDetailText(Course? course) {
    if (course != null && course.tuitionDetail != null) {
      if (course.isOnPromotion && course.promotionTuitionDetail != null) {
        return Column(
          children: [
            Text(
              course.tuitionDetail!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionTuitionDetail!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        );
      } else {
        return Text(
          course.tuitionDetail!.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        );
      }
    } else {
      return Text("");
    }
  }

  Widget _getPlacementFeeText(Course? course) {
    if (course != null && course.placementFee != null) {
      return Text(
        "Placement Fee: " + course.placementFee!.toString() + " \$",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Widget _getPlacementDurationText(Course? course) {
    if (course != null && course.placementDuration != null) {
      return Text(
        "Placement Duration: " + course.placementDuration!.toString() + " hours",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      );
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
