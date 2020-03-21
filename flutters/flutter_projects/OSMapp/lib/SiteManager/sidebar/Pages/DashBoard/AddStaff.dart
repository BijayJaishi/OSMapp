import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/SiteManagerModels/AttendanceListModel.dart';


class AddStaff extends StatefulWidget {
  final uid,siteId;


  AddStaff(this.uid, this.siteId);

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _fullName;
  String _phone;
  String _address;
  String _email = "0";
  String _minsalary;

  List<AttendanceDatum> attendName = [];

  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  bool _isLoading;

  String _designationinitial;
  String _designationfinal;

  List designationList = List();

  Future<String> getdesignation(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/designationList";
    http.Response res =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      designationList = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getdesignation(widget.siteId);
    this._fetchListItem(widget.uid, widget.siteId);
  }
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: formUI(formattedDate),
    );
  }

  Widget formUI(String currentDate) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Wrap(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Add Staff",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text("FullName",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "FullName",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.0)),
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    validator: validateName,
                    onSaved: (String val) {
                      _fullName = val;
                    },
                  ),
//                  SizedBox(height: 8,),
//                  Text("Email Address",
//                      style: TextStyle(
//                          fontFamily: "Poppins-Medium",
//                          fontSize: ScreenUtil.getInstance().setSp(26))),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        hintText: "Email Address",
//                        hintStyle:
//                        TextStyle(color: Colors.grey, fontSize: 12.0)),
//                    keyboardType: TextInputType.emailAddress,
//                    maxLength: 30,
//                    validator: validateEmail,
//                    onSaved: (String val) {
//                      _email = val;
//                    },
//                  ),
                  SizedBox(height: 8,),
                  Text("Phone Number",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.0)),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: validatePhone,
                    onSaved: (String val) {
                      _phone = val;
                    },
                  ),
                  SizedBox(height: 8,),
                  Text("Address",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Address",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.0)),
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    validator: validateAddress,
                    onSaved: (String val) {
                      _address = val;
                    },
                  ),
                  SizedBox(height: 8,),
                  Text("Designation",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  DropdownButtonFormField(
                    hint: Text("Select Designation"),
                    items: designationList.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['title']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    validator: validateDesignation,
                    onSaved: (value) {
                      setState(() {
                        _designationinitial = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _designationinitial = value;
                      });
                    },
                    value: _designationinitial,
                  ),
                  SizedBox(height: 12,),
                  Text("Salary",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Salary",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.0)),
                    keyboardType: TextInputType.number,
                    maxLength: 30,
                    validator: validateSalary,
                    onSaved: (String val) {
                      _minsalary = val;
                    },
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.date_range),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Enroll Date",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  Card(
                    color: Colors.white70,
                    child: FlatButton(
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2021))
                            .then((date) {
                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_dateTime == null
                              ? myFormat.format(now)
                              : myFormat.format(_dateTime)),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(35),
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
                              _validateInputs();
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
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Full Name';
    return null;
  }

//  String validateEmail(String value) {
//    Pattern pattern =
//        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//    RegExp regex = new RegExp(pattern);
//    if (!regex.hasMatch(value))
//      return 'Enter Valid Email';
//    else
//      return null;
//  }

  String validatePhone(String value) {
    if ( value.trim() == '' || value.length!=10)
      return 'Mobile Number must be of 10 digit';
    return null;
  }
  String validateAddress(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Adddress';
    return null;
  }
  String validateSalary(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Salary';
    return null;
  }

  String validateDesignation(String value) {
    if (value == null) return 'Please Select Designation';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        _designationfinal = _designationinitial;
      });
//      post("", body)
//      print(_BillphotoName);
//      print(widget.uid);
//      print(widget.siteId);
//      print(_fullName);
//      print(_phone);
//      print(_email);
//
//      print(_address);
//
//      print(_designationfinal);
//      print(_minsalary);
//
//      print(_dateTime);



      showDialogAlert();
//      postData(id, _UsedAmount,widget.siteId);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData( String uid,String SiteId,String fullname,String email,String phone,String address,String designation,String salary,DateTime dateTime) async {
    Map data = {
      'user_id': uid,
      'site_id':SiteId,
      'fullname':fullname,
      'phone':phone,
      'address':address,
      'email':email,
      'designation':designation,
      'min_salary':salary,
      'join_date':myFormat.format(dateTime),
    };
    var jsonResponse;
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/addStaff",
        headers: {"x-api-key": r"Re@!$TATE$T0Ck"},
        body: data);
//    print(response.body);
    if (response.statusCode == 200) {
//      final loginResponseData = loginResponseFromJson(response.body);
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        Fluttertoast.showToast(
            msg: "Data Added Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);

        Navigator.of(context, rootNavigator: true).pop();
        _fetchListItem(widget.uid, widget.siteId);
        setState(() {
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed to add Data",
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

  showDialogAlert() {
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
                      postData(widget.uid,widget.siteId,_fullName,_email,_phone,_address,_designationfinal,_minsalary,_dateTime);
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

}


