import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:viskeeconsultancy/models/Group.dart';

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../values/CustomColors.dart';

class MainPage extends StatelessWidget {
  Group? aibt;
  Group? reach;
  Future<void> readJson() async {
    final String aibtJsonString =
        await rootBundle.loadString('assets/AIBT.json');
    final String reachJsonString =
        await rootBundle.loadString('assets/REACH.json');
    final aibtData = await json.decode(aibtJsonString);
    final reachData = await json.decode(reachJsonString);
    aibt = Group.fromJson(aibtData);
    reach = Group.fromJson(reachData);
    print(aibt);
    print(reach);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Flutter layout demo'),
        // ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background_portrait.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset("images/vc_logo_landscape.png"),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(child: null),
                ),
                Expanded(
                  flex: 6,
                  child: Text("Explore Over 90+ Courses and Promotions",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 40.0, color: CustomColors.GOLD)),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(8)),
                            ),
                            child: AutocompleteBasicExample()))),
                Expanded(
                  flex: 2,
                  child: Container(child: null),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(flex: 2, child: Container(child: null)),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(8)),
                                  ),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.grey),
                                      ),
                                      child: Image.asset(
                                          "images/aibt_portrait.png"),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed("/school_logo_page", arguments: aibt);
                                      }))),
                          Expanded(flex: 2, child: Container(child: null)),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(8)),
                                  ),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.grey),
                                      ),
                                      child: Image.asset(
                                          "images/reach_portrait.png"),
                                      onPressed: () {
                                        readJson();
                                        // Navigator.of(context)
                                        //     .pushNamed("/school_courses_page");
                                      }))),
                          Expanded(flex: 2, child: Container(child: null))
                        ]))
              ],
            )),
      ),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
    );
  }
}
