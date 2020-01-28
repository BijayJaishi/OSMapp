import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/OngoingSite/BillImages.dart';
import 'package:osm_app/OngoingSite/SiteImages.dart';

class IndividualSitesContent extends StatelessWidget {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        Positioned(
////          top: 0,
//            left: 0,
//            right: 0,
//            bottom: 0,
//            child: getCard(context)),
        getCard(context),
      ],
    );
  }

  Widget getCard(context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 100),
          child: Container(
            width: double.infinity,
            //height: ScreenUtil.getInstance().setHeight(680),
            //height: MediaQuery.of(context).size.height,

            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0),
                ]),
            child: Column(
              children: <Widget>[

                //Ongoing sites and Completed Sites

                SizedBox(height: ScreenUtil.getInstance().setHeight(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(300),
                        height: ScreenUtil.getInstance().setHeight(250),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.white,
                              Colors.white,
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white12.withOpacity(.1),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SiteImages()),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:5,right:5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Site",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 20,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:2.0,left: 5,right:5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Images",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(300),
                        height: ScreenUtil.getInstance().setHeight(250),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.white,
                              Colors.white,
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white12.withOpacity(.1),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>BillImages()),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:5,right:5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Bill",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 20,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:2.0,left:5,right:5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Images",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //Total number of sites
                SizedBox(height: ScreenUtil.getInstance().setHeight(20),),
                InkWell(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(630),
                    height: ScreenUtil.getInstance().setHeight(180),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.white,
                        ]),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white12.withOpacity(.1),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Stock",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 20,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top:2,left: 5.0,right: 5.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Remaining",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:15.0,),
              ],
            ),
          ),
        ),
      ],

    );
  }

}
