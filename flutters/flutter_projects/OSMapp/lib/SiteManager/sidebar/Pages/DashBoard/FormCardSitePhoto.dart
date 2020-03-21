import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:osm_app/SiteManager/sidebar/Sitemain.dart';


class FormCardSite extends StatefulWidget {
  final id, name, sitename, siteId;

  FormCardSite(this.id, this.name, this.sitename, this.siteId);
  @override
  _FormCardSiteState createState() => _FormCardSiteState();
}

class _FormCardSiteState extends State<FormCardSite> {
//  bool _isSelected = false;
  String _error = 'No Error Dectected';
  List<Asset> images = List<Asset>();
  List<UploadFileInfo> imgList = new List();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool rememberMe = false;
  String _photoDescription;
  String _photoName;
  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');

  bool _isLoading;
  String fileName;
  var imageFile;

  bool _loading;
  double _progressValue;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

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
          child: SingleChildScrollView(
            child: new Container(
              width: double.infinity,
//          height: MediaQuery.of(context).size.height +25,
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
                      child: Text("Site Photos",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: .6)),
                    ),

                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Text("Photo Name",
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
                          hintText: "Photo Name",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      validator: validateName,
                      onSaved: (String val) {
                        _photoName = val;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    Text("Photo Description",
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
                          hintText: "Photo Description",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                      keyboardType: TextInputType.text,
                      maxLength: 100,
                      validator: validateDescription,
                      onSaved: (String val) {
                        _photoDescription = val;
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
                          child: Text("Photo Date",
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
                                ? currentDate
                                : myFormat.format(_dateTime)),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Text("Upload Photo",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: ScreenUtil.getInstance().setSp(26))),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(15),
                    ),
                    RaisedButton(
                      child: Text("Pick images"),
                      onPressed: loadAssets,
                    ),
              Container(
                height: 200,
                  child: buildGridView()
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
                    SizedBox(height: 20,)
//              Column(
//                children: <Widget>[
//                  Center(child: Text('Error: $_error')),
//
//                  Expanded(
//                    child: buildGridView(),
//                  )
//                ],
//              ),
//              buildGridView(),
//              getPhotolist(),

//              SizedBox(
//                height: ScreenUtil.getInstance().setHeight(75),
//              ),

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
    if (value.trim().length < 1)
      return 'Enter Photo Name';
    else
      return null;
  }

  String validateDescription(String value) {
    if (value.trim().length<1)
      return 'Enter Photo Description';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
//      post("", body)


//      print(widget.id);
//      print(widget.siteId);
//      print(_photoName);
//      print(_photoDescription);
//      print(myFormat.format(_dateTime));
//      print(imageFile);

//    for (int i =0; i<images.length; i++){

      showDialogAlert(context);

//    }

    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }



  void postData(String userId, String siteId, String photoname,String photodescription,
      DateTime dateTime) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });
      Dio dio = new Dio();

      FormData formData = new FormData(); // just like JS
      formData.add("img_name[]", imgList);
      formData.add("user_id", userId);
      formData.add("site_id", siteId);
      formData.add("name", photoname);
      formData.add("description", photodescription);
      formData.add("photo_date", myFormat.format(_dateTime));
      dio
          .post("https://onlinesitemanager.com/adminpanel/api/request/addSite",
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

                msg: "Site Photo Added Successfully.",
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
                msg: "Failed to add site photo",
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
//    }
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
                            loadAssets();
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

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Card(
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';



    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      for (var asset in resultList) {

        int MAX_WIDTH = 500; //keep ratio
        int height = ((500 * asset.originalHeight) / asset.originalWidth).round();

        ByteData byteData = await asset.requestThumbnail(MAX_WIDTH, height, quality: 80);

        if (byteData != null) {
          List<int> imageData = byteData.buffer.asUint8List();
          UploadFileInfo u = UploadFileInfo.fromBytes(imageData, asset.name);
          imgList.add(u);
        }

      }
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
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
                      postData(widget.id, widget.siteId,_photoName,_photoDescription,_dateTime);
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
