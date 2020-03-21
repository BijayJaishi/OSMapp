import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm_app/SiteManager/sidebar/Pages/DashBoard/SupplierListContent.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';

class SupplierList extends StatefulWidget with NavigationStates{
  final siteId;

  SupplierList(this.siteId);

  @override
  _SupplierListState createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              elevation: 5.0,
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
                //change your color here
              ),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: Card(
                elevation: 5,
                margin: EdgeInsets.all(0.0),
                color: Colors.white70,
                child: new FlexibleSpaceBar(centerTitle: true,
                  background: Center(
                    child: Container(
                      height: 800,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 9),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logofinalosm.png'),
                        ),
                      ),
                    ),
                  ),
                  title: new Text("Supplier List",
                      style: TextStyle(
                        color: Colors.black,
//                        fontWeight: FontWeight.bold,
//                        fontFamily: "Poppins-Bold"
                      )),
                ),
              ),
            ),
          ];
        },
        body: mainContent(),
      ),
    );
  }

  Widget mainContent() {
    return SupplierListContent(widget.siteId);
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
