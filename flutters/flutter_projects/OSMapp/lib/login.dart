import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/DashBoardManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Animations/FadeAnimation.dart';
import 'Dashboard/Dashboardd.dart';
import 'Widgets/FormCard.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getStringValuesSF();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var siteid = prefs.getString('id');
    var sitemanagername = prefs.getString('firstname');
    var companyname = prefs.getString('firstname');
    if (prefs.getString('email') != null && prefs.getString('groupflag')=="SiteAdmin"){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Dashboardd(siteid,companyname)), (Route<dynamic> route) => false);
    }else if(prefs.getString('email') != null && prefs.getString('groupflag')=="SiteManager"){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DashBoardManager(siteid,sitemanagername)), (Route<dynamic> route) => false);
    }
    return prefs.getString('email');
  }


  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: WillPopScope(
        child: getmainContent(),onWillPop: onWillPop,
      ),
    );
  }
  Widget getmainContent(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FadeAnimation(
          3.0,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: ClipPath(
                  clipper: ClippingClass(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 320.0,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 25.0),
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  4.0,
                  Container(
                    width: 700.0,
                    height: 200.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logofinalosm.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                FadeAnimation(5.0, FormCard()),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      exit(0);
      return Future.value(false);
    }
    return Future.value(true);

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
