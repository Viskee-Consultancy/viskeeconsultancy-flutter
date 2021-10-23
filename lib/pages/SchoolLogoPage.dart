import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

import 'BrochureDownloadPage.dart';
import 'SchoolCoursesPage.dart';

Group? aibtGroup;

class SchoolLogoPage extends StatelessWidget {
  SchoolLogoPage(Group group) {
    aibtGroup = group;
  }

  @override
  Widget build(BuildContext context) {
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
                child: SvgPicture.asset(
                  "images/vc_logo_landscape.svg",
                  height: 40,
                ),
              )
            ],
          ),
        ),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BrochureDownloadPage(aibtGroup!.name!, aibtGroup!.brochures)));
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
      children: _buildGridTileList(aibtGroup!.schools.length));

  List<Container> _buildGridTileList(int count) => List.generate(count, (i) => Container(child: SchoolLogoGridView(i)));
}

class SchoolLogoGridView extends StatelessWidget {
  School? school;

  SchoolLogoGridView(int position) {
    this.school = aibtGroup!.schools[position];
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SchoolCoursesPage(school!, [])));
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Utils.getSchoolLogo(school!.name),
              )),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
