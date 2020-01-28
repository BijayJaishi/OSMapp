import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osm_app/OngoingSite/IndividualSites.dart';
import 'package:osm_app/OngoingSite/SiteTabView.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/site_list.dart';

// ignore: camel_case_types
class ongoingsitecontent extends StatefulWidget {
  @override
  _ongoingsitecontentState createState() => _ongoingsitecontentState();
}

class _ongoingsitecontentState extends State<ongoingsitecontent> {

  List<Datum> sitesName = [];

  @override
  Widget build(BuildContext context) {
    return getCard(context);
  }

  Widget getCard(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: getElementList(),
      ),
    );
  }

  Widget getFirstView(){
    return Container(
        child : FutureBuilder(
            future: _fetchListItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 6),
                        itemCount: sitesName.length,
                        itemBuilder: (BuildContext context, int position) {
                          return getRow(position);
                        }));
              }
            })
    );
  }

  Widget getRow(int index){
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.only(left : 10.0,top: 0,bottom: 0,right: 10.0),
        title: Text("${index+1}. "+ sitesName[index].siteName),
        subtitle: Text("     "+sitesName[index].location),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SiteTabView(sitesName[index].siteName)),
          );
        },
      ),
    );
  }

  _fetchListItem() async {
    String dataURL = "http://halfwaiter.com/stock/api/request/siteList/?id=21";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    sitesName.clear();
    for (Datum datum in siteListFromJson(response.body).data) {
      sitesName.add(datum);
    }

    return sitesName;
  }

  List<String> getListElement() {
    var items =
    List<String>.generate(100, (counter) => "${counter + 1}.    Site one");
    return items;
  }

  Widget getElementList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: getFirstView()
    );
  }

  void showSnackBar(BuildContext context, String item) {
    final scaffold = Scaffold.of(context);
    var snackBar = SnackBar(
      content: Text('$item was clicked'),
      action:
      SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
