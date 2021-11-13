import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

import 'CourseDetailPage.dart';

SearchResult? _result;
List<Course>? _coursesToDisplay = [];
List<Course>? _coursesAIBT = [];
List<Course>? _coursesREACH = [];

class SearchResultPage extends StatefulWidget {
  SearchResultPage(SearchResult searchResult) {
    _result = searchResult;
    _coursesAIBT = searchResult.searchResults[GroupEnum.AIBT];
    _coursesREACH = searchResult.searchResults[GroupEnum.REACH];
    if (_coursesAIBT == null) {
      _coursesAIBT = [];
    }
    if (_coursesREACH == null) {
      _coursesREACH = [];
    }
    if (_coursesAIBT!.isNotEmpty) {
      _coursesToDisplay = _coursesAIBT;
    } else if (_coursesREACH!.isNotEmpty) {
      _coursesToDisplay = _coursesREACH;
    }
    if (_coursesToDisplay == null) {
      _coursesToDisplay = [];
    }
  }

  SearchResultView createState() => new SearchResultView();
}

class SearchResultView extends State<SearchResultPage> {
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
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: AppBar().preferredSize.height + 20, bottom: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Search Results For: " + _result!.searchText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                      borderColor: CustomColors.GOLD,
                      borderRadius: const BorderRadius.all(const Radius.circular(8)),
                      selectedColor: Colors.white,
                      disabledColor: Colors.black,
                      fillColor: CustomColors.GOLD,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(StringConstants.AIBT_GROUP_NAME,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(StringConstants.REACH_GROUP_NAME,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        )
                      ],
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            NavigationPath.PATH.removeLast();
                            NavigationPath.PATH.add(StringConstants.AIBT_GROUP_NAME);
                            _selections = [true, false];
                            _coursesToDisplay = _coursesAIBT;
                          } else if (index == 1) {
                            NavigationPath.PATH.removeLast();
                            NavigationPath.PATH.add(StringConstants.REACH_GROUP_NAME);
                            _selections = [false, true];
                            _coursesToDisplay = _coursesREACH;
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
            ]))));
  }

  List<bool> _selections = buildSelections();
}

List<bool> buildSelections() {
  List<bool> _selections;
  if (!_coursesAIBT!.isEmpty) {
    NavigationPath.PATH.add(StringConstants.AIBT_GROUP_NAME);
    _selections = [true, false];
  } else if (_coursesAIBT!.isEmpty && !_coursesREACH!.isEmpty) {
    NavigationPath.PATH.add(StringConstants.REACH_GROUP_NAME);
    _selections = [false, true];
  } else {
    NavigationPath.PATH.add(StringConstants.AIBT_GROUP_NAME);
    _selections = [true, false];
  }
  return _selections;
}

class SearchResultGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_coursesToDisplay!.isNotEmpty) {
      return new StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemCount: _coursesToDisplay!.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(_coursesToDisplay!.length),
        itemBuilder: (BuildContext context, int index) {
          return new SearchResultGridItem(index);
        },
      );
    } else {
      return new Container(
        child: null,
      );
    }
  }
}

class SearchResultGridItem extends StatelessWidget {
  Course? course;

  SearchResultGridItem(int position) {
    this.course = _coursesToDisplay![position];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: CustomColors.GOLD),
              borderRadius: const BorderRadius.all(const Radius.circular(8)),
            ),
            child: new Material(
              child: new InkWell(
                  onTap: () {
                    Navigator.push(context,
                        PageTransition(child: CourseDetailPage(course!, true), type: PageTransitionType.rightToLeft));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _getCourseNameText(),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: _getVetCodeText(),
                            )),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: _getCricosCodeText(),
                            ))
                      ],
                    ),
                  )),
              color: Colors.transparent,
            )));
  }

  Widget _getCourseNameText() {
    if (course!.isOnPromotion) {
      return Row(children: [
        Icon(
          Icons.sell_outlined,
          color: CustomColors.GOLD,
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              course!.name!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.GOLD),
            ),
          ),
        )
      ]);
    } else {
      return Text(
        course!.name!,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.GOLD),
      );
    }
  }

  Widget _getVetCodeText() {
    if (course != null && course!.vetCode != null && course!.vetCode!.trim().isNotEmpty) {
      return Text("VET National Code: " + course!.vetCode!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
    } else {
      return Text("");
    }
  }

  Widget _getCricosCodeText() {
    if (course != null && course!.cricosCode != null && course!.cricosCode!.trim().isNotEmpty) {
      return Text("CRICOS Course Code: " + course!.cricosCode!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
    } else {
      return Text("");
    }
  }
}
