import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/Dashboard/Dashboardd.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  final formkey = GlobalKey<FormState>();
  String _email, _password;

//  bool _isSelected = false;
  _submit() {
//    if (formkey.currentState.validate()) {
//      formkey.currentState.save();
//      print(_email);
//      print(_password);
      Navigator.pop(context,
          true); // It worked for me instead of above line
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboardd()),
      );

//    }
  }

  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = !rememberMe;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(785),
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
        child: Form(
          key: formkey,
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
                decoration: InputDecoration(labelText: 'Email'),
                validator: (input) =>
                !input.contains('@') ? 'Please enter valid email' : null,
                keyboardType: TextInputType.emailAddress,
                onSaved: (input) => _email = input,
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("PassWord",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (input) =>
                input.length < 6 ? 'Must be atleast 6 character' : null,
                onSaved: (input) => _password = input,
                obscureText: true,
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
                          _submit();
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
    );
  }
}
