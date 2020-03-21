import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/SiteManager/sidebar/SidebarItems/menu_item.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';

import 'DashBoardManager.dart';

class InternalDashBoard extends StatefulWidget with NavigationStates{

  final id,name,sitename,siteId;

  InternalDashBoard(this.id,this.name,this.sitename,this.siteId);
  @override
  _InternalDashBoardState createState() => _InternalDashBoardState();
}

class _InternalDashBoardState extends State<InternalDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 24.3,
          left: 0,
          right: 0,
          bottom: 0,
          child: getInitialRow(),
        ),
        Positioned(
          top: 145,
          left: 0,
          right: 0,
          bottom: 0,
          child: mainbody(),

        )
      ],
    );
  }

  Widget getInitialRow() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 122,
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(0.0),
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:50.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 160,
                      height: 60,
                      child: Card(
                        child: Center(child: Text(widget.sitename,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.deepOrangeAccent,
                        child: IconButton(
                          splashColor: Colors.blue,
                          icon: Icon(
                            Icons.dashboard,
                            size: 28,
                            color: Colors.black,
                          ),
                          tooltip: "DashBoard",
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DashBoardManager(widget.id, widget.name)),
                            );
                          },
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget mainbody() {
    return SingleChildScrollView(
      child: Wrap(
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 22.0,left: 8.0,right: 8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(widget.name,
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
                          height: ScreenUtil.getInstance().setHeight(210),
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

                                BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigationEvents.TransportationClickedEvent);
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
                                      child: Image.asset(
                                        "assets/images/transportationcost.png"
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

                    //SitePhoto and Bill Photo

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
                                    BlocProvider.of<NavigationBloc>(context)
                                        .add(NavigationEvents.SitePhotoClickedEvent);
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
                                          child: Image.asset(
                                              'assets/images/sitephoto.png'
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
                                            child: Text("Site Photo",
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

                                    BlocProvider.of<NavigationBloc>(context)
                                        .add(NavigationEvents.BillPhotoClickedEvent);
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
                                          child: Image.asset(
                                              'assets/images/bill.png'
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
                                            child: Text("Bill Photo",
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

                    // Attendance and Stock

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
                                    BlocProvider.of<NavigationBloc>(context)
                                        .add(NavigationEvents.AttendanceClickedEvent);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Image.asset('assets/images/attendance.png'),
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
                                            child: Text("Attendance",
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
                                    BlocProvider.of<NavigationBloc>(context)
                                        .add(NavigationEvents.StockClickedEvent);
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
                                          child: Image.asset('assets/images/stock.png'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 5, right: 5),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("Stock",
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
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
 }
}
