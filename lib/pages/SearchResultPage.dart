// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

// void main() => runApp(SearchResultPage());

SearchResult? result;
List<Course>? coursesToDisplay = [];
List<Course>? coursesAIBT = [];
List<Course>? coursesREACH = [];

class SearchResultPage extends StatefulWidget {
  SearchResultPage(SearchResult searchResult) {
    result = searchResult;
    coursesAIBT = searchResult.searchResults[GroupEnum.AIBT];
    // print("Courses AIBT: " + coursesAIBT.toString());
    coursesREACH = searchResult.searchResults[GroupEnum.REACH];
    print("Courses REACH: " + coursesREACH.toString());
    if (coursesAIBT != null) {
      coursesToDisplay = coursesAIBT;
    } else if (coursesREACH != null) {
      coursesToDisplay = coursesREACH;
    }
    if (coursesToDisplay == null) {
      coursesToDisplay = [];
    }
    // print("Course to Display: " + coursesToDisplay.toString());
  }
  SearchResultView createState() => new SearchResultView();
}

class SearchResultView extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
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
                    child: Text("Search Results For " + result!.searchText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: CustomColors.GOLD))),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                      children: [Text("AIBT"), Text("REACH")],
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            _selections = [true, false];
                            coursesToDisplay = coursesAIBT;
                          } else if (index == 1) {
                            _selections = [false, true];
                            coursesToDisplay = coursesREACH;
                          }
                        });
                      },
                      isSelected: _selections,
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildGrid(),
                  ))
            ])));
  }

  List<bool> _selections = [true, false];

  // #docregion grid
  Widget _buildGrid() => new StaggeredGridView.countBuilder(
        crossAxisCount: coursesToDisplay!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemCount: coursesToDisplay!.length,
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(coursesToDisplay!.length),
        itemBuilder: (BuildContext context, int index) {
          return new SearchResultGridView(index);
        },
      );
}

class SearchResultGridView extends StatelessWidget {
  Course? course;
  SearchResultGridView(int position) {
    this.course = coursesToDisplay![position];
    // this.schoolName = schoolNames[position];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed("/course_detail_page", arguments: course);
          },
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(const Radius.circular(8)),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(course!.name!),
                    Text("VET National Code: " + course!.vetCode!),
                    Text("CRICOS Course Code: " + course!.cricosCode!),
                  ],
                ),
              )),
        ));
  }
}
