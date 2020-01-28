import 'package:flutter/material.dart';

import 'OngoingSiteContent.dart';

class stockremainingcontent extends StatefulWidget {
  @override
  _stockremainingcontentState createState() => _stockremainingcontentState();
}

class _stockremainingcontentState extends State<stockremainingcontent> {
  List<Matdata> matData = [];

  List<SubMatData> subList = [];
  List<SubMatData> subList1 = [];
  List<SubMatData> subList2 = [];

  var normalText = new TextStyle(fontSize: 18.0);
  var titleText = new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black);

  @override
  Widget build(BuildContext context) {

    matData.clear();
    subList.clear();
    subList1.clear();
    subList2.clear();

    subList.add(new SubMatData('Material', 'Remaining'));
    subList.add(new SubMatData('rosh', '20 packet'));
    subList.add(new SubMatData('fdsafd', 'fdasfsadfs'));

    subList1.add(new SubMatData('Material', 'Remaining'));
    subList1.add(new SubMatData('santosh', '20 fsda'));
    subList1.add(new SubMatData('an bro', '10 fdsa'));
    subList1.add(new SubMatData('roshfda', '220 packet'));
    subList1.add(new SubMatData('frecfd', '201 box'));

    subList2.add(new SubMatData('Material', 'Remaining'));
    subList2.add(new SubMatData('bija', '20 lkh'));
    subList2.add(new SubMatData('asis', '231 ft'));
    subList2.add(new SubMatData('bi[u', '45 litre'));

    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));
    matData.add(new Matdata('2020-01-10', subList));
    matData.add(new Matdata('2019-01-20', subList1));
    matData.add(new Matdata('2018-02-20', subList2));


    return new Scaffold(
      body: new ListView.builder(
        itemCount: matData.length,
        itemBuilder: (context, i) {
          return new ExpansionTile(
            initiallyExpanded: i==0?true:false,
            title: new Text(
              matData[i].date,
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),


            children: <Widget>[
              new Column(
                children: _buildExpandableContent(matData[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Matdata material) {
    List<Widget> columnContent = [];

        for (SubMatData content in material.subList ) {

          columnContent.add(
            new ListTile(
              title: new Text(
                content.title, style: content.title == "Material"? titleText : normalText,),
              trailing: new Text(
                content.subtitle, style: content.subtitle == "Remaining"? titleText : normalText,),
            ),
          );
        }
    return columnContent;
  }

}

class Matdata {
  String date;
  List<SubMatData> subList;

  Matdata(this.date, this.subList);
}


class SubMatData{
  String title;
  String subtitle;

  SubMatData(this.title, this.subtitle);

}
