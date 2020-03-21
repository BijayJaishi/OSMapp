import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:osm_app/Custom_dialog/customDialog.dart'as customDialog;


class SiteImageContent extends StatefulWidget {
  List<String> photos = [];

  SiteImageContent(this.photos);

  @override
  SiteImageContentState createState() => SiteImageContentState();
}

class SiteImageContentState extends State<SiteImageContent> {
  CarouselSlider carouselSlider;
  int _current = 0;
  var post = "50";
  var followers = "500";
  bool isClicked = false;
  Color storiesColor = Colors.red;
  Color recommendColor = Colors.black;
  Color followColor = Colors.black;
  DateTime selectedDate = DateTime.now();

//  List<String> photos = [
//    'assets/images/consimgone.jpg',
//    'assets/images/consimgtwo.jpg',
//    'assets/images/consimgone.jpg',
//    'assets/images/consimgtwo.jpg',
//  ];

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
      items: widget.photos.map((imgUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      ImageDialogbox("https://onlinesitemanager.com/adminpanel/assets/uploads/site_image/$imgUrl");
                    },
                    child: Container(
                      child: GestureDetector(
                        child: PhotoView(
                          tightMode: true,
                          customSize: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          imageProvider: NetworkImage("https://onlinesitemanager.com/adminpanel/assets/uploads/site_image/$imgUrl"),
                          backgroundDecoration:
                              BoxDecoration(color: Colors.white),
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
          child: customDialog.Dialog(
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
