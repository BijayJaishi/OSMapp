import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_app/OngoingSite/SiteTab/SiteImageSlider.dart';
import 'package:osm_app/Utils/read_more_text.dart';
import 'package:http/http.dart' as http;
import 'package:osm_app/model_classes/TabViewModels/site_image_list.dart';
import 'package:osm_app/Custom_dialog/customDialog.dart' as customDialog;
import 'package:photo_view/photo_view.dart';

class SiteImages extends StatefulWidget {
  final String siteId;

  SiteImages(this.siteId);
  @override
  _SiteImagesState createState() => _SiteImagesState();
}

class _SiteImagesState extends State<SiteImages> {
  List<Datum> dataList = [];
  List<Images> imgList = [];
  var current = [];


  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getFirstView());
  }

  Widget getFirstView() {
    return Container(
        child: FutureBuilder(
            future: _fetchListItem(widget.siteId),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          if (snapshot.error == null) ...[
                            CircularProgressIndicator(),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              snapshot.error == null
                                  ? "Please Wait ..."
                                  : "There Is No Any Site Image",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                );
              } else {
                return Container(
//                  color: Colors.amber,
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
            }));
  }

  Widget getRow(int index) {
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
                  DateFormat('yyyy-MM-dd').format(dataList[index].photoDate),
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
            padding:
                EdgeInsets.only(left: 10.0, right: 10.0, bottom: 4.0, top: 10),
            child: ReadMoreText(
              dataList[index].desc,
              style: TextStyle(
                  fontFamily: "Poppins", fontWeight: FontWeight.normal),
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: '...Show more',
              trimExpandedText: ' show less',
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        getStories(dataList[index].image, index),
        SizedBox(
          height: 10,
        ),
        Divider(height: 0, color: Colors.grey),
      ],
    );
  }

  _fetchListItem(site) async {
    String dataURL = "https://onlinesitemanager.com/adminpanel/api/request/siteImg/?id=$site";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Re@!$TATE$T0Ck"});
    dataList.clear();
    imgList.clear();
    for (Datum datum in siteImageListFromJson(response.body).data) {
      dataList.add(datum);
    }

    return dataList;
  }

  Widget getStories(List<Images> img, int pos) {
    List<String> imgs = [];


    current.add(pos == 0 ? 0 : 0);

    for (Images imges in img) {
      imgs.add(imges.imgName);
    }
    return Stack(
      children: <Widget>[
        CarouselSlider(
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
              current[pos] = index;
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
                      child: InkWell(
                        splashColor: Colors.blueAccent,
                        onTap: () {
                          ImageDialogbox(
                              "https://onlinesitemanager.com/adminpanel/assets/uploads/site_image/$imgUrl");
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                             width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.33,
                             decoration: BoxDecoration(

                               image: DecorationImage(

                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://onlinesitemanager.com/adminpanel/assets/uploads/site_image/$imgUrl")),

                               ),
                             ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          top: 10.0,
          left: 0.0,
          right: 0.0,
//      bottom: 10.0,
          child: Wrap(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.5)),
                  color: Colors.black54,
                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                  //alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${current[pos]+1}/${img.length}',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
//      child:
    );
  }

  Widget ImageDialogbox(imgUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
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
