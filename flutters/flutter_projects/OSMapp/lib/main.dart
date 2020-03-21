import 'package:flutter/material.dart';
import 'package:osm_app/login.dart';


void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

//Future<void> main() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  var emailid = prefs.getString('email');
//  print(emailid);
//  runApp(
//    MaterialApp(home: emailid == null ? MyApp() : Dashboardd(),debugShowCheckedModeBanner: false,),
//
//  );
//}
