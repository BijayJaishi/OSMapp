import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/SiteManagerModels/StockProductModel.dart';

class FormCardStock extends StatefulWidget {
  final siteId;

  FormCardStock(this.siteId);

  @override
  _FormCardStockState createState() => _FormCardStockState();
}

class _FormCardStockState extends State<FormCardStock> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _UsedAmount;
  List<StockDatum> stockName = [];
  StockDatum stockDatum;

  bool _isLoading;

  bool _loading;
  double _progressValue;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }


  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.only(top: 8.0, left: 40),
                        child: Text(
                          snapshot.error == null
                              ? "Please Wait ..."
                              : "There Is No Any Product Data,check your Internet Connection",
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
                return Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      child: getButton(),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 6),
                          itemCount: stockName.length,
                          itemBuilder: (BuildContext context, int position) {
                            return getRow(position);
                          }),
                    ),
                  ],
                );
//                return Container(
//                  child: ListView.builder(
////                  scrollDirection: Axis.vertical,
////                    shrinkWrap: true,
//                      padding: EdgeInsets.only(top: 6),
//                      itemCount: stockName.length,
//                      itemBuilder: (BuildContext context, int position) {
//                        return getRow(position);
//                      }),
//                );
//                return ListView.builder(
//                    padding: EdgeInsets.only(top: 6),
//                    itemCount: stockName.length,
//                    itemBuilder: (BuildContext context, int position) {
//                      return getRow(position);
//                    });
              }
            }));
  }

  Widget getButton() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "S.No",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              "Name",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              "Remaining Amount",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: (){
        stockName[index].remainingQuanity !=0?_showDialog(stockName[index].productId,stockName[index].productName,stockName[index].remainingQuanity):_showFalseDialog(stockName[index].productName);
      },
      child: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.white10, width: 1),
        ),
        margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
        child: ListTile(
          contentPadding:
              EdgeInsets.only(left: 10.0, top: 0, bottom: 0, right: 10.0),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("${index + 1}."),
              SizedBox(
                width: 0,
              ),
              Text(stockName[index].productName),
              SizedBox(
                width: 0,
              ),
              InkWell(splashColor:Colors.blue,child: Text(stockName[index].remainingQuanity.toString()),onTap: (){
                stockName[index].remainingQuanity !=0?_showDialog(stockName[index].productId,stockName[index].productName,stockName[index].remainingQuanity):_showFalseDialog(stockName[index].productName);
              },),
            ],
          ),
          trailing: InkWell(splashColor:Colors.blue,child: Icon(Icons.edit,size: 20,),onTap: (){
            stockName[index].remainingQuanity !=0?_showDialog(stockName[index].productId,stockName[index].productName,stockName[index].remainingQuanity):_showFalseDialog(stockName[index].productName);
          },),
        ),
      ),
    );
  }

//  Widget getRow(position) {
//    print(widget.siteId);
//    return
//      Stack(
//        children: <Widget>[
//          Positioned(left: 0,right: 0,child:Center(
//              child: Text(
//                'Stock',
//                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//              )) ,),
//          Positioned(
//            top:20,
//            left: 0,
//            right: 0,
//            bottom: 0,
//            child: DataTable(
//              columns: [
//
//                DataColumn(label: Text('S.No',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
//                DataColumn(label: Text('Product',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
//                DataColumn(label: Text('Remaining',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
////                        DataColumn(label: Expanded(flex:1,child: Text('Actions',style: TextStyle(fontSize: 5, fontWeight: FontWeight.normal),))),
//              ],
//              rows:
//              stockName // Loops through dataColumnText, each iteration assigning the value to element
//                  .map(
//                ((stockDatum) => DataRow(
//                  cells: <DataCell>[
//                    DataCell(Text(stockDatum.productId,style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.bold)),), //Extracting from Map element the value
//                    DataCell(Text(stockDatum.productName,style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.bold),)),
//                    DataCell(Text(stockDatum.remainingQuanity.toString(),style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.bold),),showEditIcon: true,onTap: (){
//                      {
//                        stockDatum.remainingQuanity !=0?_showDialog(stockDatum.productId,stockDatum.productName,stockDatum.remainingQuanity):_showFalseDialog(stockDatum.productName);
//                      }
//                    }),
////                            DataCell(
////                              GestureDetector(
////                                  child: Icon(Icons.edit),onTap: (){
////                                    _showDialog(stockDatum.productId,stockDatum.productName);
////                              },),
////                            ),
//                  ],
//                )),
//              ).toList(),
//            ),
//          ),
//        ],
//      );
////      Column(
////         children: <Widget>[
////                  Center(
////                      child: Text(
////                        'Stock',
////                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
////                      )),
////                  DataTable(
////                    columns: [
////
////                      DataColumn(label: Text('S.No',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
////                      DataColumn(label: Text('Product',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
////                      DataColumn(label: Text('Remaining',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
//////                        DataColumn(label: Expanded(flex:1,child: Text('Actions',style: TextStyle(fontSize: 5, fontWeight: FontWeight.normal),))),
////                    ],
////                    rows:
////                    stockName // Loops through dataColumnText, each iteration assigning the value to element
////                        .map(
////                      ((stockDatum) => DataRow(
////                        cells: <DataCell>[
////                          DataCell(Text(stockDatum.productId,style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.bold)),), //Extracting from Map element the value
////                          DataCell(Text(stockDatum.productName,style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.bold),)),
////                          DataCell(Text(stockDatum.remainingQuanity.toString(),style: TextStyle(fontSize: 13.2, fontWeight: FontWeight.bold),),showEditIcon: true,onTap: (){
////                            {
////                              stockDatum.remainingQuanity !=0?_showDialog(stockDatum.productId,stockDatum.productName,stockDatum.remainingQuanity):_showFalseDialog(stockDatum.productName);
////                            }
////                          }),
//////                            DataCell(
//////                              GestureDetector(
//////                                  child: Icon(Icons.edit),onTap: (){
//////                                    _showDialog(stockDatum.productId,stockDatum.productName);
//////                              },),
//////                            ),
////                        ],
////                      )),
////                    ).toList(),
////                  ),
////           SizedBox(height: 10,),
////                ]);
//  }

  _fetchListItem(site) async {
//    print("id:" + site);
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/siteStocks?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    stockName.clear();
    for (StockDatum datum in stockProductModelFromJson(response.body).data) {
      stockName.add(datum);
    }
    return stockName;
  }

  Widget _showDialog(id, name, remainingquantity) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.deepOrangeAccent,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Remaining Stock: $remainingquantity",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          content: new Container(
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: formUI(id, name),
            ),
          ),
        );
      },
    );
  }

  Widget _showFalseDialog(name) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.error,
                    color: Colors.deepOrangeAccent,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Sorry !!!",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 8),
                child: Text(
                  "The Remaining Stock is Zero.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget formUI(id, name) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: new Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: Colors.white,
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
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Used Amount",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Used Amount",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                keyboardType: TextInputType.number,
                maxLength: 30,
                validator: validateUsedAmount,
                onSaved: (String val) {
                  _UsedAmount = val;
                },
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(20),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(235),
                    height: ScreenUtil.getInstance().setHeight(80),
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
                        onTap: () async {
//
                          setState(() {
                            _isLoading = true;
                          });
                          _validateInputs(id, name);
                        },
                        child: Center(
                          child: Text("Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 16,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String validateUsedAmount(String value) {
    if (value.trim().length < 1) return 'Enter Used Amount';
    return null;
  }

  void _validateInputs(id, name) {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
//      post("", body)
//      print(_BillphotoName);
//      print(id);
//      print(widget.siteId);
//      print(name);
//      print(_UsedAmount);

      showDialogAlert(context, id);
//      postData(id, _UsedAmount,widget.siteId);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData(String id, String usedamount, String siteId) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });
    Map data = {
      'product_id': id,
      'remove_qty': usedamount,
      'site_id': siteId,
    };
    var jsonResponse;
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/removeStock",
        headers: {"x-api-key": r"Re@!$TATE$T0Ck"},
        body: data);
//    print(response.body);
    if (response.statusCode == 200) {
//      final loginResponseData = loginResponseFromJson(response.body);
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        setState(() {
          _progressValue = 0.0;
          _loading = !_loading;
          _updateProgress();

        });
        Fluttertoast.showToast(
            msg: "Stock Added Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIos: 1);

        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _progressValue = 0.0;
          _loading = !_loading;
          _updateProgress();

        });
        Fluttertoast.showToast(
            msg: "Failed to add stock",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  showDialogAlert(context, id) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to Submit'),
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
                          FocusScope.of(context).requestFocus(FocusNode());
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
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          postData(id, _UsedAmount, widget.siteId);
                          Navigator.of(context).pop(false);
                        },
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

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          _progressValue: 0.0;
          return;
        }
      });
    });
  }
}
