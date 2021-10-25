import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonWidgets {
  static AppBar getAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              "images/vc_logo_landscape.svg",
              height: 40,
            ),
          )
        ],
      ),
    );
  }

  static AppBar getAppBarWhite(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              "images/vc_logo_landscape_white.svg",
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}
