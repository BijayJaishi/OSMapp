import 'package:flutter/material.dart';
import 'package:osm_app/SiteManagerModels/SupplierListModel.dart';
import 'package:http/http.dart' as http;


class SupplierListContent extends StatefulWidget {
  final siteId;

  SupplierListContent(this.siteId);

  @override
  _SupplierListContentState createState() => _SupplierListContentState();
}

class _SupplierListContentState extends State<SupplierListContent> {

  List<SupplierDatum> supplierName = [];


  @override
  Widget build(BuildContext context) {
    return getCard(context);
  }

  Widget getCard(context) {
    return Padding(
      padding: const EdgeInsets.only(top:3.0),
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
                            padding: const EdgeInsets.only(top: 8.0,left: 40),
                            child: Text(
                              snapshot.error == null
                                  ? "Please Wait ..."
                                  : "There Is No Any Supplier Data,check your Internet Connection",
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
                return listContent();
              }
            })
    );
  }

  Widget listContent(){
    return ListView.builder(
        padding: EdgeInsets.only(top: 6),
        itemCount: supplierName.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        });
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
        title: Text("${index+1}. "+ supplierName[index].name),
      ),
    );
  }

  _fetchListItem(site) async {
//    print("id:"+site);
    String dataURL = "https://onlinesitemanager.com/adminpanel/api/request/suppliers?id=$site";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    supplierName.clear();
    for (SupplierDatum datum in supplierListModelFromJson(response.body).data) {
      supplierName.add(datum);
    }
    return supplierName;
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: getFirstView()
    );
  }
}
