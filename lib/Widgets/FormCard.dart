import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/Dashboard/Dashboardd.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
//  bool _isSelected = false;

  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = !rememberMe;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

//  void _radio() {
//    setState(() {
//      _isSelected = !_isSelected;
//    });
//  }
//
//  Widget radioButton(bool isSelected) => Container(
//    width: 16.0,
//    height: 16.0,
//    padding: EdgeInsets.all(2.0),
//    decoration: BoxDecoration(
//        shape: BoxShape.circle,
//        border: Border.all(width: 2.0, color: Colors.black)),
//    child: isSelected
//        ? Container(
//      width: double.infinity,
//      height: double.infinity,
//      decoration:
//      BoxDecoration(shape: BoxShape.rectangle, color: Colors.black),
//    )
//        : Container(),
//  );
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(700),
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
            TextField(
              decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("PassWord",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
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
                      onTap: () {
                        Navigator.pop(context,
                            true); // It worked for me instead of above line
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboardd()),
                        );
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
    );
  }
}
