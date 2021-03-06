import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';

class CommonWidgets {
  static AppBar getAppBar(BuildContext context, bool isRemovePath) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 40),
        onPressed: () => {Utils.onBackPressed(context, isRemovePath)},
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Text(NavigationPath.PATH.join(">"),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style: TextStyle(color: Colors.black, fontSize: 12)))),
          // new Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              "images/vc_logo_landscape.svg",
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
