import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/ConfigurationDownloadPage.dart';
import 'package:viskeeconsultancy/pages/MainPage.dart';
import 'dart:html' as html;

import 'package:viskeeconsultancy/values/CustomColors.dart';

class RegionSelectionPage extends StatelessWidget {
  RegionSelectionPage() {}
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
              child: Text("Do you have confirmation of enrollment ?",
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
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.GOLD),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("SISMIC",
                          style: TextStyle(color: Colors.black))),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyAppOne(SubFolderEnum.SISMIC)));
                  }),
            )),
        Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.GOLD),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("SEAPAE",
                          style: TextStyle(color: Colors.black))),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyAppOne(SubFolderEnum.SEAPAE)));
                  }),
            )),
        Expanded(
            flex: 1,
            child: Container(
              child: null,
            )),
      ])),
    );
  }
}
