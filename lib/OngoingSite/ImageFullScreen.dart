import 'package:flutter/material.dart';
import 'package:osm_app/OngoingSite/SiteImages.dart';
import 'package:photo_view/photo_view.dart';
class MySecondScreen extends StatelessWidget {
  final String photos;

  MySecondScreen({Key key, @required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
//        appBar: AppBar(
//          title: Text('MySecondScreen'),
//          centerTitle: true,
//        ),
        body: GestureDetector(
            child: PhotoView(
              imageProvider: AssetImage(photos),
              backgroundDecoration: BoxDecoration(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.pop(
//                  context, MaterialPageRoute(builder: (context) => ImageCarousel()));
            }),
      );
  }
}