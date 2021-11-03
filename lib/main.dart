// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viskeeconsultancy/pages/OnshoreOffshorePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/background.png"), context);
    // return FutureBuilder(
      // future: Init.instance.initialize(),
      // builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const MaterialApp(home: Splash());
        // } else {
          // Loading is done, return the app:
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              // primarySwatch: Colors.,
                fontFamily: 'DM'
            ),
            home: OnshoreOffshorePage(),
          );
        // }
      // },
    // );
  }
}

// class Splash extends StatelessWidget {
//   const Splash({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool lightMode =
//         MediaQuery.of(context).platformBrightness == Brightness.light;
//     return Scaffold(
//       backgroundColor:
//       lightMode ? const Color(0xffffffff) : const Color(0xff000000),
//       body: Center(
//           child: lightMode
//               ? Image.asset('images/vc_logo_landscape.png')
//               : Image.asset('images/vc_logo_landscape_white.png')),
//     );
//   }
// }
//
// class Init {
//   Init._();
//   static final instance = Init._();
//
//   Future initialize() async {
//     // This is where you can initialize the resources needed by your app while
//     // the splash screen is displayed.  Remove the following example because
//     // delaying the user experience is a bad design practice!
//     await Future.delayed(const Duration(seconds: 2));
//   }
// }

// void main() => runApp(MaterialApp(
//         theme: ThemeData(fontFamily: 'DM'),
//         home: OnshoreOffshorePage(),
//         routes: <String, WidgetBuilder>{
//           '/main_page': (BuildContext context) => OnshoreOffshorePage(),
//         }));
