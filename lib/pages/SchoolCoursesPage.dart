// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() => runApp(SchoolCoursesPage());

School? school;
List<Department> departments = [];

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
                  alignment: Alignment.topCenter,
                  child: _buildGrid(),
                )),
          ]),
        ));
  }

  // #docregion grid
  Widget _buildGrid() => new StaggeredGridView.countBuilder(
        crossAxisCount: departments.length,
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

//     children: _buildGridTileList(departments.length));

// // The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// // The List.generate() constructor allows an easy way to create
// // a list when objects have a predictable naming pattern.
// List<Container> _buildGridTileList(int count) =>
//     List.generate(count, (i) => Container(child: DepartmentCourseGridView(i)));

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
  m.entries.forEach((entry) => {
        print(entry.key),
        print(entry.value),
        departments.add(new Department(entry.key, entry.value))
      });
}

class DepartmentCourseGridView extends StatelessWidget {
  late Department department;
  DepartmentCourseGridView(int position) {
    this.department = departments[position];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.all(const Radius.circular(8)),
        ),
        child: Column(
          children: [
            Text(department.name!),
            ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: _getListData()),
          ],
        ),
      ),
    );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < department.courses.length; i++) {
      print(department.courses[i].name);

      widgets.add(Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(department.courses[i].name!),
      ));
    }
    return widgets;
  }
}
