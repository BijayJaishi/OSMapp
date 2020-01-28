import 'package:flutter/material.dart';
import 'package:osm_app/OngoingSite/SiteImageSlider.dart';
import 'package:osm_app/OngoingSite/SiteImages.dart';

import 'BillImages.dart';
import 'BillImagesContent.dart';

class SiteTabView extends StatefulWidget {

  final String title;

  SiteTabView(this.title);

  @override
  _SiteTabViewState createState() => _SiteTabViewState();
}

class _SiteTabViewState extends State<SiteTabView > with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        iconTheme: IconThemeData(
          color: Colors.black,
          //change your color here
        ),
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("${widget.title}", style: TextStyle(color: Colors.black),),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.yellowAccent, tabs: [

//            new Tab(icon: new Icon(Icons.call)),
//            new Tab(
//              icon: new Icon(Icons.chat),
//            ),
//            new Tab(
//              icon: new Icon(Icons.notifications),
//            )
        new Tab(child:Text("Site Images")),
        new Tab(
            child:Text("Bill Images")
        ),
        new Tab(
            child:Text("Stock Left")
        )

         ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          getSiteImages(),
          getBillImages(),
          new Text("This is chat Tab View"),

        ],
        controller: _tabController,),
    );


  }

  Widget getSiteImages(){

    return SiteImages();
  }

  Widget getBillImages(){

    return BillImages();
  }
}