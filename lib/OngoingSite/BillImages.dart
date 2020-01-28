import 'package:flutter/material.dart';
import 'package:osm_app/OngoingSite/BillImagesContent.dart';
import 'package:osm_app/Utils/read_more_text.dart';

class BillImages extends StatefulWidget {
  @override
  _BillImagesState createState() => _BillImagesState();
}

class _BillImagesState extends State<BillImages> {
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
                        child: ReadMoreText("K and K Construction Suppliers",
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
                    BillContent(),
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

//import 'package:flutter/material.dart';
//import 'package:osm_app/OngoingSite/BillImagesContent.dart';
//import 'package:osm_app/OngoingSite/SiteImageSlider.dart';
//class BillImages extends StatefulWidget {
//  @override
//  _BillImagesState createState() => _BillImagesState();
//}
//
//class _BillImagesState extends State<BillImages> {
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
//        title: Text("Bill Images", style: TextStyle(color: Colors.black),),
//      ),
//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            top: 20,
//            left: 0,
//            right: 0,
//            child:  Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                RaisedButton(
//                  onPressed: () => _selectDate(context),
//                  child: Text('Select date'),
//                ),
//                SizedBox(width: 8.0,),
//                Text("${selectedDate.toLocal()}".split(' ')[0],style:TextStyle(fontSize: 18) ,),
//              ],
//            ),
//          ),
//          Positioned(
//
//            right: 0,
//            left: 0,
//            bottom: 85,
//            child: BillContent(),
//          )
//        ],
//      ),
//    );
//  }
//}

//previous codes for image

//import 'package:flutter/material.dart';
//import 'package:photo_view/photo_view.dart';
//
//import 'ImageFullScreen.dart';
//
//class BillCarousel extends StatefulWidget {
//
//  @override
//  _BillCarouselState createState() => _BillCarouselState();
//}
//
//class _BillCarouselState extends State<BillCarousel> {
//  int photoIndex = 0;
//  List<String> photos = [
//      'assets/images/billone.jpg',
//      'assets/images/billtwo.jpg',
//      'assets/images/billone.jpg',
//      'assets/images/billtwo.jpg',
//    ];
//
//  void _previousImage() {
//    setState(() {
//      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
//    });
//  }
//
//  void _nextImage() {
//    setState(() {
//      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : 0;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Bill Images"),
//        centerTitle: true,
//      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Center(
//            child: Stack(
//              children: <Widget>[
//                GestureDetector(
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) =>
//                              MySecondScreen(photos: photos[photoIndex]),
//                        ));
//                  },
//                  child: Container(
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(25.0),
//                      image: DecorationImage(
//                          image: AssetImage(photos[photoIndex])),
//                    ),
//                    height: 400,
//                    width: 300,
//                  ),
//                ),
//                Positioned(
//                    bottom: 10.0,
//                    left: 25.0,
//                    right: 25.0,
//                    child: SelectedPhoto(
//                      numberOfDots: photos.length,
//                      photoIndex: photoIndex,
//                    )),
//              ],
//            ),
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              RaisedButton(
//                child: Text('Previous'),
//                onPressed: _previousImage,
//                elevation: 5.0,
//                color: Colors.blue[200],
//              ),
//              SizedBox(width: 10.0),
//              RaisedButton(
//                child: Text('Next'),
//                onPressed: _nextImage,
//                elevation: 5.0,
//                color: Colors.blue[200],
//              ),
//            ],
//          )
//        ],
//      ),
//    );
//  }
//}
//
//class SelectedPhoto extends StatelessWidget {
//  final int numberOfDots;
//  final int photoIndex;
//
//  SelectedPhoto({this.numberOfDots, this.photoIndex});
//
//  Widget _inactivePhoto() {
//    return Container(
//      child: Padding(
//        padding: EdgeInsets.only(left: 3.0, right: 3.0),
//        child: Container(
//          height: 8.0,
//          width: 8.0,
//          decoration: BoxDecoration(
//              color: Colors.blue[100],
//              borderRadius: BorderRadius.circular(4.0)),
//        ),
//      ),
//    );
//  }
//
//  Widget _activePhoto() {
//    return Container(
//      child: Padding(
//        padding: EdgeInsets.only(left: 5.0, right: 5.0),
//        child: Container(
//          height: 10.0,
//          width: 10.0,
//          decoration: BoxDecoration(
//              color: Colors.blue,
//              borderRadius: BorderRadius.circular(5.0),
//              boxShadow: [
//                BoxShadow(
//                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
//              ]),
//        ),
//      ),
//    );
//  }
//
//  List<Widget> _buildDots() {
//    List<Widget> dots = [];
//    for (int i = 0; i < numberOfDots; i++) {
//      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
//    }
//    return dots;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: _buildDots(),
//      ),
//    );
//  }
//}

//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:flutter/material.dart';
//import 'package:osm_app/OngoingSite/ImageFullScreen.dart';
//
//class BillCarousel extends StatefulWidget {
//  _BillCarouselState createState() => new _BillCarouselState();
//}
//
//class _BillCarouselState extends State<BillCarousel> with SingleTickerProviderStateMixin {
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
//      'assets/images/billone.jpg',
//      'assets/images/billtwo.jpg',
//      'assets/images/billone.jpg',
//      'assets/images/billtwo.jpg',
//    ];
//
//
//    _previousImage() {
//      setState(() {
//        photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
//        return photoIndex;
//      });
//    }
//
//     _nextImage() {
//      setState(() {
//        photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : 0;
//        return photoIndex;
//      });
//    }
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
//    _previousImage();
//    _nextImage();
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
//
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
////      Widget banner = new Padding(
////        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
////        child: new Container(
////          decoration: BoxDecoration(
////            borderRadius: BorderRadius.only(
////                topLeft: Radius.circular(15.0),
////                bottomRight: Radius.circular(15.0)),
////            color: Colors.amber.withOpacity(0.5),
////          ),
////          padding: const EdgeInsets.all(10.0),
////          child: new Text(
////            'Banner on top of carousel',
////            style: TextStyle(
////              fontSize: animation.value, //18.0,
////              //color: Colors.white,
////            ),
////          ),
////        ),
////        // ),
////        //  ),
////      );
//
//      return new Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          iconTheme: IconThemeData(
//            color: Colors.black,
//            //change your color here
//          ),
//          backgroundColor: Colors.deepOrangeAccent,
//          title: Text("Bills Images", style: TextStyle(color: Colors.black),),
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
//  dispose() {
//    controller.dispose();
//    super.dispose();
//  }
//}

//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:flutter/material.dart';
//
//class BillCarousel extends StatefulWidget {
//  BillCarouselState createState() => new BillCarouselState();
//}
//
//class BillCarouselState extends State<BillCarousel> with SingleTickerProviderStateMixin {
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
//  List imgList = [
//    AssetImage("assets/images/consimgone.jpg"),
//    AssetImage("assets/images/consimgtwo.jpg"),
//    AssetImage("assets/images/consimgone.jpg"),
//    AssetImage("assets/images/consimgtwo.jpg"),
//  ];
//
//
//  int photoinde =0;
//  List<String> photos = [
//    'assets/images/consimgone.jpg',
//    'assets/images/consimgtwo.jpg',
//    'assets/images/consimgone.jpg',
//    'assets/images/consimgtwo.jpg',
//  ];
//
//  void _previousImage() {
//    setState(() {
//      photoinde = photoinde > 0 ? photoinde - 1 : 0;
//    });
//  }
//
//  void _nextImage() {
//    setState(() {
//      photoinde = photoinde < photos.length - 1 ? photoinde + 1 : 0;
//    });
//  }
//
//  List<T> map<T>(List list, Function handler) {
//    List<T> result = [];
//    for (var i = 0; i < list.length; i++) {
//      result.add(handler(i, list[i]));
//    }
//    return result;
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    double screenHeight = MediaQuery
//        .of(context)
//        .size
//        .height;
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
//    Widget carousel = new Carousel(
//      autoplay: true,
//      boxFit: BoxFit.cover,
//     images: [
//
//        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//          Container(
//            margin: EdgeInsets.all(15.0),
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10.0),
//                boxShadow: [
//                  BoxShadow(
//                      color: Color.fromARGB(80, 0, 0, 0),
//                      blurRadius: 5.0,
//                      offset: Offset(5.0, 5.0))
//                ],
//                image:
//                DecorationImage(fit: BoxFit.fill,
//                    image: AssetImage('assets/images/billone.jpg'))),
//            width: MediaQuery
//                .of(context)
//                .size
//                .width,
//            height: screenHeight - 500,
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
//                  alignment: Alignment.bottomRight,
//                  child: Icon(
//                    Icons.favorite,
//                    color: Colors.redAccent,
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: const ListTile(
//              leading: Icon(Icons.album),
//              title: Text('Gitti Bill'),
//              subtitle:
//              Text('Issued with  Rs 200000 '),
//            ),
//          ),
//        ]),
//        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//          Container(
//            margin: EdgeInsets.all(15.0),
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10.0),
//                boxShadow: [
//                  BoxShadow(
//                      color: Color.fromARGB(80, 0, 0, 0),
//                      blurRadius: 5.0,
//                      offset: Offset(5.0, 5.0))
//                ],
//                image:
//                DecorationImage(fit: BoxFit.fill,
//                    image: AssetImage('assets/images/billtwo.jpg'))),
//            width: MediaQuery
//                .of(context)
//                .size
//                .width,
//            height: screenHeight - 500,
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
//                  alignment: Alignment.bottomRight,
//                  child: Icon(
//                    Icons.favorite,
//                    color: Colors.redAccent,
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: const ListTile(
//              leading: Icon(Icons.album),
//              title: Text('Gitti Bill'),
//              subtitle:
//              Text('Issued with  Rs 200000 '),
//            ),
//          ),
//        ]),
//        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//          Container(
//            margin: EdgeInsets.all(15.0),
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10.0),
//                boxShadow: [
//                  BoxShadow(
//                      color: Color.fromARGB(80, 0, 0, 0),
//                      blurRadius: 5.0,
//                      offset: Offset(5.0, 5.0))
//                ],
//                image:
//                DecorationImage(fit: BoxFit.fill,
//                    image: AssetImage('assets/images/billone.jpg'))),
//            width: MediaQuery
//                .of(context)
//                .size
//                .width,
//            height: screenHeight - 500,
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
//                  alignment: Alignment.bottomRight,
//                  child: Icon(
//                    Icons.favorite,
//                    color: Colors.redAccent,
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: const ListTile(
//              leading: Icon(Icons.album),
//              title: Text('Gitti Bill'),
//              subtitle:
//              Text('Issued with  Rs 200000 '),
//            ),
//          ),
//        ]),
//        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//          Container(
//            margin: EdgeInsets.all(15.0),
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10.0),
//                boxShadow: [
//                  BoxShadow(
//                      color: Color.fromARGB(80, 0, 0, 0),
//                      blurRadius: 5.0,
//                      offset: Offset(5.0, 5.0))
//                ],
//                image:
//                DecorationImage(fit: BoxFit.fill,
//                    image: AssetImage('assets/images/billtwo.jpg'))),
//            width: MediaQuery
//                .of(context)
//                .size
//                .width,
//            height: screenHeight - 500,
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(margin: EdgeInsets.only(bottom: 10.0, right: 20.0),
//                  alignment: Alignment.bottomRight,
//                  child: Icon(
//                    Icons.favorite,
//                    color: Colors.redAccent,
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: const ListTile(
//              leading: Icon(Icons.album),
//              title: Text('Gitti Bill'),
//              subtitle:
//              Text('Issued with  Rs 200000 '),
//            ),
//          ),
//        ]),
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
//      ],
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(seconds: 1),
//    );
//
//    Widget banner = new Padding(
//      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
//      child: new Container(
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(15.0),
//              bottomRight: Radius.circular(15.0)),
//          color: Colors.amber.withOpacity(0.5),
//        ),
//        padding: const EdgeInsets.all(10.0),
//        child: new Text(
//          'Banner on top of carousel',
//          style: TextStyle(
//            fontSize: animation.value, //18.0,
//            //color: Colors.white,
//          ),
//        ),
//      ),
//      // ),
//      //  ),
//    );
//
//    return new Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        iconTheme: IconThemeData(
//          color: Colors.black,
//          //change your color here
//        ),
//        backgroundColor: Colors.deepOrangeAccent,
//        title: Text("Bills Images", style: TextStyle(color: Colors.black),),
//      ),
//      body: new Container(
//        margin: EdgeInsets.all(0.0), //padding: const EdgeInsets.all(20.0),
//        height: screenHeight,
//        child: new ClipRRect(
//          borderRadius: BorderRadius.circular(0.0),
//          child: new Stack(
//            children: [
//              Positioned(
//                top: 150,
//                left: 0,
//                right: 0,
//                bottom: 0,
//                child: carousel,
//              ),
//              Positioned(
//                top: 25,
//                left: 0,
//                right: 0,
//                bottom: 0,
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    SizedBox(height: 12.0,),
//                    Text("${selectedDate.toLocal()}".split(' ')[0],style:TextStyle(fontSize: 18) ,),
//                    SizedBox(height: 12.0,),
//                    RaisedButton(
//                      onPressed: () => _selectDate(context),
//                      child: Text('Select date'),
//                    ),
//                  ],
//                ),
//              ),
//
//              //banner,
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  dispose() {
//    controller.dispose();
//    super.dispose();
//  }
//}
//
//
