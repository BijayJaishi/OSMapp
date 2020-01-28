import 'package:flutter/material.dart';
import 'package:osm_app/OngoingSite/SiteImageSlider.dart';
import 'package:osm_app/Utils/read_more_text.dart';

class SiteImages extends StatefulWidget {
  @override
  _SiteImagesState createState() => _SiteImagesState();
}

class _SiteImagesState extends State<SiteImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {

                return Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 8),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              "2020/02/05",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 4.0, top: 10),
                        child: ReadMoreText(
                          'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal),
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...Show more',
                          trimExpandedText: ' show less',
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    SiteImageContent(),
                    SizedBox(height: 10,),
                    Divider(height: 0, color: Colors.grey),
                  ],
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}





//import 'package:flutter/material.dart';
//import 'package:osm_app/OngoingSite/SiteImageSlider.dart';
//class SiteImages extends StatefulWidget {
//  @override
//  _SiteImagesState createState() => _SiteImagesState();
//}
//
//class _SiteImagesState extends State<SiteImages> {
//  DateTime selectedDate = DateTime.now();
//
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        iconTheme: IconThemeData(
//          color: Colors.black,
//          //change your color here
//        ),
//        backgroundColor: Colors.deepOrangeAccent,
//        title: Text("Site Images", style: TextStyle(color: Colors.black),),
//      ),
//      body: Stack(
//        children: <Widget>[
//      Positioned(
//                  top: 15,
//                  left: 0,
//                  right: 0,
//                  child:  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
////              SizedBox(height: 12.0,),
//                      RaisedButton(
//                        onPressed: () => _selectDate(context),
//                        child: Text('Select date'),
//                      ),
//                      SizedBox(width: 8.0,),
//                      Text("${selectedDate.toLocal()}".split(' ')[0],style:TextStyle(fontSize: 18) ,),
////              SizedBox(height: 12.0,),
//
//                    ],
//                  ),
//                ),
//          Positioned(
//
//            right: 0,
//            left: 0,
//            bottom: 35,
//            child: stories(),
//          )
//        ],
//      ),
//    );
//  }
//}
//
//




//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:flutter/material.dart';
//import 'package:osm_app/OngoingSite/ImageFullScreen.dart';
//
//class ImageCarousel extends StatefulWidget {
//  _ImageCarouselState createState() => new _ImageCarouselState();
//}
//
//class _ImageCarouselState extends State<ImageCarousel> with SingleTickerProviderStateMixin {
//
//  DateTime selectedDate = DateTime.now();
//
//  Animation<double> animation;
//  AnimationController controller;
//
//  initState() {
//    super.initState();
//    controller = new AnimationController(
//        duration: const Duration(milliseconds: 2000), vsync: this);
//    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
//      ..addListener(() {
//        setState(() {
//          // the state that has changed here is the animation object’s value
//        });
//      });
//    controller.forward();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    double screenHeight = MediaQuery
//        .of(context)
//        .size
//        .height;
//
//    int photoIndex = 0;
//    List<String> photos = [
//      'assets/images/consimgone.jpg',
//      'assets/images/consimagetwo.jpg',
//      'assets/images/consimgone.jpg',
//      'assets/images/consimagetwo.jpg',
//    ];
//
//
//    Future<Null> _selectDate(BuildContext context) async {
//      final DateTime picked = await showDatePicker(
//          context: context,
//          initialDate: selectedDate,
//          firstDate: DateTime(2015, 8),
//          lastDate: DateTime(2101));
//      if (picked != null && picked != selectedDate)
//        setState(() {
//          selectedDate = picked;
//        });
//    }
//
//      Widget carousel = new Carousel(
//        autoplay: true,
//        boxFit: BoxFit.cover,
//        images: [
//
//          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//            GestureDetector(
//              child: InkWell(
//                child: Container(
//                  margin: EdgeInsets.all(15.0),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(18.0),
//                      boxShadow: [
//                        BoxShadow(
//                            color: Color.fromARGB(80, 0, 0, 0),
//                            blurRadius: 5.0,
//                            offset: Offset(5.0, 5.0))
//                      ],
//                      image:
//                      DecorationImage(fit: BoxFit.fill,image: AssetImage(photos[photoIndex]))),
//
//                  width: MediaQuery
//                      .of(context)
//                      .size
//                      .width,
//                  height: screenHeight - 500,
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    mainAxisSize: MainAxisSize.max,
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                      Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
//                        alignment: Alignment.bottomRight,
//                        child: Icon(
//                          Icons.favorite,
//                          color: Colors.redAccent,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),onTap: (){
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) =>
//                          MySecondScreen(photos: photos[photoIndex]),
//                    ));
//              },
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: const ListTile(
//                leading: Icon(Icons.album),
//                title: Text('The Enchanted Nightingale'),
//                subtitle:
//                Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//              ),
//            ),
//          ]),
////          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
////            Container(
////              margin: EdgeInsets.all(15.0),
////              decoration: BoxDecoration(
////                  borderRadius: BorderRadius.circular(18.0),
////                  boxShadow: [
////                    BoxShadow(
////                        color: Color.fromARGB(80, 0, 0, 0),
////                        blurRadius: 5.0,
////                        offset: Offset(5.0, 5.0))
////                  ],
////                  image:
////                  DecorationImage(fit: BoxFit.fill,
////                      image: AssetImage('assets/images/consimgtwo.jpg'))),
////              width: MediaQuery
////                  .of(context)
////                  .size
////                  .width,
////              height: screenHeight - 500,
////              child: Row(
////                crossAxisAlignment: CrossAxisAlignment.stretch,
////                mainAxisSize: MainAxisSize.max,
////                mainAxisAlignment: MainAxisAlignment.end,
////                children: <Widget>[
////                  Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
////                    alignment: Alignment.bottomRight,
////                    child: Icon(
////                      Icons.favorite,
////                      color: Colors.redAccent,
////                    ),
////                  ),
////                ],
////              ),
////            ),
////            Padding(
////              padding: const EdgeInsets.all(8.0),
////              child: const ListTile(
////                leading: Icon(Icons.album),
////                title: Text('The Enchanted Nightingale'),
////                subtitle:
////                Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
////              ),
////            ),
////          ]),
////          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
////            Container(
////              margin: EdgeInsets.all(15.0),
////              decoration: BoxDecoration(
////                  borderRadius: BorderRadius.circular(18.0),
////                  boxShadow: [
////                    BoxShadow(
////                        color: Color.fromARGB(80, 0, 0, 0),
////                        blurRadius: 5.0,
////                        offset: Offset(5.0, 5.0))
////                  ],
////                  image:
////                  DecorationImage(fit: BoxFit.fill,
////                      image: AssetImage('assets/images/consimgone.jpg'))),
////              width: MediaQuery
////                  .of(context)
////                  .size
////                  .width,
////              height: screenHeight - 500,
////              child: Row(
////                crossAxisAlignment: CrossAxisAlignment.stretch,
////                mainAxisSize: MainAxisSize.max,
////                mainAxisAlignment: MainAxisAlignment.end,
////                children: <Widget>[
////                  Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
////                    alignment: Alignment.bottomRight,
////                    child: Icon(
////                      Icons.favorite,
////                      color: Colors.redAccent,
////                    ),
////                  ),
////                ],
////              ),
////            ),
////            Padding(
////              padding: const EdgeInsets.all(8.0),
////              child: const ListTile(
////                leading: Icon(Icons.album),
////                title: Text('The Enchanted Nightingale'),
////                subtitle:
////                Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
////              ),
////            ),
////          ]),
////          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
////            Container(
////              margin: EdgeInsets.all(15.0),
////              decoration: BoxDecoration(
////                  borderRadius: BorderRadius.circular(18.0),
////                  boxShadow: [
////                    BoxShadow(
////                        color: Color.fromARGB(80, 0, 0, 0),
////                        blurRadius: 5.0,
////                        offset: Offset(5.0, 5.0))
////                  ],
////                  image:
////                  DecorationImage(fit: BoxFit.fill,
////                      image: AssetImage('assets/images/consimgtwo.jpg'))),
////              width: MediaQuery
////                  .of(context)
////                  .size
////                  .width,
////              height: screenHeight - 500,
////              child: Row(
////                crossAxisAlignment: CrossAxisAlignment.stretch,
////                mainAxisSize: MainAxisSize.max,
////                mainAxisAlignment: MainAxisAlignment.end,
////                children: <Widget>[
////                  Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
////                    alignment: Alignment.bottomRight,
////                    child: Icon(
////                      Icons.favorite,
////                      color: Colors.redAccent,
////                    ),
////                  ),
////                ],
////              ),
////            ),
////            Padding(
////              padding: const EdgeInsets.all(8.0),
////              child: const ListTile(
////                leading: Icon(Icons.album),
////                title: Text('The Enchanted Nightingale'),
////                subtitle:
////                Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
////              ),
////            ),
////          ]),
////        Card(
////            child:
////            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
////              const ListTile(
////                leading: Icon(Icons.album),
////                title: Text('The Enchanted Nightingale'),
////                subtitle:
////                Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
////              ),
////              Image.asset(
////                  'assets/images/consimgone.jpg'),
////            ])),
////        new AssetImage('assets/images/consimgone.jpg'),
////        new AssetImage('assets/images/consimgtwo.jpg'),
////        new AssetImage('assets/images/consimgone.jpg'),
////        new AssetImage('assets/images/consimgtwo.jpg'),
//        ],
//        animationCurve: Curves.fastOutSlowIn,
//        animationDuration: Duration(seconds: 1),
//      );
//
//      Widget banner = new Padding(
//        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
//        child: new Container(
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(15.0),
//                bottomRight: Radius.circular(15.0)),
//            color: Colors.amber.withOpacity(0.5),
//          ),
//          padding: const EdgeInsets.all(10.0),
//          child: new Text(
//            'Banner on top of carousel',
//            style: TextStyle(
//              fontSize: animation.value, //18.0,
//              //color: Colors.white,
//            ),
//          ),
//        ),
//        // ),
//        //  ),
//      );
//
//      return new Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          iconTheme: IconThemeData(
//            color: Colors.black,
//            //change your color here
//          ),
//          backgroundColor: Colors.deepOrangeAccent,
//          title: Text("Sites Images", style: TextStyle(color: Colors.black),),
//        ),
//        body: new Container(
//          margin: EdgeInsets.all(0.0), //padding: const EdgeInsets.all(20.0),
//          height: screenHeight,
//          child: new ClipRRect(
//            borderRadius: BorderRadius.circular(0.0),
//            child: new Stack(
//              children: [
//                Positioned(
//                  top: 150,
//                  left: 0,
//                  right: 0,
//                  bottom: 0,
//                  child: carousel,
//                ),
//                Positioned(
//                  top: 25,
//                  left: 0,
//                  right: 0,
//                  bottom: 0,
//                  child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      SizedBox(height: 12.0,),
//                      Text("${selectedDate.toLocal()}".split(' ')[0],style:TextStyle(fontSize: 18) ,),
//                      SizedBox(height: 12.0,),
//                      RaisedButton(
//                        onPressed: () => _selectDate(context),
//                        child: Text('Select date'),
//                      ),
//                    ],
//                  ),
//                ),
//
//                //banner,
//              ],
//            ),
//          ),
//        ),
//      );
//    }
//
//    Widget getDate() {
//      DateTime selectedDate = DateTime.now();
//
//      Future<Null> _selectDate(BuildContext context) async {
//        final DateTime picked = await showDatePicker(
//            context: context,
//            initialDate: selectedDate,
//            firstDate: DateTime(2015, 8),
//            lastDate: DateTime(2101));
//        if (picked != null && picked != selectedDate)
//          setState(() {
//            selectedDate = picked;
//          });
//      }
//    }
//
//  dispose() {
//    controller.dispose();
//    super.dispose();
//  }
//}
//










