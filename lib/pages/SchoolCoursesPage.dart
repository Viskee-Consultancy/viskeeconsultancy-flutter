// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import "package:collection/collection.dart";

void main() => runApp(SchoolCoursesPage());

School? school;
List<Department> departments = new List.empty();
class SchoolCoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    school = ModalRoute.of(context)!.settings.arguments as School;
    buildDepartmentList(school!);
    
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: null,
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Utils.getSchoolLogo(school!.name),
                )),
            Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.center,
                  child: null,
                )),
          ]),
        ));
  }

    // #docregion grid
  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 240,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: _buildGridTileList(school!.courses.length));

  // The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
  // The List.generate() constructor allows an easy way to create
  // a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count) =>
      List.generate(count, (i) => Container(child: SchoolCourseGridView(i)));
      
}

void buildDepartmentList(School school) {
  var map = groupBy(school.courses, (course) => { course as Course, course.department});
  print(map);
}

class SchoolCourseGridView extends StatelessWidget {
  List<Course> courses = new List.empty();
  SchoolCourseGridView(int position) {
    this.courses =school!.courses;
    // this.schoolName = schoolNames[position];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            print("School Courses Page button click");
            Navigator.of(context)
                .pushNamed("/school_courses_page", arguments: school);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            child: Utils.getSchoolLogo(school!.name),
          ),
        ));
  }
}
