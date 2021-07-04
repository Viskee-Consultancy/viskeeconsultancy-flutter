import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

import 'CourseDetailPage.dart';

SearchResult? result;
List<Course>? coursesToDisplay = [];
List<Course>? coursesAIBT = [];
List<Course>? coursesREACH = [];

class SearchResultPage extends StatefulWidget {
  SearchResultPage(SearchResult searchResult) {
    result = searchResult;
    coursesAIBT = searchResult.searchResults[GroupEnum.AIBT];
    coursesREACH = searchResult.searchResults[GroupEnum.REACH];
    if (coursesAIBT == null) {
      coursesAIBT = [];
    }
    if (coursesREACH == null) {
      coursesREACH = [];
    }
    if (coursesAIBT!.isNotEmpty) {
      coursesToDisplay = coursesAIBT;
    } else if (coursesREACH!.isNotEmpty) {
      coursesToDisplay = coursesREACH;
    }
    if (coursesToDisplay == null) {
      coursesToDisplay = [];
    }
    
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
                      borderColor: CustomColors.GOLD,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(8)),
                      selectedColor: Colors.white,
                      disabledColor: Colors.black,
                      fillColor: CustomColors.GOLD,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text("AIBT"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text("REACH"),
                        )
                      ],
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
                    alignment: Alignment.topCenter,
                    child: new SearchResultGridView(),
                  ))
            ])));
  }

  List<bool> _selections = [true, false];

}

class SearchResultGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (coursesToDisplay!.isNotEmpty) {
      return new StaggeredGridView.countBuilder(
        crossAxisCount: coursesToDisplay!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemCount: coursesToDisplay!.length,
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(coursesToDisplay!.length),
        itemBuilder: (BuildContext context, int index) {
          return new SearchResultGridItem(index);
        },
      );
    } else {
      return new Container(child: null,);
    }
  }
}

class SearchResultGridItem extends StatelessWidget {
  Course? course;
  SearchResultGridItem(int position) {
    this.course = coursesToDisplay![position];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetailPage(course!)));
          },
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: CustomColors.GOLD),
                borderRadius: const BorderRadius.all(const Radius.circular(8)),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        course!.name!,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.GOLD),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("VET National Code: " + course!.vetCode!),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                              "CRICOS Course Code: " + course!.cricosCode!),
                        ))
                  ],
                ),
              )),
        ));
  }
}
