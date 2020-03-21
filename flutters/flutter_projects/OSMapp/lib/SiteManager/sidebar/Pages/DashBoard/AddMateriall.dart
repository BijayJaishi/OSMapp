import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class AddMaterial extends StatefulWidget {
  final uid,siteId;

  AddMaterial(this.uid, this.siteId);

  @override
  _AddMaterialState createState() => _AddMaterialState();
}

class _AddMaterialState extends State<AddMaterial> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _MaterialName;

  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  bool _isLoading;

  String _materialcategoryinitial;
  String _materialCategoryfinal;

  List materialCategoryList = List();

  Future<String> getMaterialCategory(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/materialCategoryList";
    http.Response res =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      materialCategoryList = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getMaterialCategory(widget.siteId);
  }
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return new Container(
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: formUI(formattedDate),
      ),
    );
  }

  Widget formUI(String currentDate) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Wrap(
        children: <Widget>[
          SingleChildScrollView(
            child: new Container(
              width: double.infinity,
//              height: MediaQuery.of(context).size.height + 355,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Material Category",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  DropdownButtonFormField(
                    hint: Text("Select Material Category"),
                    items: materialCategoryList.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['parent_id'].toString(),
                      );
                    }).toList(),
                    validator: validatematerialCategory,
                    onSaved: (value) {
                      setState(() {
                        _materialcategoryinitial = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _materialcategoryinitial = value;
                      });
                    },
                    value: _materialcategoryinitial,
                  ),
                  SizedBox(height: 15,),
                  Text("Material Name",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Material Name",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.0)),
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    validator: validateMaterial,
                    onSaved: (String val) {
                      _MaterialName = val;
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
          ),
        ],
      ),
    );
  }

  String validateMaterial(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Material Name';
    return null;
  }

  String validatematerialCategory(String value) {
    if (value == null) return 'Please Select Material Category';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        _materialCategoryfinal = _materialcategoryinitial;
      });
//      post("", body)
//      print(_BillphotoName);
//      print(id);
//      print(widget.siteId);
//      print(name);
//      print(_UsedAmount);

      showDialogAlert();
//      postData(id, _UsedAmount,widget.siteId);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData( String uid,String SiteId,String materialName,String materialcategory) async {
    Map data = {
      'user_id': uid,
      'site_id':SiteId,
      'product_name':materialName,
      'product_category':materialcategory,
    };
    var jsonResponse;
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/addMaterial",
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
                      postData(widget.uid,widget.siteId,_MaterialName,_materialCategoryfinal);
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

}


