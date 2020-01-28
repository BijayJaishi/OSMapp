import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'IndividualSiteContent.dart';
class IndividualSites extends StatefulWidget {
  @override
  IndividualSitesState createState() => new IndividualSitesState();
}

class IndividualSitesState extends State<IndividualSites> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: mainContent(),
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
          bottom: 275,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
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
                expandedHeight: 230.0,
                floating: false,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  centerTitle: true,
                  background: Center(
                    child: Container(
                      height: 800,
                      width: 500,
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
                  title: new Text("Site One",
                      style: TextStyle(
                        color: Colors.black,
//                          fontWeight: FontWeight.bold,
//                        fontFamily: "Poppins-Bold"
                      )),
                ),
              ),
            ];
          },
          body: getScrolview(),
        ),
      ],
    );
  }

  Widget getScrolview() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                IndividualSitesContent(),
              ],
            ),
          ),
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
