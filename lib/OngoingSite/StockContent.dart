import 'package:flutter/material.dart';

class StockContent extends StatefulWidget {
  @override
  _StockContentState createState() => _StockContentState();
}

class _StockContentState extends State<StockContent> {

  List<Matdata> matdata =[];
  List<Sublist> sublist =[];
  List<Sublist> sublist1 =[];
  List<Sublist> sublist2=[];
  List<Sublist> sublist3=[];
  var normalText =  new TextStyle(fontSize: 15.0);
  var titleText =  new TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold);


  @override
  Widget build(BuildContext context) {

    matdata.clear();
    sublist.clear();
    sublist1.clear();
    sublist2.clear();
    sublist3.clear();
    sublist.add(new Sublist("Materials", 'Amount'));
    sublist.add(new Sublist("Jagadamba opc Cement", "12 packs"));
    sublist.add(new Sublist("kp  ppc Cement", "25 Packs"));
    sublist.add(new Sublist("Bricks", "1000 pieces"));

    sublist1.add(new Sublist("Materials", 'Amount'));
    sublist1.add(new Sublist("Gitti", "2 tip"));
    sublist1.add(new Sublist("Panchakanya Stainless Steel", "55 rounds"));
    sublist1.add(new Sublist("Dhalane killa", "5 packets"));
    sublist1.add(new Sublist("White Cement", "20 packs"));

    sublist2.add(new Sublist("Materials", 'Amount'));
    sublist2.add(new Sublist("Jagadamba opc Cement", "12 packs"));
    sublist2.add(new Sublist("Gitti", "2 tip"));
    sublist2.add(new Sublist("Panchakanya Stainless Steel", "55 rounds"));
    sublist2.add(new Sublist("Dhalane killa", "5 packets"));

    sublist3.add(new Sublist("Materials", 'Amount'));
    sublist3.add(new Sublist("Jagadamba opc Cement", "12 packs"));
    sublist3.add(new Sublist("Gitti", "2 tip"));
    sublist3.add(new Sublist("Panchakanya Stainless Steel", "55 rounds"));
    sublist3.add(new Sublist("Dhalane killa", "5 packets"));
    sublist3.add(new Sublist("Bricks", "1000 pieces"));
    sublist3.add(new Sublist("White Cement", "20 packs"));
    sublist3.add(new Sublist("Tile", "500 pieces"));
    sublist3.add(new Sublist("Thick Rope", "50 m"));


    matdata.add(new Matdata('2020-10-20', sublist));
    matdata.add(new Matdata('2020-05-02', sublist1));
    matdata.add(new Matdata('2025-06-01', sublist2));
    matdata.add(new Matdata('2015-08-26', sublist3));


    return new Scaffold(
      body: new ListView.builder(
        itemCount: matdata.length,
        itemBuilder: (context, i) {
          return new ExpansionTile(
            initiallyExpanded: i==0?true:false,
            title: new Text(matdata[i].title, style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(matdata[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Matdata matdata) {
    List<Widget> columnContent = [];

    for (Sublist content in matdata.sublist)
      columnContent.add(
        new ListTile(
          title: new Text(content.material, style: content.material == "Materials" ? titleText:normalText),
          trailing:  new Text(content.amount, style: content.amount == "Amount" ? titleText:normalText),
        ),
      );

    return columnContent;
  }
}

class Sublist {
  String material,amount;

  Sublist(this.material, this.amount);

}

class Matdata {
  String title; List<Sublist> sublist;

  Matdata(this.title, this.sublist);

}

