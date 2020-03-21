import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';
import 'package:osm_app/SiteManagerModels/ManagerSiteList.dart';
import 'package:http/http.dart' as http;
import 'DashBoardManager.dart';
import 'FormCardSitePhoto.dart';

class SitePhoto extends StatefulWidget with NavigationStates {
  final id,name,sitename,siteId;

  SitePhoto(this.id,this.name,this.sitename,this.siteId);

  @override
  _SitePhotoState createState() => _SitePhotoState();
}

class _SitePhotoState extends State<SitePhoto> {

  List<ManagerSite> managersitename = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchSiteListItem(widget.id);
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    Fluttertoast.showToast(
      msg: "Press Dashboard Button At Top Right",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.deepOrangeAccent,
      timeInSecForIos: 1,
      textColor: Colors.white,
    ); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return mainView();
  }


  Widget mainView() {
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
          child: getbody(),

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
                                      Sitemain(widget.id, widget.name,widget.sitename,widget.siteId)),
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

  Widget getbody() {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: <Widget>[
            FormCardSite(widget.id,widget.name,widget.sitename,widget.siteId),
          ],
        ),
      ),
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