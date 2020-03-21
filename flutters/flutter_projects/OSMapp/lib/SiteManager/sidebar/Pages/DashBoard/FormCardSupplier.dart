import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';

class FormCardSupplier extends StatefulWidget {
  final id, name, siteName, siteId;

  FormCardSupplier(this.id, this.name, this.siteName, this.siteId);

  @override
  _FormCardSupplierState createState() => _FormCardSupplierState();
}

class _FormCardSupplierState extends State<FormCardSupplier> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _SupplierName;
  String _phone;
  String _address;
  String _pannum;
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');

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
    return new Container(
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: formUI(),
      ),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        if (_loading)  LinearProgressIndicator(),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: new Container(
              width: double.infinity,
//          height: MediaQuery.of(context).size.height,
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
                    Center(
                      child: Text("Add Supplier",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: .6)),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Text("Supplier Name",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: ScreenUtil.getInstance().setSp(26))),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,width: 2.3),
                          ),
                          hintText: "Supplier Name",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      validator: validateName,
                      onSaved: (String val) {
                        _SupplierName = val;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Text("Address",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: ScreenUtil.getInstance().setSp(26))),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,width: 2.3),
                          ),
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      validator: validateAddress,
                      onSaved: (String val) {
                        _address = val;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Text("Phone Number",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: ScreenUtil.getInstance().setSp(26))),
                    TextFormField(

                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,width: 2.3),
                          ),
                          hintText: "Phone Number",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: validatePhone,
                      onSaved: (String val) {
                        _phone = val;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Text("Pan Number",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: ScreenUtil.getInstance().setSp(26))),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,width: 2.3),
                          ),
                          hintText: "Pan Number",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.number,
                      maxLength: 30,
                      validator: validatePannum,
                      onSaved: (String val) {
                        _pannum = val;
                      },
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

//                        Navigator.pop(context,
//                            true); // It worked for me instead of above line
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => Dashboardd()),
//                        );
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
                      height:20 ,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  String validateName(String value) {
    if (value.length == null || value.trim() == '') return 'Please Enter Name';
    return null;
  }

  String validateAddress(String value) {
    if (value.length == null || value.trim() == '')
      return 'Please Enter Address';
    return null;
  }

  String validatePhone(String value) {
    if (value.length < 10) return 'Phone Number must be of 10 digits';
    return null;
  }

  String validatePannum(String value) {
    if (value.length < 8) return 'Pan Number must have atleast 8 digits';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
//      print (widget.id);
//      print(widget.siteId);
//      print(_SupplierName);

      showDialogAlert(context);

//      postData(
//          widget.id, widget.siteId, _SupplierName, _address, _phone, _pannum);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  postData(String userId, String siteId, String suppliername, String address,
      String phone, String pannum) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'user_id': userId,
      'site_id': siteId,
      'name': suppliername,
      'address': address,
      'phone': phone,
      'pan_no': pannum
    };
    var jsonResponse;
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/addSuppliers",
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
            backgroundColor: Colors.green,
            timeInSecForIos: 1);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Sitemain(
                  widget.id, widget.name, widget.siteName, widget.siteId)),
        );
        setState(() {
          _progressValue = 0.0;
          _loading = !_loading;
          _updateProgress();

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
        _progressValue = 0.0;
        _loading = !_loading;
        _updateProgress();

      });
//      print(response.body);
    }
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
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      postData(
                          widget.id, widget.siteId, _SupplierName, _address, _phone, _pannum);
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
