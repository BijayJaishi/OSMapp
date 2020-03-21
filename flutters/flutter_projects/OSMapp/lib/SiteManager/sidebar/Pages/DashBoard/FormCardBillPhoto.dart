import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';

class FormCardBillPhoto extends StatefulWidget {
  final id, name, sitename, siteId;

  FormCardBillPhoto(this.id, this.name, this.sitename, this.siteId);

  @override
  _FormCardBillPhotoState createState() => _FormCardBillPhotoState();
}

class _FormCardBillPhotoState extends State<FormCardBillPhoto> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _BillNumber;
  String _BillphotoName;
  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');

  bool _loading;
  double _progressValue;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }


  bool _isLoading;

  String fileName;
  var imageFile;

  Future<void> pickImage(ImageSource imageSource) async {
    File selected = await ImagePicker.pickImage(source: imageSource,imageQuality: 70);
//    compressFormatName(ImageCompressFormat.jpg);
    setState(() {
      imageFile = selected;
    });
  }

  void _clear() {
    setState(() => imageFile = null);
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
                      child: Text("Bill Photos",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: .6)),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
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
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.number,
                      maxLength: 30,
                      validator: validateBillNumber,
                      onSaved: (String val) {
                        _BillNumber = val;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text("Bill Date",
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
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Center(
                      child: Text("Upload Photo",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(26))),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Center(child: getPhotolist()),
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
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String validateBillNumber(String value) {
    if (value.trim().length < 1) return 'Enter Bill Number';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
//      post("", body)
//      print(_BillphotoName);
//      print(widget.id);
//      print(widget.siteId);
//      print(imageFile);
//      print(_BillNumber);
//      print(myFormat.format(_dateTime));

      showDialogAlert(context);
//      postData(widget.id, widget.siteId, imageFile, _BillNumber, _dateTime);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData(String userId, String siteId, File image, String billno,
      DateTime dateTime) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });

    if (image != null) {
      String fileName = image.path.split('/').last;
      Dio dio = new Dio();
      FormData formData = new FormData(); // just like JS
      formData.add("img_name", new UploadFileInfo(image, fileName));
      formData.add("user_id", userId);
      formData.add("site_id", siteId);
      formData.add("bill_no", billno);
      formData.add("bill_date", myFormat.format(dateTime));
      dio
          .post("https://onlinesitemanager.com/adminpanel/api/request/addBill",
              data: formData,
              options: Options(
                  method: 'POST',
                  headers: {
                    "x-api-key": r"Re@!$TATE$T0Ck",
                    "Content-Type": "multipart/form-data"
                  },
                  responseType: ResponseType.json // or ResponseType.JSON
                  ))
          .then((r) {
        setState(() {
          var data = r.data;
//          print('responseResult : $data');
          if (data != null) {
            setState(() {
              _progressValue = 0.0;
              _loading = !_loading;
              _updateProgress();

            });
            Fluttertoast.showToast(
                msg: "Bill Added Successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                timeInSecForIos: 1);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Sitemain(
                      widget.id, widget.name, widget.sitename, widget.siteId)),
            );
          } else {
            setState(() {
              _progressValue = 0.0;
              _loading = !_loading;
              _updateProgress();

            });
            Fluttertoast.showToast(
                msg: "Failed to add bill",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                timeInSecForIos: 1);
          }
//        if(data["apiMessage"].contains('Saved')){
//          warningAlert("Attendance Saved", "Your attendance saved Successfully",context);
//        }
        });
      });
    }
  }

  Widget getPhotolist() {
    return Container(
      height: 250,
      child: imageFile == null
          ? Center(
              child: Card(
                  child: Container(
                width: double.infinity,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _showDialog(),
                    child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 50,
                        child: Icon(
                          Icons.add,
                          size: 50,
                          color: Colors.black,
                        )),
                  ),
                ),
              )),
            )
          : Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
//                              border: Border.all(width : 10.0,color: Colors.transparent),
                  borderRadius: BorderRadius.circular(0.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(80, 0, 0, 0),
                        blurRadius: 5.0,
                        offset: Offset(5.0, 5.0))
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover, image: FileImage(imageFile))),
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(top: 5.0, right: 5),
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => _clear(),
                  child: CircleAvatar(
                    radius: 15,
                    child: Icon(
                      Icons.clear,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Visibility(
          child: AlertDialog(
            title: new Text("Choose Image Source"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.teal,
                  child: InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(150),
                      height: ScreenUtil.getInstance().setHeight(70),
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
                            pickImage(ImageSource.camera);
                            Navigator.of(context).pop(false);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Center(
                              child: Text("Camera",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 12,
                                  )),
                            ),
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
                      width: ScreenUtil.getInstance().setWidth(150),
                      height: ScreenUtil.getInstance().setHeight(70),
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
                            pickImage(ImageSource.gallery);
                            Navigator.of(context).pop(false);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Center(
                              child: Text("Gallery",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 12,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*Navigator.of(context).pop(true)*/
                ),
              ],
            ),
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
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      postData(widget.id, widget.siteId, imageFile, _BillNumber, _dateTime);
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
