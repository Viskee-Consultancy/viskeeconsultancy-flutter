import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/Brochure.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/pages/BrochureDownloadPage.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

import 'CourseDetailPage.dart';

School? school;
List<Brochure>? promotions;
List<Department> departments = [];

class SchoolCoursesPage extends StatelessWidget {
  SchoolCoursesPage(School schoolInput, List<Brochure> promotionsInput) {
    school = schoolInput;
    promotions = promotionsInput;
  }
  @override
  Widget build(BuildContext context) {
    buildDepartmentList(school!);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "images/vc_logo_landscape.png",
                  fit: BoxFit.contain,
                  height: 40,
                ),
              )
            ],
          ),
        ),
        body: Container(
          child: new SchoolCoursesPageView(),
        ));
  }
}

class SchoolCoursesPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (promotions == null || promotions!.isEmpty) {
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
              child: Utils.getSchoolLogoLandscape(school!.name),
            )),
        Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildGrid(),
            )),
      ]);
    } else {
      return Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
        Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: Utils.getSchoolLogoLandscape(school!.name),
            )),
        Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.GOLD),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("LATEST BROCHURES",
                          style: TextStyle(color: Colors.black))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            BrochureDownloadPage(school!.name!, promotions!)));
                  }),
            )),
        Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildGrid(),
            )),
      ]);
    }
  }

  Widget _buildGrid() => new StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemCount: departments.length,
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(departments.length),
        itemBuilder: (BuildContext context, int index) {
          return new DepartmentCourseGridView(index);
        },
      );
}

void buildDepartmentList(School school) {
  departments.clear();
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
  m.entries.forEach(
      (entry) => {departments.add(new Department(entry.key, entry.value))});
}

class DepartmentCourseGridView extends StatelessWidget {
  late Department department;
  DepartmentCourseGridView(int position) {
    this.department = departments[position];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(department.name!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: CustomColors.GOLD)),
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
    for (int i = 0; i < department.courses.length; i++) {
      Course course = department.courses[i];
      if (course.isOnPromotion) {
        widgets.add(new PromotionCourseItemView(department.courses[i]));
      } else {
        widgets.add(new CourseItemView(department.courses[i]));
      }
    }
    return widgets;
  }
}

class CourseItemView extends StatelessWidget {
  late Course course;
  CourseItemView(Course course) {
    this.course = course;
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseDetailPage(course)));
              },
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Flexible(
                    child: Text(
                      course.name!,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),
                    ),
                  ))),
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class PromotionCourseItemView extends StatelessWidget {
  late Course course;
  PromotionCourseItemView(Course course) {
    this.course = course;
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseDetailPage(course)));
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
                          course.name!,
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
