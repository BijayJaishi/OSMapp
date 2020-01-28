import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/OngoingSite/stockRemainingContent.dart';
import 'package:osm_app/SiteExpenditure/SiteExpenditureContent.dart';

class stockRemaining extends StatefulWidget {
  @override
  _stockRemainingState createState() => _stockRemainingState();
}

class _stockRemainingState extends State<stockRemaining> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: mainContent());
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

//        Positioned(
//          bottom: 500,
//          left: 0,
//          right: 0,
//          top: 0,
//          child: getlistTitle(),
//        ),
//
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: stockremainingcontent(),
        )
      ],
    );
  }
  Widget getlistTitle(){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
        ),
//        clipBehavior: Clip.antiAlias,
        elevation: 2,

        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: new Text("Material Name",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(right:20.0),
                child: new Text("Remaining Amount",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ]
        ),
      ),
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

