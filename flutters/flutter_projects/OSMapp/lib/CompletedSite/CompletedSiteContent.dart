import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/OngoingAndCompletedModel/CompletedSite_list.dart';

class completedsitecontent extends StatefulWidget {
  final siteId;

  completedsitecontent(this.siteId);

  @override
  _completedsitecontentState createState() => _completedsitecontentState();
}

class _completedsitecontentState extends State<completedsitecontent> {
  List<CompletedDatum>compNames = [];
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
            future: _fetchListItem(widget.siteId),
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
                                  : "There Is No Any Completed Site",
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
                        itemCount: compNames.length,
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
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.only(left : 10.0,top: 0,bottom: 0,right: 10.0),
        title: Text("${index+1}. "+ compNames[index].siteName),
        subtitle: Text("     "+compNames[index].location),
      ),
    );
  }

  _fetchListItem(site) async {
//    print("id:"+site);
    String dataURL = "https://onlinesitemanager.com/adminpanel/api/request/siteCompletedList/?id=$site";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    compNames.clear();
    for (CompletedDatum datum in completedListFromJson(response.body).data) {
      compNames.add(datum);
    }
    return compNames;
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: getFirstView()
    );
  }
}
