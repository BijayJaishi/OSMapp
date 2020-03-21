import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osm_app/OngoingSite/SiteTab/SiteTabView.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/OngoingAndCompletedModel/site_list.dart';

// ignore: camel_case_types
class ongoingsitecontent extends StatefulWidget {
  final id;

  ongoingsitecontent(this.id);

  @override
  _ongoingsitecontentState createState() => _ongoingsitecontentState();
}

class _ongoingsitecontentState extends State<ongoingsitecontent> {

  List<Datum> sitesName = [];
  int _selectedIndex ;


  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SiteTabView(sitesName[index].siteName,sitesName[index].siteId)),
    );
  }

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
            future: _fetchListItem(widget.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          if (snapshot.error == null) ...[
                            CircularProgressIndicator(),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              snapshot.error == null
                                  ? "Please Wait ..."
                                  : "There Is No Any Ongoing Site",
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

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      color: _selectedIndex != null && _selectedIndex == index
          ? Colors.lightBlueAccent
          : Colors.white70,
      child: ListTile(
        contentPadding: EdgeInsets.only(left : 10.0,top: 0,bottom: 0,right: 10.0),
        title: Text("${index+1}. "+ sitesName[index].siteName),
        subtitle: Text("     "+sitesName[index].location),
        onTap: () {
          
          _onSelected(index);
        },
      ),
    );
  }

  _fetchListItem(site) async {
//    print("id:"+site);
    String dataURL = "https://onlinesitemanager.com/adminpanel/api/request/siteList/?id=$site";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    sitesName.clear();
    for (Datum datum in siteListFromJson(response.body).data) {
      sitesName.add(datum);
    }
    return sitesName;
  }

  Widget getElementList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: getFirstView()
    );
  }
}
