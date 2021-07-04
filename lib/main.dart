// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'models/SearchResult.dart';
import 'pages/MainPage.dart';
import 'pages/SchoolLogoPage.dart';
import 'pages/BrochureDownloadPage.dart';
import 'pages/CourseDetailPage.dart';
import 'pages/SchoolCoursesPage.dart';
import 'pages/SearchResultPage.dart';

void main() => runApp(
  MaterialApp(
    home: MainPage(),
    routes: <String, WidgetBuilder> {
      // '/brochure_download_page': (BuildContext context) => BrochureDownloadPage(),
      // '/course_detail_page': (BuildContext context) => CourseDetailPage(),
      '/main_page': (BuildContext context) => MainPage(),
      // '/school_courses_page': (BuildContext context) => SchoolCoursesPage(),
      // '/search_result_page': (BuildContext context) => SearchResultPage(SearchResult searchResult),
      '/school_logo_page': (BuildContext context) => SchoolLogoPage(),
    }
  )
);
