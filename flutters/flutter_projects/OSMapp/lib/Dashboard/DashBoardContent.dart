import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/CompletedSite/CompletedSite.dart';
import 'package:osm_app/OngoingSite/OngoingSite.dart';
import 'package:osm_app/OverHeadExpenses/OverHeadExpenseCost.dart';
import 'package:osm_app/SiteExpenditure/SiteExpenditure.dart';
import 'package:osm_app/TotalAttendance/TotalAttendance.dart';
import 'package:osm_app/TotalSalary/TotalSalary.dart';

import 'package:osm_app/TransportationCost/TransportationCost.dart';
import 'package:osm_app/model_classes/AttendanceModel/Attendance_list.dart';
import 'package:osm_app/model_classes/ExpenditureModel/Expenditure_list.dart';
import 'package:osm_app/model_classes/OngoingAndCompletedModel/CompletedSite_list.dart';
import 'package:osm_app/model_classes/OverHeadExpensesModel/OverHeadExpense_list.dart';
import 'package:osm_app/model_classes/SalaryModel/Salary_list.dart';
import 'package:osm_app/model_classes/TransportationModel/TransportationCost_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/OngoingAndCompletedModel/site_list.dart';

class DashBoardContent extends StatefulWidget {
  final id,companyname;

  DashBoardContent(this.id,this.companyname);

  @override
  _DashBoardContentState createState() => _DashBoardContentState();
}

class _DashBoardContentState extends State<DashBoardContent> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 4.0;
  List<Datum> sitesName = [];
  List<CompletedDatum> compdata = [];
  List<OverHeadExpenseDatum> overheadexpdata = [];
  var datas = "0";
  var expdata = "0";
  var salarydata = "0";
  var transdata = "0";
  var overheadexpense = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAttendanceItem(widget.id);
    _fetchExpenditureItem(widget.id);
    _fetchCompletedItem(widget.id);
    _fetchSalaryItem(widget.id);
    _fetchTransportationItem(widget.id);
    _fetchOverHeadExpenseItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        mainbody()
//        getimage(),
      ],
    );
  }
  Widget mainbody(){
    return FutureBuilder(
        future: _fetchListItem(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Center(
                  child: Column(
                    children: <Widget>[
                      if (snapshot.error == null) ...[
                        CircularProgressIndicator(),
                      ],
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 40),
                        child: Center(
                          child: Text(
                            snapshot.error == null
                                ? "Please Wait ..."
                                : "Could not Load !! Please Check your Connection",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )),
            );
          } else {
            return getCard(context);
          }
        });
  }

  Widget getCard(context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 18),
          child: Card(
            color: Colors.transparent,
            elevation: 5,
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
                      padding: const EdgeInsets.only(top: 22.0,left: 8.0,right: 8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(widget.companyname,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins-bold")),
                      ),
                    ),
                  ),

                  //Total number of sites

                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  InkWell(
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(630),
                        height: ScreenUtil.getInstance().setHeight(180),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.white,
                              Colors.white,
                            ]),
                            borderRadius: BorderRadius.circular(2.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white12.withOpacity(.1),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 5.0, right: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                          (sitesName.length + compdata.length)
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 20,
                                              letterSpacing: 0.8)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, left: 5.0, right: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("Total Number of Sites",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              letterSpacing: 0.8)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Ongoing sites and Completed Sites

                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(250),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(2.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12.withOpacity(.1),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompletedSite(widget.id)),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              compdata.length.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Completed Sites",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(250),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(2.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12.withOpacity(.1),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OngoingSite(widget.id)),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              sitesName.length.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Ongoing Sites",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Total Salary and Total Attendance

                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Card(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(250),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(2.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12.withOpacity(.1),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TotalAttendance(widget.id)),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
//                                    FutureBuilder(
//                                        future: _fetchAttendanceItem(),
//                                        builder: (context, AsyncSnapshot snapshot) {
//                                          if (!snapshot.hasData) {
//                                            return Center(child: CircularProgressIndicator());
//                                          }else {
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(datas,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
//                                          }
//                                        }
//                                    ),

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Total Attendance",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(250),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(2.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12.withOpacity(.1),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TotalSalary(widget.id)),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 0.0, right: 5.0),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(" Rs." + salarydata,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Total Salary",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Transportaton Cost and Total Expenditure

                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(250),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(2.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12.withOpacity(.1),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SiteExpenditure(widget.id)),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Rs." + expdata,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Site Expenditure",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(250),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(2.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12.withOpacity(.1),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransportationCost(widget.id)),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 2, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Rs." + transdata,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5, right: 5),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text("Transportation Cost",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  letterSpacing: 0.8)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(20),
                  ),
                  //OverheadExpenses
                  InkWell(
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(630),
                        height: ScreenUtil.getInstance().setHeight(180),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.white,
                              Colors.white,
                            ]),
                            borderRadius: BorderRadius.circular(2.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white12.withOpacity(.1),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OverHeadExpenseCost(widget.id)),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 5.0, right: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                          ("Rs. $overheadexpense")
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 20,
                                              letterSpacing: 0.8)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, left: 5.0, right: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("OverHeadExpenses",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              letterSpacing: 0.8)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//  Widget getimage() {
//    return Align(
//      alignment: Alignment.topCenter,
//      child: Container(
//        width: circleRadius,
//        height: circleRadius,
//        decoration: ShapeDecoration(
//            shape: CircleBorder(),
//            gradient: LinearGradient(colors: [
//              Colors.deepOrangeAccent,
//              Colors.yellowAccent,
//            ])),
//        child: Padding(
//          padding: EdgeInsets.all(circleBorderWidth),
//          child: DecoratedBox(
//            decoration: ShapeDecoration(
//                shape: CircleBorder(),
//                image: DecorationImage(
//                    fit: BoxFit.cover,
//                    image: AssetImage(
//                      'assets/images/logos.png',
//                    ))),
//          ),
//        ),
//      ),
//    );
//  }

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
                        border: Border.all(color: Colors.black, width: 1.5),
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
                        border: Border.all(color: Colors.black, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red.withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _logoutmethod(context),
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

  _logoutmethod(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  _fetchListItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteList/?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    sitesName.clear();
    for (Datum datum in siteListFromJson(response.body).data) {
      sitesName.add(datum);
    }

    return sitesName;
  }

  _fetchAttendanceItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteAttend/?id=$site";

    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
//    print('url : ${response.body}');
    final attendanceList = attendanceListFromJson(response.body);
    setState(() {
      datas = attendanceList.data;
//      print('attendanceData : $datas');
    });

    return datas;
  }

  _fetchExpenditureItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteExpditure/?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    final explist = expenditureListFromJson(response.body);

    setState(() {
      expdata = explist.data;
    });
    return expdata;
  }

  _fetchCompletedItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteCompletedList/?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    compdata.clear();
    for (CompletedDatum datum in completedListFromJson(response.body).data) {
      compdata.add(datum);
    }

    return compdata;
  }

  _fetchSalaryItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteSalary/?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    final salarylist = salaryListFromJson(response.body);

    setState(() {
      salarydata = salarylist.data;
    });
    return salarydata;
  }

  _fetchTransportationItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteTransportCost/?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    final translist = transportationCostListFromJson(response.body);

    setState(() {
      transdata = translist.data;
    });
    return transdata;
  }

  _fetchOverHeadExpenseItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/totalOverHeadExpenses?id=$site";
    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    overheadexpdata.clear();
    for (OverHeadExpenseDatum datum in overHeadExpenseListFromJson (response.body).data) {
      setState(() {
        overheadexpense =datum.price;
      });
    }

    return overheadexpense;
  }
}
