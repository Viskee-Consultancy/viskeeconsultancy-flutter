// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'pages/MainPage.dart';
import 'pages/SchoolLogoPage.dart';

void main() => runApp(
  MaterialApp(
    home: MainPage(),
    routes: <String, WidgetBuilder> {
      '/main_page': (BuildContext context) => MainPage(),
      '/school_page': (BuildContext context) => SchoolLogoPage()
    }
  )
);