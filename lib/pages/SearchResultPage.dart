import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/models/GroupEnum.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

import 'CourseDetailPage.dart';

List<School> _schoolsToDisplay = [];
List<School> _schoolsAIBT = [];
List<School> _schoolsAIBT_I = [];
List<School> _schoolsREACH = [];
List<School> _schoolsAVTA = [];
List<School> _schoolsNPA = [];

class SearchResultPage extends StatefulWidget {
  late final SearchResult _result;

  SearchResultPage(SearchResult searchResult) {
    _result = searchResult;
    _schoolsAIBT = searchResult.searchResults[GroupEnum.AIBT] ?? [];
    _schoolsAIBT_I = searchResult.searchResults[GroupEnum.AIBT_I] ?? [];
    _schoolsREACH = searchResult.searchResults[GroupEnum.REACH] ?? [];
    _schoolsAVTA = searchResult.searchResults[GroupEnum.AVTA] ?? [];
    _schoolsNPA = searchResult.searchResults[GroupEnum.NPA] ?? [];

    // Avoid crash at the bottom of gridview, add placeholder schools to each groups in order to make them with the
    // same length.
    // But if the group is empty, then not adding place older school to it.
    int maxLength = max(_schoolsAIBT.length, max(_schoolsREACH.length, _schoolsAVTA.length));
    maxLength = max(maxLength, max(_schoolsNPA.length, _schoolsAIBT_I.length));
    if (!_schoolsAIBT.isEmpty) {
      _schoolsAIBT.addAll(buildPlaceHolderSchools(maxLength - _schoolsAIBT.length));
    }
    if (!_schoolsAIBT_I.isEmpty) {
      _schoolsAIBT_I.addAll(buildPlaceHolderSchools(maxLength - _schoolsAIBT_I.length));
    }
    if (!_schoolsREACH.isEmpty) {
      _schoolsREACH.addAll(buildPlaceHolderSchools(maxLength - _schoolsREACH.length));
    }
    if (!_schoolsAVTA.isEmpty) {
      _schoolsAVTA.addAll(buildPlaceHolderSchools(maxLength - _schoolsAVTA.length));
    }
    if (!_schoolsNPA.isEmpty) {
      _schoolsNPA.addAll(buildPlaceHolderSchools(maxLength - _schoolsNPA.length));
    }

    if (_schoolsAIBT.isNotEmpty) {
      _schoolsToDisplay = _schoolsAIBT;
    } else if (_schoolsAIBT_I.isNotEmpty) {
      _schoolsToDisplay = _schoolsAIBT_I;
    }else if (_schoolsREACH.isNotEmpty) {
      _schoolsToDisplay = _schoolsREACH;
    } else if (_schoolsAVTA.isNotEmpty){
      _schoolsToDisplay = _schoolsAVTA;
    } else {
      _schoolsToDisplay = _schoolsNPA;
    }
  }

  List<School> buildPlaceHolderSchools(int number) {
    List<School> placeHolders = [];
    for (int i = 0; i < number; i++) {
      School school = new School("PLACE_HOLDER", []);
      placeHolders.add(school);
    }
    return placeHolders;
  }

  SearchResultView createState() => new SearchResultView(_result.searchText!);
}

class SearchResultView extends State<SearchResultPage> {
  late List<bool> _selections;
  late final _searchText;
  late ScrollController scrollController;

  SearchResultView(String searchText) {
    this._searchText = searchText;
    this._selections = buildSelections();
    this.scrollController = new ScrollController();
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
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: AppBar().preferredSize.height + 40, bottom: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Search Results For: " + _searchText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
              ),
              Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                        children: [ToggleButtons(
                          borderColor: CustomColors.GOLD,
                          borderRadius: const BorderRadius.all(const Radius.circular(8)),
                          selectedColor: Colors.white,
                          disabledColor: Colors.black,
                          fillColor: CustomColors.GOLD,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(StringConstants.AIBT_GROUP_NAME,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(StringConstants.AIBT_I_GROUP_NAME,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                            ),
                            SizedBox(
                              width: 120,
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
                              scrollController.jumpTo(0);
                              _selections.fillRange(0, 5, false);
                              _selections[index] = !_selections[index];
                              NavigationPath.PATH.removeLast();
                              if (index == 0) {
                                NavigationPath.PATH.add(StringConstants.PATH_AIBT);
                                // _selections = [true, false, false, false, false];
                                _schoolsToDisplay = _schoolsAIBT;
                              } else if (index == 1) {
                                NavigationPath.PATH.add(StringConstants.PATH_AIBT_I);
                                // _selections = [false, true, false, false, false];
                                _schoolsToDisplay = _schoolsAIBT_I;
                              }else if (index == 2) {
                                NavigationPath.PATH.add(StringConstants.PATH_REACH);
                                // _selections = [false, false, true, false, false];
                                _schoolsToDisplay = _schoolsREACH;
                              }
                            });
                          },
                          isSelected: _selections.sublist(0, 3),
                        ),ToggleButtons(
                          borderColor: CustomColors.GOLD,
                          borderRadius: const BorderRadius.all(const Radius.circular(8)),
                          selectedColor: Colors.white,
                          disabledColor: Colors.black,
                          fillColor: CustomColors.GOLD,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(StringConstants.AVTA_GROUP_NAME,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Text(StringConstants.NPA_GROUP_NAME,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                            )
                          ],
                          onPressed: (int index) {
                            setState(() {
                              scrollController.jumpTo(0);
                              NavigationPath.PATH.removeLast();
                              _selections.fillRange(0, 5, false);
                                _selections[index+3] = !_selections[index+3];
                              if (index == 0) {
                                NavigationPath.PATH.add(StringConstants.PATH_AVTA);
                                _schoolsToDisplay = _schoolsAVTA;
                              } else if (index == 1) {
                                NavigationPath.PATH.add(StringConstants.PATH_NPA);
                                _schoolsToDisplay = _schoolsNPA;
                              }
                            });
                          },
                          isSelected: _selections.sublist(3),
                        )]
                    )
                  )),
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: _buildResultDisplayColumn(),
                  ))
            ]))));
  }

  List<bool> buildSelections() {
    List<bool> _selections;
    if (!_schoolsAIBT.isEmpty) {
      NavigationPath.PATH.add(StringConstants.PATH_AIBT);
      _selections = [true, false, false, false, false];
    } else if (_schoolsAIBT.isEmpty && _schoolsAIBT_I.isNotEmpty) {
      NavigationPath.PATH.add(StringConstants.PATH_AIBT_I);
      _selections = [false, true, false, false, false];
    }else if (_schoolsAIBT.isEmpty && _schoolsAIBT_I.isEmpty && _schoolsREACH.isNotEmpty) {
      NavigationPath.PATH.add(StringConstants.PATH_REACH);
      _selections = [false, false, true, false, false];
    } else if (_schoolsAIBT.isEmpty && _schoolsAIBT_I.isEmpty && _schoolsREACH.isEmpty && _schoolsAVTA.isNotEmpty) {
      NavigationPath.PATH.add(StringConstants.PATH_AVTA);
      _selections = [false, false, false, true, false];
    } else if (_schoolsAIBT.isEmpty && _schoolsAIBT_I.isEmpty && _schoolsREACH.isEmpty && _schoolsAVTA.isEmpty && _schoolsNPA.isNotEmpty) {
      NavigationPath.PATH.add(StringConstants.PATH_NPA);
      _selections = [false, false, false, false, true];
    } else {
      _selections = [true, false, false, false, false];
    }
    return _selections;
  }

  Widget _buildResultDisplayColumn() {
    List<Widget> widgets = [];
    for (School school in _schoolsToDisplay) {
      widgets.add(new SchoolGridView(school));
    }
    return CustomScrollView(
      controller: scrollController,
      slivers: widgets,
    );
  }
}

class SchoolGridView extends StatelessWidget {
  late final School _school;

  SchoolGridView(School school) {
    this._school = school;
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: _buildHeader(),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => GridTile(child: SearchResultGridItem(_school.courses[i])),
          childCount: _school.courses.length,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (_school.name == "PLACE_HOLDER") {
      return Container(
        child: null,
      );
    } else {
      return Container(
        height: 40.0,
        color: CustomColors.GOLD,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Text(Utils.getSchoolTitle(_school.name!),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white)),
      );
    }
  }
}

class SearchResultGridItem extends StatelessWidget {
  late final Course _course;

  SearchResultGridItem(Course course) {
    this._course = course;
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
                    NavigationPath.PATH.add("\n" + Utils.getSchoolTitle(_course.schoolName!));
                    Navigator.push(context,
                        PageTransition(child: CourseDetailPage(_course, true), type: PageTransitionType.rightToLeft));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, right: 5, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _getCourseNameText(context),
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

  Widget _getCourseNameText(BuildContext context) {
    if (_course.isOnPromotion) {
      return Row(children: [
        Icon(
          Icons.sell_outlined,
          color: CustomColors.GOLD,
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              _course.name!,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.GOLD),
            ),
          ),
        )
      ]);
    } else {
      return Text(
        _course.name!,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.GOLD),
      );
    }
  }

  Widget _getVetCodeText() {
    if (_course.vetCode != null && _course.vetCode!.trim().isNotEmpty) {
      return Text("VET National Code: " + _course.vetCode!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
    } else {
      return Text("");
    }
  }

  Widget _getCricosCodeText() {
    if (_course.cricosCode != null && _course.cricosCode!.trim().isNotEmpty) {
      return Text("CRICOS Course Code: " + _course.cricosCode!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
    } else {
      return Text("");
    }
  }
}
