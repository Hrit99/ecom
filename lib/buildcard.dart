import 'package:ecomm_app/providers/cartInfoFlag.dart';
import 'package:ecomm_app/screens/products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildCard extends StatefulWidget {
  final int id;
  final BuildContext ctx;
  String name;
  String imgname;
  BuildCard({this.id, this.ctx}) {
    switch (id) {
      case 1:
        name = "Fruits and Vegetables";
        imgname = "grocerymain.png";
        break;
      case 2:
        name = "Electronics";
        imgname = "electronics.png";
        break;
      case 3:
        name = "Personal Care";
        imgname = "personal.png";
        break;
      case 4:
        name = "Medicines";
        imgname = "medicine.png";
        break;
      case 5:
        name = "Branded Foods";
        imgname = "snacks.png";
        break;
      case 6:
        name = "Clothing";
        imgname = "clothing.png";
        break;
    }
  }
  @override
  _BuildCardState createState() => _BuildCardState(name, imgname);
}

class _BuildCardState extends State<BuildCard> {
  final String name;

  final String imgname;
  var _flag = false;
  var _flagStart = false;
  var colorr = Colors.white;
  var _borderRadius = BorderRadius.circular(10);
  _BuildCardState(this.name, this.imgname);

  @override
  Widget build(BuildContext context) {
    // if (_ontap == true) {
    // setState(() {
    //   _ontap = false;
    //   colorr = Colors.white;
    //   _flag = false;
    //   _borderRadius = BorderRadius.circular(10.0);
    //   Navigator.of(context)
    //       .pushNamed(ProductsPage.routeName, arguments: name);
    // });
    //   return Text('lk');
    // }

    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: GestureDetector(
        child: InkWell(
          autofocus: true,
          child: AnimatedContainer(
            width: MediaQuery.of(widget.ctx).size.width,
            height: MediaQuery.of(widget.ctx).size.height,
            decoration: BoxDecoration(
              // color:Color.fromARGB(8, 16, 235, 255),
              borderRadius: _borderRadius,
              border: Border.all(color: Colors.red[400], width: 1.69),
              color: colorr,
            ),
            duration: (_flagStart == true)
                ? Duration(seconds: 2)
                : Duration(seconds: 0),
            curve: Curves.fastOutSlowIn,
            child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
                Image.asset('assets/images/$imgname'),
                SizedBox(height: 15.0),
                (_flag == false)
                    ? Text('$name',
                        style: new TextStyle(
                            fontSize: 12.0, color: Colors.orange[400]))
                    : SizedBox(height: 0.0),
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(10.0),
          splashColor: Theme.of(context).accentColor,
        ),
        onTapDown: (details) {
          setState(() {
            colorr = Theme.of(context).accentColor;
            _flag = true;
            _borderRadius = BorderRadius.circular(100);
          });
          setState(() {
            colorr = Theme.of(context).accentColor;
            _flagStart = true;
            _borderRadius = BorderRadius.circular(10.0);
          });
        },
        // onTap: () {
        //   setState(() {
        //     colorr = Theme.of(context).accentColor;
        //     _flag = true;
        //     _borderRadius = BorderRadius.circular(100);
        //     _ontap = true;
        //   });
        // },
        onTapUp: (details) {
          setState(() {
            _flagStart = false;
            colorr = Colors.white;
            _flag = false;
            _borderRadius = BorderRadius.circular(10.0);
            Navigator.of(context)
                .pushNamed(ProductsPage.routeName, arguments: name);
          });
        },
        onTapCancel: () {},
      ),
    );
  }
}
