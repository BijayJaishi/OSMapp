import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/CompletedSite/CompletedSite.dart';
import 'package:osm_app/OngoingSite/OngoingSite.dart';
import 'package:osm_app/SiteExpenditure/SiteExpenditure.dart';
import 'package:osm_app/TotalAttendance/TotalAttendance.dart';
import 'package:osm_app/TotalSalary/TotalSalary.dart';
import 'package:osm_app/TransportationCost/TransportationCost.dart';
import 'package:osm_app/main.dart';

class DashBoardContent extends StatelessWidget {
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
        getimage(),
      ],
    );
  }

  Widget getCard(context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 50),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(180),
                        height: ScreenUtil.getInstance().setHeight(50),
                        decoration: BoxDecoration(

                            gradient: LinearGradient(colors: [
                              Colors.orange,
                              Colors.deepOrangeAccent,
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(.3),
                                  offset: Offset(5.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialogAlert(context);
                            },
                            child: Center(
                              child: Text("LogOut",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 12,
                                      letterSpacing: 1.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top:22.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("K and K Technology",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins-bold")),
                    ),
                  ),
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
                                  child: Text("16",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 30,
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
                                  child: Text("Total Number of Sites",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 16,
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
                                MaterialPageRoute(builder: (context) => CompletedSite()),
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
                                      child: Text("8",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 30,
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
                                      child: Text("Completed Sites",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
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
                                MaterialPageRoute(builder: (context) => OngoingSite()),
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
                                      child: Text("8",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 30,
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
                                      child: Text("Ongoing Sites",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
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

                // Total Salary and Total Attendance

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
                                MaterialPageRoute(builder: (context) => TotalAttendance()),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("42",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 30,
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
                                      child: Text("Total Attendance",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
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
                                MaterialPageRoute(builder: (context) => TotalSalary()),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(" Rs 500000",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 30,
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
                                      child: Text("Total Salary",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
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


                // Transportaton Cost and Total Expenditure

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
                                MaterialPageRoute(builder: (context) => SiteExpenditure()),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Rs 78000000",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 30,
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
                                      child: Text("Site Expenditure",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
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
                                MaterialPageRoute(builder: (context) => TransportationCost()),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Rs 2000000",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 30,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:2.0,left: 5,right:5),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text("Transportation Cost",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
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
                SizedBox(height:10,),


              ],
            ),
          ),
        ),
      ],

    );
  }

  Widget getimage() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: circleRadius,
        height: circleRadius,
        decoration: ShapeDecoration(
            shape: CircleBorder(),
            gradient: LinearGradient(colors: [
              Colors.deepOrangeAccent,
              Colors.yellowAccent,
            ])),
        child: Padding(
          padding: EdgeInsets.all(circleBorderWidth),
          child: DecoratedBox(
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/logos.png',
                    ))),
          ),
        ),
      ),
    );
  }

  showDialogAlert(context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to logout'),
            actions: <Widget>[
              FlatButton(
                splashColor: Colors.teal,
                child: InkWell(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(120),
                    height: ScreenUtil.getInstance().setHeight(50),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.orange,
                          Colors.deepOrangeAccent,
                        ]),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Colors.black,width: 1.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red.withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Center(
                          child: Text("No",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 12,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                splashColor: Colors.teal,
                child: InkWell(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(120),
                    height: ScreenUtil.getInstance().setHeight(50),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.orange,
                          Colors.deepOrangeAccent,
                        ]),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Colors.black,width: 1.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red.withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        ),
                        child: Center(
                          child: Text("Yes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 12,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                /*Navigator.of(context).pop(true)*/
              ),
            ],
          ),
        ) ??
        false;
  }
}
