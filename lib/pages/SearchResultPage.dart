// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/SearchResult.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';

// void main() => runApp(SearchResultPage());

SearchResult? searchResult;
class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    searchResult = ModalRoute.of(context)!.settings.arguments as SearchResult;
    return Scaffold(
      body: Text("ssssssssssssssss"),
    );
    // return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     appBar: AppBar(
    //       leading: IconButton(
    //         icon: Icon(Icons.arrow_back, color: Colors.black),
    //         onPressed: () => Navigator.of(context).pop(),
    //       ),
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //       title: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Align(
    //             alignment: Alignment.centerRight,
    //             child: Image.asset(
    //               "images/vc_logo_landscape.png",
    //               fit: BoxFit.contain,
    //               height: 40,
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //     body: Container(
    //         decoration: BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage("images/background.jpg"),
    //                 fit: BoxFit.cover)),
    //         child: Column(children: [
    //           Expanded(
    //               flex: 1,
    //               child: Container(
    //                 child: null,
    //               )),
    //           Expanded(
    //             flex: 1,
    //             child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text("Search Results For ",
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 30.0,
    //                         color: CustomColors.GOLD))),
    //           ),
    //           Expanded(
    //               flex: 1,
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: ToggleButtons(
    //                   children: [
    //                     Text("AIBT"),
    //                     Text("REACH")
    //                   ],
    //                   isSelected: [],
    //                   ),
    //               ))
    //         ])));
  }
}
