import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

import 'BrochureDownloadPage.dart';
import 'SchoolCoursesPage.dart';

Group? _aibtGroup;

class SchoolLogoPage extends StatelessWidget {
  SchoolLogoPage(Group group) {
    _aibtGroup = group;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CommonWidgets.getAppBar(context),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    child: null,
                  )),
              Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("images/aibt.svg"),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("LATEST BROCHURES", style: TextStyle(color: Colors.black))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: BrochureDownloadPage(_aibtGroup!.name!, _aibtGroup!.brochures),
                                  type: PageTransitionType.topToBottom));
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

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 240,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: _buildGridTileList(_aibtGroup!.schools.length));

  List<Container> _buildGridTileList(int count) => List.generate(count, (i) => Container(child: SchoolLogoGridView(i)));
}

class SchoolLogoGridView extends StatelessWidget {
  late School _school;

  SchoolLogoGridView(int position) {
    this._school = _aibtGroup!.schools[position];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: CustomColors.GOLD),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              const Radius.circular(8),
            )),
        child: new Material(
          child: new InkWell(
              onTap: () {
                Navigator.push(context,
                    PageTransition(child: SchoolCoursesPage(_school, []), type: PageTransitionType.topToBottom));
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Utils.getSchoolLogo(_school.name),
              )),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
