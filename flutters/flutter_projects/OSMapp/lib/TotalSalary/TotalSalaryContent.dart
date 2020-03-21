import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/SalaryModel/SiteSalary.dart';
class totalsalarycontent extends StatefulWidget {
  final uId;

  totalsalarycontent(this.uId);

  @override
  _totalsalaryState createState() => _totalsalaryState();
}

class _totalsalaryState extends State<totalsalarycontent> {
  List<SalaryDatum>salarydata = [];
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
                                  : "There Is No Any Salary Data",
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
                        itemCount: salarydata.length,
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
        title: Text("${index + 1}. " + salarydata[index].siteName),
        trailing: Card(

          // with Card
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                    "Rs.${salarydata[index].totalsal}",style: TextStyle(fontWeight: FontWeight.w500),)),
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
        ),
      ),
    );
  }

  _fetchListItem(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteTodayExpense/?id=$site";
    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    salarydata.clear();
    for (SalaryDatum datum in siteSalaryFromJson(response.body).data) {
      salarydata.add(datum);
    }

    return salarydata;
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0), child: getFirstView());
  }
}