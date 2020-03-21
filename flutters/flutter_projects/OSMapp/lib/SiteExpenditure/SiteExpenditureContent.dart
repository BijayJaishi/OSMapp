import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osm_app/model_classes/ExpenditureModel/SiteExpenditure.dart';
import 'package:http/http.dart' as http;

class siteexpenditurecontent extends StatefulWidget {
  final uId;


  siteexpenditurecontent(this.uId);

  @override
  _siteexpenditureState createState() => _siteexpenditureState();
}

class _siteexpenditureState extends State<siteexpenditurecontent> {
  List<ExpenditureDatum>expdata = [];

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

  Widget getFirstView() {
    return Container(
        child: FutureBuilder(
            future: _fetchListItem(widget.uId),
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
                                  : "There Is No Any Expenditure till now",
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
                        itemCount: expdata.length,
                        itemBuilder: (BuildContext context, int position) {
                          return getRow(position);
                        }));
              }
            }));
  }

  Widget getRow(int index) {
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      child: ListTile(
        contentPadding:
        EdgeInsets.only(left: 10.0, top: 0, bottom: 0, right: 10.0),
        title: Text("${index + 1}. " + expdata[index].siteName),
        trailing: Card(

          // with Card
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  "Rs.${expdata[index].totalcost}",style: TextStyle(fontWeight: FontWeight.w500),)),
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
        ),
      ),
    );
  }

  _fetchListItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteTodayBillExp/?id=$site";
    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    expdata.clear();
    for (ExpenditureDatum datum in siteExpenditureFromJson(response.body).data) {
      expdata.add(datum);
    }

    return expdata;
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0), child: getFirstView());
  }
}