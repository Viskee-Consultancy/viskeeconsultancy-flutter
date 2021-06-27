import 'package:flutter/material.dart';

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'SchoolLogoPage.dart';

class MainPage extends StatelessWidget {
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
              flex: 3,
              child: Text(
                "Explore Over 90+ Courses and Promotions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.yellow
                  )
                ),
            ),
            Expanded(
              flex: 6,
              child: AutocompleteBasicExample()
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child:Container(child: null)
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.all(const Radius.circular(8)),
                      ),
                      child: ElevatedButton(
                        child: Image.asset("images/aibt_portrait.png"),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/school_page");
                        }
                      )
                    )
                  ),
                  Expanded(
                    flex: 2,
                    child:Container(child: null)
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.all(const Radius.circular(8)),
                      ),
                      child: Expanded(child: Image.asset("images/reach_portrait.png"))
                    )
                  ),
                  Expanded(
                    flex: 2,
                    child:Container(child: null)
                  )
                ]
              )
            )
          ],
        )
      ),
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


