import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';
import 'package:osm_app/SiteManagerModels/ManagerSiteList.dart';
import 'package:osm_app/model_classes/AttendanceModel/Attendance_list.dart';
import 'package:osm_app/model_classes/ExpenditureModel/Expenditure_list.dart';
import 'package:osm_app/model_classes/OngoingAndCompletedModel/CompletedSite_list.dart';
import 'package:osm_app/model_classes/SalaryModel/Salary_list.dart';
import 'package:osm_app/model_classes/TransportationModel/TransportationCost_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../login.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/OngoingAndCompletedModel/site_list.dart';

class DashboardManagerContent extends StatefulWidget {
  final id,name;
  DashboardManagerContent(this.id,this.name);

  @override
  _DashboardManagerContentState createState() =>
      _DashboardManagerContentState();
}

class _DashboardManagerContentState extends State<DashboardManagerContent> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 4.0;
  List<ManagerSite> managersitename = [];
  List<CompletedDatum> compdata = [];
  var datas = "0";
  var expdata = "0";
  var salarydata = "0";
  var transdata = "0";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          child: getCard(context),
        ),
        Positioned(
            top: 150,
            left: 0,
            bottom: 0,
            right: 0,
            child:mainbody()),
      ],
    );
  }

  Widget mainbody(){
    return FutureBuilder(
        future: _fetchSiteListItem(widget.id),
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
                        child: Text(
                          snapshot.error == null
                              ? "Please Wait ..."
                              : "Could not Load !! Please Check your Connection.Restart your App",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
            );
          } else {
            return getStaggeredView(context);
          }
        });
  }

  Widget getStaggeredView(context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top:0,
          left: 0,
          right: 0,
          bottom:0,
          child:Card(
            margin: EdgeInsets.all(0.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: managersitename.length,
              itemBuilder: (BuildContext context, int index) =>
                  getStaggeredDesign(context, index),
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 3),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        )
      ],

    );
//    return Wrap(
//      children: <Widget>[
////        getCard(context),
//        Card(
//            margin: EdgeInsets.all(0.0),
//            color: Colors.white,
//            elevation: 5,
//            child: Container(
//              margin: EdgeInsets.all(0.0),
//              width: double.infinity,
////              height: ScreenUtil.getInstance().setHeight(250),
//              height: MediaQuery.of(context).size.height,
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(8.0),
//                  boxShadow: [
//                    BoxShadow(
//                        color: Colors.black12,
//                        offset: Offset(0.0, 15.0),
//                        blurRadius: 15.0),
//                    BoxShadow(
//                        color: Colors.black12,
//                        offset: Offset(0.0, -10.0),
//                        blurRadius: 10.0),
//                  ]),
//                 child: StaggeredGridView.countBuilder(
//                    crossAxisCount: 4,
//                    itemCount: managersitename.length,
//                    itemBuilder: (BuildContext context, int index) =>
//                        getStaggeredDesign(context, index),
//                    staggeredTileBuilder: (int index) =>
//                    new StaggeredTile.count(2, index.isEven ? 2 : 3),
//                    mainAxisSpacing: 4.0,
//                    crossAxisSpacing: 4.0,
//                  ),
//
//              )),
//      ],
//
//    );


  }

  Widget getStaggeredDesign(BuildContext context, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sitemain(widget.id,widget.name,managersitename[index].siteName,managersitename[index].siteId)),
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 5.0,
          child: new Stack(
            children: <Widget>[
              Positioned(
                  bottom: 60,
                  top: 0,
                  right: 0,
                  left: 0,
                  child: getImageContent(index)),
              Positioned(bottom: 0, right: 0, left: 0, child: getCaptionContent(index))
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageContent(int index) {
    return GestureDetector(

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sitemain(widget.id,widget.name,managersitename[index].siteName,managersitename[index].siteId)),
          );
        },
        child: Container(
          child:Ink.image(
              fit: BoxFit.contain,
              image: managersitename[index].imgName != null ? NetworkImage("https://onlinesitemanager.com/adminpanel/assets/uploads/site_image/"+managersitename[index].imgName) : AssetImage("assets/images/consimgone.jpg")),
//              image: AssetImage("assets/images/consimgone.jpg")),
        ),
      ),
    );
  }

  Widget getCaptionContent(int index) {
    return Container(
      height: 50,
      child: Column(
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: new Text(
                  managersitename[index].siteName,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto-Regular"),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 1.5, top: 1.0),
                child: new Text(managersitename[index].location,
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 11)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCard(context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 0.0,
            right: 0.0,
          ),
          child: Card(
            color: Colors.transparent,
            elevation: 5,
            child: Container(
              width: double.infinity,
//              height: ScreenUtil.getInstance().setHeight(250),
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
                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("Welcome !!!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins-bold")),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Select a Site",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins-bold")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

  _fetchSiteListItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/sitesListManager?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
   // print(response.body);
    managersitename.clear();
    for (ManagerSite datum in managerSitelistFromJson(response.body).data) {
      managersitename.add(datum);
    }


    return managersitename;
  }
}
