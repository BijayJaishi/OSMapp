import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/DashBoardManagerContent.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';

class DashBoardManager extends StatefulWidget with NavigationStates{
  final id,name;

  DashBoardManager(this.id,this.name);

  @override
  _DashBoardManagerState createState() => _DashBoardManagerState();
}

class _DashBoardManagerState extends State<DashBoardManager> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 4.8;
  DateTime currentBackPressTime;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> getscroolView() async{

    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));


    setState(() {
      getScrolview();
    });

    return null;

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: WillPopScope(
        child: mainContent(),
        onWillPop: onWillPop,
      ),
    );
  }

  Widget mainContent() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 300,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: ClipPath(
              clipper: ClippingClass(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
        ),
        NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: Colors.deepOrangeAccent,
                elevation: 0.0,
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  //change your color here
                ),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  centerTitle: true,
                  background: Center(
                    child: Container(
                      height: 800,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 9),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logofinalosm.png'),
                        ),
                      ),
                    ),
                  ),
                  title: new Text("DashBoard",
                      style: TextStyle(
                        color: Colors.black,
//                          fontWeight: FontWeight.bold,
//                        fontFamily: "Poppins-Bold"
                      )),
                ),
              ),
            ];
          },
          body:getScrolview()
        ),
      ],
    );
  }

  Widget getScrolview() {
     return DashboardManagerContent(widget.id,widget.name);

//    return CustomScrollView(
//      slivers: <Widget>[
//        SliverToBoxAdapter(
//          child: Container(height:MediaQuery.of(context).size.height,child: DashboardManagerContent(widget.id,widget.name)),
//        )
//      ],
//    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press Again To Exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.deepOrangeAccent,
        timeInSecForIos: 1,
        textColor: Colors.white,
      );
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

