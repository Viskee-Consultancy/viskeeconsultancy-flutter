// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

// void main() => runApp(SchoolLogoPage());
Group? aibtGroup;

class SchoolLogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    aibtGroup = ModalRoute.of(context)!.settings.arguments as Group;

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
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    child: null,
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset("images/aibt_landscape.png"),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.GOLD),
                        ),
                        child: Text("LATEST BROCHURES"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed("/brochure_download_page", arguments: aibtGroup);
                        }),
                  )),
              Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildGrid(),
                  )),
            ],
          ),
        ));
  }

  // #docregion grid
  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 240,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: _buildGridTileList(aibtGroup!.schools.length));

  // The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
  // The List.generate() constructor allows an easy way to create
  // a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count) =>
      List.generate(count, (i) => Container(child: SchoolLogoGridView(i)));
}

class SchoolLogoGridView extends StatelessWidget {
  School? school;
  SchoolLogoGridView(int position) {
    this.school = aibtGroup!.schools[position];
    // this.schoolName = schoolNames[position];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            // print("School Courses Page button click");
            Navigator.of(context)
                .pushNamed("/school_courses_page", arguments: school);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Utils.getSchoolLogoPortrait(school!.name),
            )
          ),
        ));
  }
}
