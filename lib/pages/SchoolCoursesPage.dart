import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

import 'CourseDetailPage.dart';

class SchoolCoursesPage extends StatelessWidget {
  late final School _school;

  SchoolCoursesPage(School schoolInput) {
    _school = schoolInput;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Utils.onBackPressed(context, true);
          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonWidgets.getAppBar(context, true),
            body: Container(
              child: new SchoolCoursesPageView(_school),
            )));
  }
}

class SchoolCoursesPageView extends StatelessWidget {
  late final School _school;

  SchoolCoursesPageView(School school) {
    this._school = school;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(5, AppBar().preferredSize.height + 20, 5, 10),
        child: Align(
            alignment: Alignment.topCenter,
            child: Text(Utils.getSchoolTitle(_school.name!),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
      ),
      Expanded(
          child: Align(
        alignment: Alignment.topCenter,
        child: _buildColumn(),
      )),
    ]);
  }

  Widget _buildColumn() {
    List<Widget> widgets = [];
    for (Department department in _school.departments) {
      widgets.add(new DepartmentCourseGridView(department));
    }
    return CustomScrollView(
      slivers: widgets,
    );
  }
}

class DepartmentCourseGridView extends StatelessWidget {
  late final Department _department;

  DepartmentCourseGridView(Department department) {
    this._department = department;
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 60.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Text(_department.name!,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: CustomColors.GOLD)),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(title: _getCourseItem(i)),
          childCount: _department.courses.length,
        ),
      ),
    );
  }

  Widget _getCourseItem(int index) {
    Course course = _department.courses[index];
    if (course.isOnPromotion) {
      return new PromotionCourseItemView(_department.courses[index]);
    } else {
      return new CourseItemView(_department.courses[index]);
    }
  }
}

class CourseItemView extends StatelessWidget {
  late final Course _course;

  CourseItemView(Course course) {
    this._course = course;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.7)),
        ),
        child: new Material(
          child: new InkWell(
              onTap: () {
                Navigator.push(context,
                    PageTransition(child: CourseDetailPage(_course, false), type: PageTransitionType.rightToLeft));
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    _course.name!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )),
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class PromotionCourseItemView extends StatelessWidget {
  late final Course _course;

  PromotionCourseItemView(Course course) {
    this._course = course;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.7)),
        ),
        child: new Material(
          child: new InkWell(
              onTap: () {
                Navigator.push(context,
                    PageTransition(child: CourseDetailPage(_course, false), type: PageTransitionType.rightToLeft));
              },
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sell_outlined,
                        color: CustomColors.GOLD,
                      ),
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          _course.name!,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ))
                    ],
                  ))),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
