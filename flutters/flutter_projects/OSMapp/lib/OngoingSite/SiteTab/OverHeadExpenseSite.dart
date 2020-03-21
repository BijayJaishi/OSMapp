import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:osm_app/model_classes/TabViewModels/OverHeadExpensePerSite_list.dart';
import 'package:osm_app/model_classes/TabViewModels/Stock_list.dart';

class OverHeadExpenseSite extends StatefulWidget {
  final siteId;

  OverHeadExpenseSite(this.siteId);

  @override
  _OverHeadExpenseSiteState createState() => _OverHeadExpenseSiteState();
}

class _OverHeadExpenseSiteState extends State<OverHeadExpenseSite> {
  List<OverHeadCostDatum> dataList = [];
  List<Expense> expenseList = [];
//  List<DateModelClass> dataList = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildMainContent(),
    );
  }

  _buildMainContent() {
    return Container(
        child: FutureBuilder(
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
                                : "There Is No Any OverHead Expense data",
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
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return _buildListItem(dataList[index].expenses,index);
                        },
                        childCount: dataList.length,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget _buildListItem(List<Expense> expense,int index) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Align(
            alignment: Alignment.center,

            child: Text(DateFormat('yyyy-MM-dd').format(dataList[index].payDate),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
//            child: Text(
//              '2076/10/26',
//              style: Theme.of(context).textTheme.body2,
//            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 8.0),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Expense Type :  " + expense[index].expName,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Price :  " +
                            expense[index].price.toString(),
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: expense.length,
          shrinkWrap: true,
          // todo comment this out and check the result
          physics:
          ClampingScrollPhysics(), // todo comment this out and check the result
        ),
      ],
    );
  }

  _fetchListItem(site) async {
    String dataURL = "https://onlinesitemanager.com/adminpanel/api/request/overHeadExpenses?id=$site";
    http.Response response = await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    dataList.clear();
    expenseList.clear();
    for (OverHeadCostDatum datum in overHeadExpensePerSiteListFromJson (response.body).data) {
      dataList.add(datum);
      dataList = new List.from(dataList.reversed);
    }
    return dataList;
  }
}
