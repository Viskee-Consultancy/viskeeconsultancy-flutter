import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/Brochure.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/pages/BrochureDownloadPage.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

import 'CourseDetailPage.dart';

School? _school;
List<Department> _departments = [];

class SchoolCoursesPage extends StatelessWidget {
  SchoolCoursesPage(School schoolInput) {
    _school = schoolInput;
  }

  @override
  Widget build(BuildContext context) {
    buildDepartmentList(_school!);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CommonWidgets.getAppBar(context),
        body: Container(
          child: new SchoolCoursesPageView(),
        ));
  }

  void buildDepartmentList(School school) {
    _departments.clear();
    Map<String, List<Course>> m = new Map();
    for (var i = 0; i < school.courses.length; i++) {
      var course = school.courses[i];
      if (m[course.department] == null) {
        List<Course> courses = [course];
        m[course.department!] = courses;
      } else {
        m[course.department!]!.add(course);
      }
    }
    m.entries.forEach((entry) => {_departments.add(new Department(entry.key, entry.value))});
  }
}

class SchoolCoursesPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          flex: 1,
          child: Container(
            child: null,
          )),
      Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.center,
            child: Utils.getSchoolLogo(_school!.name),
          )),
      Expanded(
          flex: 8,
          child: Align(
            alignment: Alignment.topCenter,
            child: _buildGrid(),
          )),
    ]);
  }

  Widget _buildGrid() => new StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        shrinkWrap: true,
        // padding: const EdgeInsets.all(1),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemCount: _departments.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(_departments.length),
        itemBuilder: (BuildContext context, int index) {
          return new DepartmentCourseGridView(index);
        },
      );
}

class DepartmentCourseGridView extends StatelessWidget {
  late Department _department;

  DepartmentCourseGridView(int position) {
    this._department = _departments[position];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(_department.name!,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: CustomColors.GOLD)),
          ListView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: _getListData()),
        ],
      ),
    );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < _department.courses.length; i++) {
      Course course = _department.courses[i];
      if (course.isOnPromotion) {
        widgets.add(new PromotionCourseItemView(_department.courses[i]));
      } else {
        widgets.add(new CourseItemView(_department.courses[i]));
      }
    }
    return widgets;
  }
}

class CourseItemView extends StatelessWidget {
  late Course _course;

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
                Navigator.push(
                    context, PageTransition(child: CourseDetailPage(_course), type: PageTransitionType.topToBottom));
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  _course.name!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),
              )),
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class PromotionCourseItemView extends StatelessWidget {
  late Course _course;

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
                Navigator.push(
                    context, PageTransition(child: CourseDetailPage(_course), type: PageTransitionType.topToBottom));
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
                        child: Text(
                          _course.name!,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ))),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
