import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osm_app/Dashboard/DashBoardContent.dart';
import 'package:osm_app/OngoingSite/OngoingSiteContent.dart';

class OngoingSite extends StatefulWidget {
  @override
  OngoingSiteState createState() => new OngoingSiteState();
}

class OngoingSiteState extends State<OngoingSite> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 4.8;
  DateTime currentBackPressTime;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
          //change your color here
        ),
        title: Text("Ongoing Sites",style:TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Poppins-bold")),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: mainContent(),
    );
  }

  Widget mainContent(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 305.0,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              width: 700.0,
              height: 150.0,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logofinalosm.png"),
                    fit: BoxFit.cover),
              ),
            ),

            ongoingsitecontent(),
          ],
        )
      ],
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
