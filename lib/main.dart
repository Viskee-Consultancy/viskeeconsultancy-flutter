// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/pages/OnshoreOffshorePage.dart';

void main() => runApp(MaterialApp(
        theme: ThemeData(fontFamily: 'DM'),
        home: OnshoreOffshorePage(),
        routes: <String, WidgetBuilder>{
          '/main_page': (BuildContext context) => OnshoreOffshorePage(),
        }));
