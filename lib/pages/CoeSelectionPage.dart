import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/Widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/ConfigurationDownloadPage.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

class CoeSelectionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonWidgets.getAppBar(context),
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
              child: Text("Do you have Confirmation of Enrollment ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
        ),
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
                          padding: EdgeInsets.all(15), child: Text("COE", style: TextStyle(color: Colors.black))),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ConfigurationDownloadPage(SubFolderEnum.COE)));
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
                          padding: EdgeInsets.all(15), child: Text("NON-COE", style: TextStyle(color: Colors.black))),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ConfigurationDownloadPage(SubFolderEnum.NON_COE)));
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
