import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

import 'BrochureDownloadPage.dart';
import 'SchoolCoursesPage.dart';

class SchoolLogoPage extends StatelessWidget {
  late final Group _group;

  SchoolLogoPage(Group group) {
    _group = group;
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
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(top: AppBar().preferredSize.height + 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: _buildTitleLogo(),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                                width: 260,
                                height: 40,
                                child: Visibility(
                                  visible: _group.brochures.isNotEmpty,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(Utils.getGroupPrimaryColor(_group.name)),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text("LATEST BROCHURES",
                                              style: TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                                      onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: BrochureDownloadPage(_group.name!, _group.brochures),
                                                  type: PageTransitionType.rightToLeft));
                                      })
                                )),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                                width: 260,
                                height: 40,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(Utils.getGroupPrimaryColor(_group.name)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("LATEST VIDEOS",
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                                    onPressed: () {
                                      Utils.launchURL(Utils.getGroupVideoLink(_group.name));
                                    })),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 8,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: _buildSchoolGrid(),
                      )),
                ],
              ),
            )));
  }

  Widget _buildTitleLogo() {
      return Utils.isRunningOnMobileBrowser()
          ? Padding(padding: EdgeInsets.all(30), child: Utils.getGroupLogoLandscape(_group.name))
          : Utils.getGroupLogoSVG(_group.name);
  }

  Widget _buildSchoolGrid() => new StaggeredGridView.countBuilder(
      crossAxisCount: 1,
      shrinkWrap: true,
      // maxCrossAxisExtent: 240,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      itemCount: _group.schools.length,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(_group.schools.length),
      itemBuilder: (BuildContext context, int index) {
        return new SchoolGridView(_group, index);
      });
}

class SchoolGridView extends StatelessWidget {
  late final School _school;
  late final Group _group;

  SchoolGridView(Group group, int index) {
    this._group = group;
    this._school = group.schools[index];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Utils.getGroupSecondaryColor(_group.name)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ))),
          onPressed: () {
            NavigationPath.PATH.add("\n" + Utils.getSchoolTitle(_school.name!));
            Navigator.push(
                context, PageTransition(child: SchoolCoursesPage(_school, _group.name!), type: PageTransitionType.rightToLeft));
          },
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 14, 10, 7),
                  child: Text(Utils.getSchoolTitle(_school.name!),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 7, 10, 14),
                  child: Text(buildDepartmentString(_school.departments),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15)))
            ],
          ),
        ));
  }

  String buildDepartmentString(List<Department> departments) {
    List<String> departmentNames = departments.map((e) => e.name!).toList();
    departmentNames.removeWhere((element) => element.toLowerCase().contains("package"));
    return departmentNames.join(" | ");
  }
}
