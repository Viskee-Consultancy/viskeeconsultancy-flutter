import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viskeeconsultancy/Widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

Course? _course;

class CourseDetailPage extends StatelessWidget {
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
    for (int i = 0; i < 3; i++) {
      widgets.add(new ColumnItem(i));
    }
    return widgets;
  }
}

class ColumnItem extends StatelessWidget {
  late int _index;

  ColumnItem(int index) {
    this._index = index;
  }

  @override
  Widget build(BuildContext context) {
    if (_index == 0) {
      return Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(_course!.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))));
    } else if (_index == 1) {
      return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [getVetCodeText(_course), getCricosCodeText(_course)],
            ),
          ));
    } else if (_index == 2) {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Column(
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
                  child: getTotalDurationText(_course),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: getDurationDetailText(_course),
                )
              ],
            ),
            Column(
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
                  child: getLocationText(_course),
                ),
              ],
            ),
            Column(
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
                  "Pricing",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: getTuitionText(_course),
                )
              ],
            ),
            getPlacementWidget(_course),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
                  ),
                  child: Text("Terms and Conditions"),
                  onPressed: () {
                    launchURL("https://aibtglobal.edu.au/courses/terms-for-courses/");
                  }),
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: null,
      );
    }
  }

  Text getVetCodeText(Course? course) {
    if (course != null && course.vetCode != null) {
      return Text(
        "VET National Code:" + course.vetCode!,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text getCricosCodeText(Course? course) {
    if (course != null && course.cricosCode != null) {
      return Text(
        "CRICOS Course Code:" + course.cricosCode!,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Widget getTotalDurationText(Course? course) {
    if (course != null) {
      if (course.isOnPromotion && course.promotionDuration != null) {
        return Column(
          children: [
            Text(
              course.getDurationString() + " Weeks",
              style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
            ),
            Text(
              course.promotionDuration.toString() + " Weeks",
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

  Widget getDurationDetailText(Course? course) {
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

  Widget getLocationText(Course? course) {
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

  Widget getTuitionText(Course? course) {
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

  Widget getPlacementWidget(Course? course) {
    if (course != null && course.placementFee != null) {
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
            child: getPlacementFeeText(course),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: getPlacementDurationText(course),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget getPlacementFeeText(Course? course) {
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

  Widget getPlacementDurationText(Course? course) {
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

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
