import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/AddStaff.dart';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';
import 'package:osm_app/SiteManagerModels/AttendanceListModel.dart';
import 'package:osm_app/Custom_dialog/customDialog.dart' as customDialog;

class FormCardAttendance extends StatefulWidget {
  final uid, name, sitename, siteId;

  FormCardAttendance(this.uid, this.name, this.sitename, this.siteId);

  @override
  _FormCardAttendanceState createState() => _FormCardAttendanceState();
}

class _FormCardAttendanceState extends State<FormCardAttendance> {
  List<String> selectedItemValue = List<String>();



  bool _loading;
  double _progressValue;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool rememberMe = false;
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  String _hour = "0";
  bool absent = false;
  List<AttendanceDatum> attendName = [];
  AttendanceDatum attendanceDatum;
  bool isSelected = false;

  bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return getCard(context);
  }

  Widget getCard(context) {
    return Column(
      children: <Widget>[
        if (_loading)  LinearProgressIndicator(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: getElementList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget getFirstView() {
    return Container(
//        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: _fetchListItem(widget.uid, widget.siteId),
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
                              : "There Is No Any Attendance Data,check your Internet Connection",
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
                return maincontent();
              }
            }));
  }

  Widget maincontent(){
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          child: getButton(),
        ),
        Positioned(
          top: 65,
          left: 0,
          right: 0,
          bottom: 0,
          child: ListView.builder(
              padding: EdgeInsets.only(top: 6),
              itemCount: attendName.length,
              itemBuilder: (BuildContext context, int position) {
//                          for (int i = 0; i < 20; i++) {
                selectedItemValue.add("0");
//                          }
                return getRow(position);
              }),
        ),
      ],
    );
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
//        title: Text("${index + 1}. " + attendName[index].fullname),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("${index + 1}."),
            Text(attendName[index].fullname),
            DropdownButton(
              value: selectedItemValue[index].toString(),
              items: _dropDownItem(),
              onChanged: (value) {
                selectedItemValue[index] = value;
                setState(() {});
              },
              hint: Text('Select Hour'),
            ),
          ],
        ),
//        trailing: DropdownButton(
//          value: selectedItemValue[index].toString(),
//          items: _dropDownItem(),
//          onChanged: (value) {
//            selectedItemValue[index] = value;
//            setState(() {});
//          },
//          hint: Text('Select Hour'),
//        ),
      ),
    );
  }

  _fetchListItem(uid, site) async {
//    print("siteid:" + site);
//    print("uid" + uid);
//    print("name" + widget.name);
//    print("sitename" + widget.sitename);
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/staffs?id=$site&uId=$uid";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    attendName.clear();
    for (AttendanceDatum datum
        in attendanceListModelFromJson(response.body).data) {
      attendName.add(datum);
    }
    return attendName;
  }

  void postData(String uid, String siteId, String staff_id, String hour,
      String absentstatus, DateTime dateTime) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });
    Map data = {
      'user_id': uid,
      'site_id': siteId,
      'staff_id': staff_id,
      'hour': hour,
      'absent': absentstatus,
      'attend_date': myFormat.format(dateTime),
    };
    var jsonResponse;
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/addAttendance",
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
            msg: "Attendance Taken Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIos: 1);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Sitemain(
                  widget.uid, widget.name, widget.sitename, widget.siteId)),
        );

//        Navigator.of(context, rootNavigator: true).pop();
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
            msg: "Failed to take attendance",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
//      print(response.body);
    }
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0), child: getFirstView());
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = [];
    for (int i = 0; i < 19; i++) {
      ddl.add(i.toString());
    }

    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  Widget getButton() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
              radius: 20,
              child: IconButton(
                icon: Icon(Icons.add),
                tooltip: "Add Staff",
                iconSize: 25,
                color: Colors.black,
                onPressed: (){
                  _showDialogAttendance(widget.uid,widget.siteId);
                }

              ),
            ),
//            Text(
//              "S.No",
//              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//            ),
//           SizedBox(width: 18,),
            Text(
              "Name",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
//            SizedBox(width: 18,),
            Text(
              "Hour",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
              radius: 20,
              child: IconButton(
                icon: Icon(Icons.check),
                tooltip: "Submit Attendance",
                iconSize: 25,
                color: Colors.black,
                onPressed: _validateInputs,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _showDialogAttendance(uid,siteId) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Padding(
          padding: const EdgeInsets.only(top:20.0,left: 10,right: 10,bottom: 20),
          child: customDialog.Dialog(
          child:SingleChildScrollView(child: AddStaff(uid,siteId)) ,
          ),
        );
      },
    );
  }

  void _validateInputs() {
//    print(selectedItemValue);

    showDialogAlert(context);
  }

  showDialogAlert(context) {
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
                          for (int i = 0; i < attendName.length; i++) {
                            if (selectedItemValue[i] == "0") {
                              postData(widget.uid, widget.siteId,
                                  attendName[i].id, "0", "1", now);
                            } else {
                              postData(
                                  widget.uid,
                                  widget.siteId,
                                  attendName[i].id,
                                  selectedItemValue[i],
                                  "0",
                                  now);
                            }
                          }
//                      postData(widget.uid, widget.siteId, attendanceDatum.id, selectedItemValue,
//                          selectedItemValue,now);
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

//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:http/http.dart' as http;
//import 'package:intl/intl.dart';
//import 'package:osm_app/SiteManagerModels/AttendanceListModel.dart';
//
//class FormCardAttendance extends StatefulWidget {
//  final siteId, uid;
//
//  FormCardAttendance(this.siteId, this.uid);
//
//  @override
//  _FormCardAttendanceState createState() => _FormCardAttendanceState();
//}
//
//class Company {
//  int id;
//  String name;
//
//  Company(this.id, this.name);
//
//  static List<Company> getCompanies() {
//    return <Company>[
//      Company(1, 'Apple'),
//      Company(2, 'Google'),
//      Company(3, 'Samsung'),
//      Company(4, 'Sony'),
//      Company(5, 'LG'),
//    ];
//  }
//}
//
//
//class _FormCardAttendanceState extends State<FormCardAttendance> {
//
//
//  List<Company> _companies = Company.getCompanies();
//  List<DropdownMenuItem<Company>> _dropdownMenuItems;
//  Company _selectedCompany;
//
//  @override
//  void initState() {
//    _dropdownMenuItems = buildDropdownMenuItems(_companies);
//    _selectedCompany = _dropdownMenuItems[0].value;
//    super.initState();
//  }
//
//  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
//    List<DropdownMenuItem<Company>> items = List();
//    for (Company company in companies) {
//      items.add(
//        DropdownMenuItem(
//          value: company,
//          child: Text(company.name),
//        ),
//      );
//    }
//    return items;
//  }
//
//  onChangeDropdownItem(Company selectedCompany) {
//    setState(() {
//      _selectedCompany = selectedCompany;
//    });
//  }
//
//
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  bool _autoValidate = false;
//  bool rememberMe = false;
//  DateTime now = DateTime.now();
//  var myFormat = DateFormat('yyyy-MM-dd');
//  String _hour = "0";
//  bool absent = false;
//  List<AttendanceDatum> attendName = [];
//  AttendanceDatum attendanceDatum;
//  bool isSelected = false;
//
//  bool _isLoading;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        height: 700,
//        width: double.infinity,
//        child: FutureBuilder(
//            future: _fetchListItem(widget.uid, widget.siteId),
//            builder: (context, AsyncSnapshot snapshot) {
//              if (!snapshot.hasData) {
//                return Padding(
//                  padding: const EdgeInsets.only(top: 200.0),
//                  child: Center(
//                      child: Column(
//                    children: <Widget>[
//                      if (snapshot.error == null) ...[
//                        CircularProgressIndicator(),
//                      ],
//                      Padding(
//                        padding: const EdgeInsets.only(top: 8.0,left: 40),
//                        child: Text(
//                          snapshot.error == null
//                              ? "Please Wait ..."
//                              : "There Is No Any Product Data,check your Internet Connection",
//                          style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 16,
//                              fontFamily: "Poppins",
//                              fontWeight: FontWeight.bold),
//                        ),
//                      )
//                    ],
//                  )),
//                );
//              } else {
//                return Container(
//                    child: ListView.builder(
//                        padding: EdgeInsets.only(top: 6),
//                        itemCount: attendName.length,
//                        itemBuilder: (BuildContext context, int position) {
//                          return getRow(position);
//                        })
////
//                    );
//              }
//            }));
//  }
//
//  Widget getRow(position) {
//    return Container(
//      height: MediaQuery.of(context).size.height,
//      child: ListView(children: <Widget>[
//        Center(
//            child: Text(
//          'Attendance',
//          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//        )),
//        DataTable(
//          columns: [
//            DataColumn(
//                label: Text(
//              'ID',
//              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//            )),
//            DataColumn(
//                label: Text(
//              'Name',
//              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//            )),
//            DataColumn(
//                label: Text(
//              'Attendance',
//              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//            )),
//          ],
//          rows:
//              attendName // Loops through dataColumnText, each iteration assigning the value to element
//                  .map(
//                    ((attendanceDatum) => DataRow(
//                          cells: <DataCell>[
//                            DataCell(
//                              Text(attendanceDatum.id,
//                                  style: TextStyle(
//                                      fontSize: 14,
//                                      fontWeight: FontWeight.bold)),
//                            ),
//                            //Extracting from Map element the value
//                            DataCell(
//                              Text(
//                                attendanceDatum.fullname,
//                                style: TextStyle(
//                                    fontSize: 14, fontWeight: FontWeight.bold),
//                              ),
//                            ),
//                            DataCell(
//                              DropdownButton(
//                                value: _selectedCompany,
//                                items: _dropdownMenuItems,
//                                onChanged: onChangeDropdownItem,
//                              ),
//                            ),
//                          ],
//                        )),
//                  )
//                  .toList(),
//        ),
//      ]),
//    );
//  }
//
//  _fetchListItem(site, uid) async {
//    print("siteid:" + site);
//    print("uid" + uid);
//    String dataURL =
//        "https://onlinesitemanager.com/adminpanel/api/request/staffs?id=$site&uId=$uid";
//    http.Response response =
//        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
//    attendName.clear();
//    for (AttendanceDatum datum
//        in attendanceListModelFromJson(response.body).data) {
//      attendName.add(datum);
//    }
//    return attendName;
//  }
//
//
//  void postData(String uid, String siteId, String staff_id, String hour,
//      bool absentstatus, DateTime dateTime) async {
//    Map data = {
//      'user_id': uid,
//      'site_id': siteId,
//      'staff_id': staff_id,
//      'hour': hour,
//      'absent': absentstatus,
//      'attend_date': myFormat.format(dateTime),
//    };
//    var jsonResponse;
//    var response = await http.post(
//        "https://onlinesitemanager.com/adminpanel/api/request/addAttendance",
//        headers: {"x-api-key": r"Re@!$TATE$T0Ck"},
//        body: data);
//    print(response.body);
//    if (response.statusCode == 200) {
////      final loginResponseData = loginResponseFromJson(response.body);
//      jsonResponse = json.decode(response.body);
//
//      if (jsonResponse != null) {
//        Fluttertoast.showToast(
//            msg: "Data Added Successfully.",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            backgroundColor: Colors.red,
//            timeInSecForIos: 1);
//
//        Navigator.of(context, rootNavigator: true).pop();
//        setState(() {
//          _isLoading = false;
//        });
//      } else {
//        Fluttertoast.showToast(
//            msg: "Failed to add Data",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            backgroundColor: Colors.red,
//            timeInSecForIos: 1);
//      }
//    } else {
//      setState(() {
//        _isLoading = false;
//      });
//      print(response.body);
//    }
//  }
//}
