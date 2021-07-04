import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'dart:html' as html;

Course? course;

class CourseDetailPage extends StatelessWidget {
  CourseDetailPage(Course input) {
    course = input;
  }

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      course = ModalRoute.of(context)!.settings.arguments as Course;
    }
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
              Align(
                  alignment: Alignment.center,
                  child: Text(course!.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: CustomColors.GOLD))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "VET National Code:" + course!.vetCode!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "CRICOS Course Code:" + course!.cricosCode!,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ))),
              Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Image.asset(
                                        "images/clock.png",
                                        color: CustomColors.GOLD,
                                      ),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Total Duration",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        course!.duration!.toString() + "Weeks",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        course!.durationDetail!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                              ],
                            )),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Image.asset(
                                      "images/location.png",
                                      color: CustomColors.GOLD,
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      course!.location.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Image.asset(
                                      "images/pricing.png",
                                      color: CustomColors.GOLD,
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Pricing",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Tuition Fee - OnShore Student Visa Holder: \$" +
                                          course!.onshoreTuition!.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Tuition Fee - OffShore Int Student: \$" +
                                          course!.offshoreTuition!.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        CustomColors.GOLD),
                              ),
                              child: Text("Terms and Conditions"),
                              onPressed: () {
                                html.window.open(
                                    "https://aibtglobal.edu.au/courses/terms-for-courses/",
                                    "Terms and Conditions");
                              }),
                        )
                      ],
                    ),
                  )),
            ])));
  }
}
