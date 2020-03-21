import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/AddMaterialCategory.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/AddMateriall.dart';
import 'dart:convert';
import 'package:osm_app/Custom_dialog/customDialog.dart' as customDialog;
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';



class FormCardProduct extends StatefulWidget {
  final id, name, siteName, siteId;

  FormCardProduct(this.id, this.name, this.siteName, this.siteId);

  @override
  _FormCardProductState createState() => _FormCardProductState();
}


class _FormCardProductState extends State<FormCardProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _BillNumber;
  String _productname;
  String _supplierName;
  String _unit;
  String _quantity = "0";
  String _rate = "0";
  String _vat = "0";
  String _grandtotal = "0";

  Timer _everySecond;

  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');

  bool _isLoading;

  String _mySelectionproductinitial;
  String _mySelectionsupplierinitial;
  String _mySelectionunitinitial;
  String _mySelectionproductfinal;
  String _mySelectionsupplierfinal;
  String _mySelectionunitfinal;
  String _mySelectionpaymentinitial;
  String _mySelectionpaymentfinal;

  List unitList = List();
  List supplierList = List();
  List siteList = List();
  List productList = List();
  List paymentlist = List();

  bool _loading;
  double _progressValue;




  Future<String> getUnitList(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/productUnitsList?id=$site";
    http.Response res =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      unitList = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  Future<String> getSupplierList(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/suppliersList?id=$site";
    http.Response res =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      supplierList = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  Future<String> getPaymentList(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/paymentMethodList";
    http.Response res =
    await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      paymentlist = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  Future<String> getProductList(site) async {
    String dataURL =
        "https://onlinesitemanager.com/adminpanel/api/request/productsList?id=$site";
    http.Response res =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});

    var resBody = json.decode(res.body);

    setState(() {
      productList = resBody;
    });

//    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getProductList(widget.siteId);
    this.getSupplierList(widget.siteId);
    this.getUnitList(widget.siteId);
    this.getPaymentList(widget.siteId);

    _loading = false;
    _progressValue = 0.0;

    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _grandtotal = ((double.parse(_quantity) * double.parse(_rate)) +
                ((double.parse(_vat) / 100) *
                    (double.parse(_quantity) * double.parse(_rate))))
            .toString();

        print("grandTotal : $_grandtotal");
        print("Qty : $_quantity");
        print("Rate : $_rate");
        print("Vat : $_vat");
      });
    });
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
                        Card(

                          elevation: 5,
                          margin: EdgeInsets.all(0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 20.8,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: IconButton(
                                      splashColor: Colors.blue,
                                      icon: Icon(
                                        Icons.add,
                                        size: 22,
                                        color: Colors.black,
                                      ),
                                      tooltip: "Add MaterialCategory",
                                      onPressed: () {
                                        _showDialogMaterialCategory();
                                      },
                                    )),
                                Text("Add Product",
                                    style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(45),
                                        fontFamily: "Poppins-Bold",
                                        letterSpacing: .6)),

                                CircleAvatar(
                                    radius: 20.8,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: IconButton(
                                      splashColor: Colors.blue,
                                      icon: Icon(
                                        Icons.edit,
                                        size: 22,
                                        color: Colors.black,
                                      ),
                                      tooltip: "Add Material",
                                      onPressed: () {
                                        _showDialogMaterial(widget.id,widget.siteId);
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Bill Number",
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
                              hintText: "Bill Number",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          validator: validateBill,
                          onSaved: (String val) {
                            _BillNumber = val;
                          },
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("Product Name",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                        DropdownButtonFormField(

                          hint: Text("Select Product"),
                          items: productList.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['product_name']),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          validator: validateProduct,
                          onSaved: (value) {
                            setState(() {
                              _mySelectionproductinitial = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _mySelectionproductinitial = value;
                            });
                          },
                          value: _mySelectionproductinitial,
                        ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        hintText: "Product Name",
//                        hintStyle:
//                            TextStyle(color: Colors.grey, fontSize: 12.0)),
//                    keyboardType: TextInputType.text,
//                    maxLength: 30,
//                    validator: validateProduct,
//                    onSaved: (String val) {
//                      _productname = val;
//                    },
//                  ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Supplier Name",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                        new DropdownButtonFormField(
                          hint: Text("Select Supplier"),
                          items: supplierList.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['name']),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          validator: validateSupplier,
                          onSaved: (value) {
                            setState(() {
                              _mySelectionsupplierinitial = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _mySelectionsupplierinitial = value;
                            });
                          },
                          value: _mySelectionsupplierinitial,
                        ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        hintText: "Supplier Name",
//                        hintStyle:
//                            TextStyle(color: Colors.grey, fontSize: 12.0)),
//                    keyboardType: TextInputType.text,
//                    maxLength: 30,
//                    validator: validateSupplier,
//                    onSaved: (String val) {
//                      _supplierName = val;
//                    },
//                  ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Unit",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                        new DropdownButtonFormField(
                          hint: Text("Select Unit"),
                          items: unitList.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['unit']),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          validator: validateUnit,
                          onSaved: (value) {
                            setState(() {
                              _mySelectionunitinitial = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _mySelectionunitinitial = value;
                            });
                          },
                          value: _mySelectionunitinitial,
                        ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        hintText: "Unit",
//                        hintStyle:
//                            TextStyle(color: Colors.grey, fontSize: 12.0)),
//                    keyboardType: TextInputType.text,
//                    maxLength: 30,
//                    validator: validateUnit,
//                    onSaved: (String val) {
//                      _unit = val;
//                    },
//                  ),

                        SizedBox(
                          height: 15,
                        ),
                        Text("Payment Method",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                        new DropdownButtonFormField(
                          hint: Text("Select Payment Method"),
                          items: paymentlist.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['payment_type']),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          validator: validatePayment,
                          onSaved: (value) {
                            setState(() {
                              _mySelectionpaymentinitial = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _mySelectionpaymentinitial = value;
                            });
                          },
                          value: _mySelectionpaymentinitial,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Quantity",
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
                              hintText: "Quantity",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          validator: validateQuantity,
                          onSaved: (String val) {
                            _quantity = val;
                          },
                          onChanged: (newText) {
                            _quantity = newText != "" ? newText : "0";
                          },
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
                        Text("Rate",
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
                              hintText: "Rate",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          validator: validateRate,
                          onSaved: (String val) {
                            _rate = val;
                          },
                          onChanged: (newText) {
                            _rate = newText != "" ? newText : "0";
                          },
//                      onChanged: (newText){
//                        setState(() {
//                          _grandtotal = ((int.parse(_quantity) * int.parse(_rate)) + (int.parse(_vat) * (int.parse(_quantity) * int.parse(_rate)))).toString();
//                        });
//                        },
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
                        Text("Vat%",
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
                              hintText: "Vat%",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          validator: validateVat,
                          onSaved: (String val) {
                            _vat = val;
                          },
                          onChanged: (newText) {
                            _vat = newText != "" ? newText : "0";
                          },
//                      onChanged: (newText){
//                         setState(() {
//                           _grandtotal = (int.parse(_quantity) * int.parse(_rate) + int.parse(_vat) * (int.parse(_quantity) * int.parse(_rate))).toString();
//                         });
//                        },
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
                        Text("Grand Total",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(26))),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20),
                        ),
                        Text(
                          "Rs." + _grandtotal,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20),
                        ),
//                    TextFormField(
//                      decoration: InputDecoration(
//                          hintText: "Grand Total",
//                          hintStyle:
//                              TextStyle(color: Colors.grey, fontSize: 12.0)),
//                      keyboardType: TextInputType.number,
//                      maxLength: 30,
//                      validator: validateTotal,
//                      onSaved: (String val) {
//                        _grandtotal = val;
//                      },
//                    ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.date_range),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text("Product Date",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
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
                                      initialDate: _dateTime == null
                                          ? DateTime.now()
                                          : _dateTime,
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
                                    ? currentDate
                                    : myFormat.format(_dateTime)),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(35),
                        ),
                        if (_loading)  LinearProgressIndicator(),
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

  String validateBill(String value) {
    if (value.length == null || value.trim() == '')
      return 'Please Enter Bill Number';
    return null;
  }

  String validateProduct(String value) {
    if (value == null) return 'Please Select Product Name';
    return null;
  }

  String validateSupplier(String value) {
    if (value == null) return 'Please Select Supplier Name';
    return null;
  }

  String validateUnit(String value) {
    if (value == null) return 'Please Select Unit Name';
    return null;
  }

  String validatePayment(String value) {
    if (value == null) return 'Please Select Payment Method';
    return null;
  }

  String validateQuantity(String value) {
    if (value.length == null || value.trim() == '')
      return 'Please Enter Quantity';
    return null;
  }

  String validateRate(String value) {
    if (value.length == null || value.trim() == '') return 'Please Enter Rate';
    return null;
  }

  String validateVat(String value) {
    if (value.length == null || value.trim() == '') return 'Please Enter Vat%';
    return null;
  }

  String validateTotal(String value) {
    if (value.length == null || value.trim() == '')
      return 'Please Enter Grand Total';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        _mySelectionproductfinal = _mySelectionproductinitial;
        _mySelectionsupplierfinal = _mySelectionsupplierinitial;
        _mySelectionunitfinal = _mySelectionunitinitial;
        _mySelectionpaymentfinal = _mySelectionpaymentinitial;
      });
//      print(widget.id);
//      print(widget.siteId);
//      print(_BillNumber);
//      print(_mySelectionproductfinal);
//      print(_mySelectionsupplierfinal);
//      print(_mySelectionunitfinal);
//      print(_quantity);
//      print(_rate);
//      print(_vat);
//      print(_grandtotal);
//      print(myFormat.format(_dateTime));

      showDialogAlert(context);
//      postData(widget.id, widget.siteId, _BillNumber, _productname,
//          _supplierName, _unit, _quantity, _rate, _vat, _grandtotal, _dateTime);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  postData(
      String userId,
      String siteId,
      String billnumber,
      String productname,
      String suppliername,
      String unit,
      String payment,
      String quantity,

      String rate,
      String vat,
      String grandtotal,
      DateTime dateTime) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    Map data = {'user_id': "1", 'site_id': "1",'bill_no':"523",'item_code':"2",'supplier':"1",'unit':"1",'quantity':"20",'rate':"21",'vat':"0",'grand_total':"23",'mrn_date':"2020-1-12"};
    var jsonResponse;
    Map data = {
      'user_id': userId,
      'site_id': siteId,
      'bill_no': billnumber,
      'item_code': productname,
      'supplier': suppliername,
      'unit': unit,
      'pay_method':payment,
      'quantity': quantity,
      'rate': rate,
      'vat': vat,
      'grand_total': grandtotal,
      "mrn_date": myFormat.format(dateTime)
    };
    var response = await http.post(
        "https://onlinesitemanager.com/adminpanel/api/request/addProducts",
        headers: {"x-api-key": r"Re@!$TATE$T0Ck"},
        body: data);
//    print('response:${response.body}');
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
            msg: "Product Added Successfully.",
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
          _isLoading = false;
        });
      } else {
        setState(() {
          _progressValue = 0.0;
          _loading = !_loading;
          _updateProgress();

        });
        Fluttertoast.showToast(
            msg: "Failed to add product",
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
      setState(() {
        _isLoading = false;
      });
//      print(response.body);
    }
  }

  Widget _showDialogMaterialCategory() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(
            child: Text(
              "Add Material Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          content: AddMaterialCategory(),
        );
      },
    );
  }


  Widget _showDialogMaterial(uid,siteId) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: AlertDialog(
            title: Center(
              child: Text(
                "Add Material",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            content: AddMaterial(uid,siteId),
          ),
        );
      },
    );
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
                          postData(
                              widget.id,
                              widget.siteId,
                              _BillNumber,
                              _mySelectionproductfinal,
                              _mySelectionsupplierfinal,
                              _mySelectionunitfinal,
                              _mySelectionpaymentfinal,
                              _quantity,
                              _rate,
                              _vat,
                              _grandtotal,
                              _dateTime);
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
