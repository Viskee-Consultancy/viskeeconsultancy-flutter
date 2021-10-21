import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

import 'CoeSelectionPage.dart';
import 'RegionSelectionPage.dart';

class OnshoreOffshorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
              child: Text("Are you onshore or offshore ?",
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
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(CustomColors.GOLD),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("ONSHORE",
                              style: TextStyle(color: Colors.black))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CoeSelectionPage()));
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(CustomColors.GOLD),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("OFFSHORE",
                              style: TextStyle(color: Colors.black))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegionSelectionPage()));
                      }),
                ))),
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
      ])),
    );
  }
}
