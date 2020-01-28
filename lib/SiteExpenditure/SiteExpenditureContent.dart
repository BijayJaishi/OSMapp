import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class siteexpenditurecontent extends StatefulWidget {
  @override
  _siteexpenditureState createState() => _siteexpenditureState();
}

class _siteexpenditureState extends State<siteexpenditurecontent> {
  @override
  Widget build(BuildContext context) {
    return getCard(context);
//      Stack(
////      fit: StackFit.expand,
//      children: <Widget>[
//        getCard(context),
//      ],
//    );
  }

  Widget getCard(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 2,

        child: getElementList(),
      ),
    );
  }
}

List<String> getListElement() {
  var items = List<String>.generate(100, (counter) => "${counter+1}.    Site one");
  return items;
}
Widget getElementList() {
  var listItems = getListElement();
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: ListView.builder(padding: EdgeInsets.only(top: 6.0),itemCount : listItems.length,itemBuilder:(context,index) {

      var expenditure="Rs 20000000";
      return Card(

        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.white10, width: 1),
        ),
        margin: EdgeInsets.only(top:4.0,left:8,right:8,bottom: 4.0),
        child: ListTile(

//          leading: Icon(Icons.arrow_right),

         trailing:Text("$expenditure") ,
          title: Text(listItems[index]

          ),
          // onTap: () => showSnackbar(context) ,
          onTap:(){
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text("${listItems[index]} was tapped"),
//        ));

            showSnackBar(context, listItems[index]);
          },
        ),
      );
    }),
  );
//    return listView;
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
