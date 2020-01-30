import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_app/OngoingSite/SiteImageSlider.dart';
import 'package:osm_app/Utils/read_more_text.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/site_image_list.dart';
import 'package:osm_app/Custom_dialog/customDialog.dart'as customDialog;
import 'package:photo_view/photo_view.dart';

class SiteImages extends StatefulWidget {
  @override
  _SiteImagesState createState() => _SiteImagesState();
}

class _SiteImagesState extends State<SiteImages> {

  List<Datum> dataList = [];
  List<Images> imgList = [];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getFirstView()
    );
  }

  Widget getFirstView(){
    return Container(
        child : FutureBuilder(
            future: _fetchListItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return getRow(index);
                            },
                            childCount: dataList.length,
                          ),
                        ),
                      ],
                    ),
                );
              }
            })
    );
  }


  Widget getRow(int index){
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
                  DateFormat('yyyy-MM-dd').format(dataList[index].photoDate)
                  ,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold
                  ),
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
              dataList[index].desc,
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
        getStories(dataList[index].image),
        SizedBox(height: 10,),
        Divider(height: 0, color: Colors.grey),
      ],
    );
  }

  _fetchListItem() async {
    String dataURL = "http://halfwaiter.com/stock/api/request/siteImg/?id=1";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    dataList.clear();
    imgList.clear();
    for (Datum datum in siteImageListFromJson(response.body).data) {
      dataList.add(datum);
    }

    return dataList;
  }

  Widget getStories(List<Images> img) {
    List<String> imgs = [];
    for (Images imges in img){
      imgs.add(imges.imgName);
    }
    return CarouselSlider(
      height: MediaQuery.of(context).size.height * 0.35,
      initialPage: 0,
      viewportFraction: 1.0,
      reverse: false,
      enableInfiniteScroll: false,
      autoPlayInterval: Duration(seconds: 2),
      autoPlayAnimationDuration: Duration(milliseconds: 2000),
      pauseAutoPlayOnTouch: Duration(seconds: 7),
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      items: imgs.map((imgUrl) {
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
                      ImageDialogbox("http://halfwaiter.com/stock/assets/uploads/site_image/$imgUrl");
                    },
                    child: Container(
                      child: GestureDetector(
                        child: PhotoView(
                          tightMode: true,
                          customSize: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          imageProvider: NetworkImage("http://halfwaiter.com/stock/assets/uploads/site_image/$imgUrl"),
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
                imageProvider: NetworkImage(imgUrl),
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
        );
      },
    );
  }
}