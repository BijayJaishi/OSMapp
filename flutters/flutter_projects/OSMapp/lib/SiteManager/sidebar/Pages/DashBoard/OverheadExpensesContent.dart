import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';

class OverHeadExpensesContent extends StatefulWidget{

  final id,name,sitename,siteId;

  OverHeadExpensesContent(this.id,this.name,this.sitename,this.siteId);

  @override
  _OverHeadExpensesContentState createState() => _OverHeadExpensesContentState();
}

class _OverHeadExpensesContentState extends State<OverHeadExpensesContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _description;
  String _price;

  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  bool _isLoading;

  String _expenseinitial;
  String _expensefinal;

  List expenseList = List();

  bool _loading;
  double _progressValue;


  Future<String> getExpenseCategory() async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/expensesTypeList";
    http.Response res =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      expenseList = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getExpenseCategory();
    _loading = false;
    _progressValue = 0.0;
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
    return Column(
      children: <Widget>[
        if (_loading)  LinearProgressIndicator(),
        GestureDetector(
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text("OverHead Expenses",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(45),
                                  fontFamily: "Poppins-Bold",
                                  letterSpacing: .6)),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(15),
                        ),
                        Text("Expense Type",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                        DropdownButtonFormField(
                          hint: Text("Select Expense Type"),
                          items: expenseList.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['exp_name']),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          validator: validateexpenseCategory,
                          onSaved: (value) {
                            setState(() {
                              _expenseinitial = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _expenseinitial = value;
                            });
                          },
                          value: _expenseinitial,
                        ),
                        SizedBox(height: 15,),
                        Text("Price",
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
                              hintText: "Price",
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          validator: validatePrice,
                          onSaved: (String val) {
                            _price = val;
                          },
                        ),
                        SizedBox(height: 8,),
                        Text("Description",
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
                              hintText: "Description",
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          validator: validateDescription,
                          onSaved: (String val) {
                            _description = val;
                          },
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.date_range),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text("Expense Date",
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String validatePrice(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Price';
    return null;
  }
  String validateDescription(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Description';
    return null;
  }

  String validateexpenseCategory(String value) {
    if (value == null) return 'Please Select Expense Type';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        _expensefinal = _expenseinitial;
      });
//      post("", body)
//      print(_BillphotoName);
//      print(id);
//      print(widget.siteId);
//      print(name);
//      print(_UsedAmount);
      print(_dateTime);

      showDialogAlert();
//      postData(id, _UsedAmount,widget.siteId);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData( String uid,String SiteId,String price,String expensetype,String description,DateTime dateTime) async {
    print(dateTime);
    Map data = {
      'user_id': uid,
      'site_id':SiteId,
      'price':price,
      'exp_type':expensetype,
      'over_desc':description,
      'pay_date':myFormat.format(dateTime),
    };
    var jsonResponse;
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/addOverHead",
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

            msg: "OverHead Expenses Added Successfully.",
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
            msg: "Failed to add overhead expenses",
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
                      postData(widget.id,widget.siteId,_price,_expensefinal,_description,_dateTime);
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


