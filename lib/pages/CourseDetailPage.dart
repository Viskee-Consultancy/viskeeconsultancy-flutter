// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(CourseDetailPage());


class CourseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        home: Scaffold(
            // appBar: AppBar(
            //   title: Text('Flutter layout demo'),
            // ),
            body: Text("Course Detail Page")));
  }
}
