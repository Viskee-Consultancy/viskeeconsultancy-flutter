// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viskeeconsultancy/pages/OnshoreOffshorePage.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/background.png"), context);
    return MaterialApp(
      title: StringConstants.APP_NAME,
      theme: ThemeData(fontFamily: 'DM'),
      home: OnshoreOffshorePage(),
    );
  }
}
