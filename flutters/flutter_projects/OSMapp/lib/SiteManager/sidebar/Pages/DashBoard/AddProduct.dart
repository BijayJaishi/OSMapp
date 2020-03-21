
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/DashBoardManager.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/FormCardProduct.dart';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';
import 'package:osm_app/SiteManagerModels/ManagerSiteList.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget with NavigationStates {
  final id, name, sitename, siteId;

  AddProduct(this.id, this.name, this.sitename, this.siteId);

  @override
  _AddProductState createState() => _AddProductState();
}

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class SiteList {
  SiteList(this.name, this.id);

  final String name;
  final String id;
}


class _AddProductState extends State<AddProduct> {
  DateTime currentBackPressTime;

  List<SiteList> list = [];

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> getscroolView() async{

    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));


    setState(() {
      getbody();
    });

    return null;

  }



  @override
  void initState() {

    _fetchSiteListItem(widget.id);
    super.initState();
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
    return RefreshIndicator(child: mainView(),onRefresh:getscroolView,);

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
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 160,
                      height: 60,
                      child: Card(
                        child: Center(
                            child: Text(widget.sitename,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
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
            FormCardProduct(
                widget.id, widget.name, widget.sitename, widget.siteId),
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
//     print(response.body);

    list.clear();
    for (ManagerSite datum in managerSitelistFromJson(response.body).data) {
      list.add(SiteList(datum.siteName, datum.siteId));
    }
    return list;
  }
}
