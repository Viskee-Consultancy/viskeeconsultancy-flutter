import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viskeeconsultancy/models/Brochure.dart';
import 'dart:html' as html;

import 'package:viskeeconsultancy/values/CustomColors.dart';

String? groupName;
List<Brochure>? promotions;

class BrochureDownloadPage extends StatelessWidget {
  BrochureDownloadPage(String groupNameInput, List<Brochure> promotionsInput) {
    groupName = groupNameInput;
    promotions = promotionsInput;
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
                child: Text("Latest Brochures For " + groupName!,
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
        itemCount: promotions!.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(promotions!.length),
        itemBuilder: (BuildContext context, int index) {
          return new BrochureGridView(index);
        },
      );
}

class BrochureGridView extends StatelessWidget {
  late Brochure promotion;
  BrochureGridView(int position) {
    this.promotion = promotions![position];
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
      ),
      onPressed: () => html.window.open(promotion.link!, "Brochure"),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    "images/pdf.png",
                    color: Colors.black,
                  ),
                )),
            Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(promotion.name!, style: TextStyle(color: Colors.black)),
                )),
          ],
        ),
      ),
    );
  }
}
