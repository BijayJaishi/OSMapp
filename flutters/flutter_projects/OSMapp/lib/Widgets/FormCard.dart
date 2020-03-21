import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osm_app/Dashboard/Dashboardd.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/DashBoardManager.dart';
import 'package:osm_app/model_classes/LoginModel/login_response.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
//  bool _isSelected = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool rememberMe = false;
  String _password;
  String _email;
//  bool _isLoading = false;
  bool _obscureText = true;




  _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = !rememberMe;

//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('password', pass);
//    prefs.setString('email', email);


  });
  bool _loading;
  double _progressValue;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }


//  Future<void> main() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  var emailid = prefs.getString('email');
//  print(emailid);

//}

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

  Widget formUI(){
    return Column(
      children: <Widget>[

        new Container(

          width: double.infinity,
          height: ScreenUtil.getInstance().setHeight(780),
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
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Login",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text("Email Address",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  decoration: InputDecoration(

                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  validator: validateEmail,
                  onSaved: (String val) {
                    _email = val;
                  },
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text("PassWord",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      suffixIcon: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child:
                        new Icon(_obscureText ? Icons.visibility_off: Icons.visibility),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 20,
                  validator: validatePassword,

                  onSaved: (String val) {
                    _password = val;
                  },


                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          //onTap: _radio,
                          //child: radioButton(_isSelected),
                          child: Checkbox(value: rememberMe, onChanged: _onRememberMeChanged),
                        ),
                        Text("Remember me",
                            style: TextStyle(
                                fontSize: 12, fontFamily: "Poppins-Medium")),
                      ],
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26)),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
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
//                        setState(() {
//                          _isLoading = true;
//                        });
                            SharedPreferences prefs = await SharedPreferences.getInstance();
//                        prefs.setString('email', 'food@gmail.com');
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
                            child: Text("Sign in",
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
        if (_loading)  LinearProgressIndicator(),
      ],
    );
}

  String validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be more than 6 character';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
 
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
//      post("", body)
//      print(_email);
//      print(_password);


      signIn(_email, _password);

    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
//
//  Future<dynamic> post(String url, var body) async {
//    var response = await http.post(url, body: body);
//    final String res = response.body;
//    return res;
//  }

  saveData(String email,pass,id,groupflag,firstname) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', pass);
    prefs.setString('email', email);
    prefs.setString('id',id);
    prefs.setString('groupflag',groupflag);
    prefs.setString('firstname', firstname);
//    print(id);

//    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Dashboardd(id)), (Route<dynamic> route) => false);
  }

  signIn(String email, pass) async {

    setState(() {
      _progressValue = 0.0;
      _loading = !_loading;
      _updateProgress();

    });
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'identity': email,
      'password': pass
    };
    var jsonResponse;
    var response = await http.post("https://onlinesitemanager.com/adminpanel/api/request/userLogin", headers: {"x-api-key": r"Re@!$TATE$T0Ck"}, body: data);
    if(response.statusCode == 200) {
      final loginResponseData = loginResponseFromJson(response.body);
      jsonResponse = json.decode(response.body);

      if(jsonResponse != null) {
        if (loginResponseData.status == 1){
          Fluttertoast.showToast(
              msg: "Login Successfull.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              timeInSecForIos: 1
          );
          for(Datum datum in loginResponseData.data){
//            print(datum.id);
            if (rememberMe) {
              saveData(_email == datum.email ? _email : null,_password,datum.id,datum.groupName,datum.firstName);
            } else {
              saveData(null, null,datum.id,datum.groupName,datum.firstName);
            }

            if(datum.groupName == "SiteAdmin"){
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Dashboardd(datum.id,datum.firstName)), (Route<dynamic> route) => false);
            }else if(datum.groupName == "SiteManager"){

              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DashBoardManager(datum.id,datum.firstName)), (Route<dynamic> route) => false);
            }else {
              Fluttertoast.showToast(
                  msg: "No User Found!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  timeInSecForIos: 1
              );
            }
          }
        }else{
          setState(() {
            _progressValue = 0.0;
            _loading = !_loading;
            _updateProgress();

          });
          Fluttertoast.showToast(
              msg: "Email or Password does not match!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              timeInSecForIos: 1
          );
        }



     }
    }
    else {
      setState(() {
        _progressValue = 0.0;
//        _loading = !_loading;
        _updateProgress();

      });
//      print(response.body);
    }
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
