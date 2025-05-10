import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viskeeconsultancy/models/Brochure.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

class BrochureDownloadPage extends StatelessWidget {
  late final String _groupName;
  late final List<Brochure> _brochures;

  BrochureDownloadPage(String groupNameInput, List<Brochure> brochuresInput) {
    _groupName = groupNameInput;
    _brochures = brochuresInput;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Utils.onBackPressed(context, false);
          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonWidgets.getAppBar(context, false),
            body: Container(
                child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, AppBar().preferredSize.height + 40, 5, 60),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Latest Brochures For: " + _groupName,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
              ),
              Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: _buildGrid(),
                  ))
            ]))));
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
  late final Brochure _brochure;

  BrochureGridView(Brochure brochure) {
    this._brochure = brochure;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(CustomColors.GOLD),
      ),
      onPressed: () => Utils.openBrochure(_brochure.name!, _brochure.link!, context),
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
                  child: Text(_brochure.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                )),
          ],
        ),
      ),
    );
  }
}
