import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm_app/SiteManager/sidebar/bloc/navigation_block/navigation_bloc.dart';
import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
  final id,name,sitename,siteId;

  SideBarLayout(this.id, this.name,this.sitename,this.siteId);

  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(widget.id,widget.name,widget.sitename,widget.siteId),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(widget.id,widget.name,widget.sitename,widget.siteId),
          ],
        ),
      ),
    );
  }
}


