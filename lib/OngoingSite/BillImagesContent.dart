import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class BillContent extends StatefulWidget {
  @override
  _BillContentState createState() => _BillContentState();
}

class _BillContentState extends State<BillContent> {
  CarouselSlider carouselSlider;
  int _current = 0;
  var post = "50";
  var followers = "500";
  bool isClicked = false;
  Color storiesColor = Colors.red;
  Color recommendColor = Colors.black;
  Color followColor = Colors.black;
  DateTime selectedDate = DateTime.now();

  List<String> photos = [
    'assets/images/billone.jpg',
    'assets/images/billtwo.jpg',
    'assets/images/billone.jpg',
    'assets/images/billtwo.jpg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return getStories();
  }

  Widget getStories() {
    return CarouselSlider(
      height: MediaQuery.of(context).size.height * 0.35,
      initialPage: 0,
      viewportFraction: 1.0,
//      enlargeCenterPage: true,
//      autoPlay: true,
      reverse: false,
      enableInfiniteScroll: true,
      autoPlayInterval: Duration(seconds: 2),
      autoPlayAnimationDuration: Duration(milliseconds: 2000),
      pauseAutoPlayOnTouch: Duration(seconds: 7),
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      items: photos.map((imgUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
//              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      ImageDialogbox(imgUrl);
                    },
                    child: Container(
                      child : GestureDetector(
                          child: PhotoView(
                            tightMode: true,
                            customSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
//                            minScale: PhotoViewComputedScale.contained * 0.1,
//                            maxScale: 1.0,
                            imageProvider: AssetImage(imgUrl),
                            backgroundDecoration: BoxDecoration(color: Colors.white),
                          ),
                      ),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
  Widget ImageDialogbox(imgUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhotoView(
                      imageProvider: AssetImage(imgUrl),
                      backgroundDecoration: BoxDecoration(color: Colors.transparent),
                    ),
              ),
          ),
        );
      },
    );
  }
}
