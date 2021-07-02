// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/Promotion.dart';
import 'dart:html' as html;

import 'package:viskeeconsultancy/values/CustomColors.dart';

void main() => runApp(BrochureDownloadPage());

Group? group;

class BrochureDownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    group = ModalRoute.of(context)!.settings.arguments as Group;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
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
                    child: Text("Latest Brochures For " + group!.name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: CustomColors.GOLD))),
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
        crossAxisCount: group!.promotions.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 30,
        crossAxisSpacing: 0,
        itemCount: group!.promotions.length,
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(group!.promotions.length),
        itemBuilder: (BuildContext context, int index) {
          return new PromotionGridView(index);
        },
      );
}

class PromotionGridView extends StatelessWidget {
  late Promotion promotion;
  PromotionGridView(int position) {
    this.promotion = group!.promotions[position];
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
                    color: Colors.white,
                  ),
                )),
            Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(promotion.name!),
                )),
          ],
        ),
      ),
    );
  }
}
