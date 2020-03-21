import 'package:flutter/material.dart';

import 'SidebarItems/SidebarLayout.dart';

class Sitemain extends StatefulWidget {

  final id,name,sitename,siteId;

  Sitemain(this.id, this.name,this.sitename,this.siteId);

  @override
  _SitemainState createState() => _SitemainState();
}

class _SitemainState extends State<Sitemain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white
      ),
      home: SideBarLayout(widget.id,widget.name,widget.sitename,widget.siteId),
    );
  }
}
