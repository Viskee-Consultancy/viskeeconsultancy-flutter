import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

import 'CoeSelectionPage.dart';
import 'RegionSelectionPage.dart';

class OnshoreOffshorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: StringConstants.APP_NAME,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    "images/vc_logo_landscape.svg",
                    height: 50,
                  ),
                )
              ],
            ),
          ),
          body: Container(
              child: Column(children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: null,
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Are you currently onshore or offshore?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
                )),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text("ONSHORE",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                          onPressed: () {
                            NavigationPath.PATH.add("Onshore");
                            Navigator.push(context,
                                PageTransition(child: CoeSelectionPage(), type: PageTransitionType.topToBottom));
                          }),
                    ))),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text("OFFSHORE",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                          onPressed: () {
                            NavigationPath.PATH.add("Offshore");
                            Navigator.push(context,
                                PageTransition(child: RegionSelectionPage(), type: PageTransitionType.topToBottom));
                          }),
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                  child: null,
                )),
          ])),
        ));
  }
}
