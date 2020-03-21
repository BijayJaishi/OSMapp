import 'dart:async';

import 'package:flutter/material.dart';
import 'package:osm_app/login.dart';


class SplashScreenexample extends StatefulWidget {
  @override
  _SplashScreenexampleState createState() => _SplashScreenexampleState();
}

class _SplashScreenexampleState extends State<SplashScreenexample> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () =>Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MyApp())
    ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

//                      Container(
//                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
//                        height: 300,
//                        width: double.infinity,
//                        child: Image.asset(
//                          "assets/images/logofinalosm.png",
//                          fit: BoxFit.cover,
//                        ),
//                      ),

                      Card(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.only(left:15.0,top:10),
                          child: FadeInImage(
                            alignment: Alignment.centerRight,
                            placeholder: AssetImage("assets/images/logofinalosm.png"),
                            image: AssetImage("assets/images/logofinalosm.png"),
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: 180,
                          ),
                        ),
                      ),
//                      CircleAvatar(
//                        backgroundColor: Colors.white,
//                        radius: 30.0,
//
//                        child: FadeInImage(
//                          alignment: Alignment.center,
//                          placeholder: AssetImage("assets/images/logofinalosm.png"),
//                          image: AssetImage("assets/images/logofinalosm.png"),
//                          fit: BoxFit.cover,
//                          width: double.maxFinite,
//                          height: double.infinity,
//                        ),
////                        child: Image.asset(
////                          "assets/images/logofinalosm.png",
////                          fit: BoxFit.cover,
////                          width: 600,
////                        ),
////                        child: Icon(
////                          Icons.shopping_cart,
////                          color: Colors.greenAccent,
////                          size: 50.0,
////                        ),
//                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                       "Online Site Manager",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "From",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text(
                        "K. And K. Tech Pvt. Ltd. ",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}