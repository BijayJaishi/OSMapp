import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ongoingsitecontent extends StatefulWidget {
  @override
  _ongoingsitecontentState createState() => _ongoingsitecontentState();
}

class _ongoingsitecontentState extends State<ongoingsitecontent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        getCard(context),
      ],
    );
  }

  Widget getCard(context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height-235,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: getElementList(),
    );
  }
}

List<String> getListElement() {
  var items = List<String>.generate(1000, (counter) => "$counter.    Site one");
  return items;
}
  Widget getElementList() {
    var listItems = getListElement();
    var listView = ListView.builder(itemBuilder:(context,index) {
      return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white10, width: 1),
          ),
        margin: EdgeInsets.only(top:6.0,left:8,right:8),
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
//          leading: Icon(Icons.arrow_right),
                title: Text(
                    listItems[index+1]
                ),
                // onTap: () => showSnackbar(context) ,
                onTap:(){
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text("${listItems[index]} was tapped"),
//        ));

                  showSnackBar(context, listItems[index+1]);
                },
              ),
            ],
          ),
        ),
      );
    });
    return listView;
  }

void showSnackBar(BuildContext context,String item) {
  final scaffold = Scaffold.of(context);
  var snackBar = SnackBar(
    content:Text('$item was clicked'),
    action: SnackBarAction(
        label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  );
  Scaffold.of(context).showSnackBar(snackBar);

}
