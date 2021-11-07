import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';
import 'package:viskeeconsultancy/models/Brochure.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

class BrochureDownloadPage extends StatelessWidget {
  late String _groupName;
  late List<Brochure> _brochures;

  BrochureDownloadPage(String groupNameInput, List<Brochure> brochuresInput) {
    _groupName = groupNameInput;
    _brochures = brochuresInput;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CommonWidgets.getAppBar(context, false),
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
                child: Text("Latest Brochures For " + _groupName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
          ),
          Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildGrid(),
              ))
        ])));
  }

  Widget _buildGrid() => new StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 30,
        crossAxisSpacing: 0,
        itemCount: _brochures.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(_brochures.length),
        itemBuilder: (BuildContext context, int index) {
          return new BrochureGridView(_brochures[index]);
        },
      );
}

class BrochureGridView extends StatelessWidget {
  late Brochure _brochure;

  BrochureGridView(Brochure brochure) {
    this._brochure = brochure;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
      ),
      onPressed: () => launchURL(_brochure.link!),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.description_outlined,
                    color: Colors.black,
                  ),
                )),
            Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(_brochure.name!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15)),
                )),
          ],
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
