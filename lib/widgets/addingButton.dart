import 'package:ecomm_app/providers/totalCountProvider.dart';

import '../providers/cartAddDelete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddingButton extends StatefulWidget {
  final id;
  final sellerId;
  var btnStatus;
  int price;
  AddingButton(this.id, this.sellerId, this.btnStatus, this.price);

  @override
  _AddingButtonState createState() => _AddingButtonState();
}

class _AddingButtonState extends State<AddingButton> {
  @override
  Widget build(BuildContext context) {
    print('btn build');
    final addDeletePro = Provider.of<CartAddDelete>(context, listen: false);
    final countPro = Provider.of<TotalCountProvider>(context, listen: false);
    if (widget.btnStatus == 'Added') {
      return RaisedButton(
        color: Colors.redAccent,
        onPressed: () {},
        child: Text('Added', style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      );
    } else if (widget.btnStatus == 'Add to Cart') {
      return RaisedButton(
        color: Colors.redAccent,
        onPressed: () {
          Toast.show("Adding Product...", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          addDeletePro.addToCart(widget.id, widget.sellerId, '1').then((value) {
            if (value) {
              Toast.show("Product Added", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              // countPro.setTotalBill = countPro.getTotalBill + widget.price;
            } else {
              Toast.show("Failed to add", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              setState(() {
                widget.btnStatus = 'Add to Cart';
              });
            }
          });
          setState(() {
            widget.btnStatus = 'Added';
          });
        },
        child: Text("Add to Cart", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      );
    } else
      return CircularProgressIndicator();
  }
}

// import 'package:ecomm_app/providers/cartInfoFlag.dart';

// import '../providers/cartAddDelete.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';

// class AddingButton extends StatefulWidget {
//   final id;
//   final sellerId;
//   var flag = false;
//   final btnStatus;
//   AddingButton(this.id, this.sellerId, this.btnStatus) {
//     print("const addingbtn");
//   }

//   @override
//   _AddingButtonState createState() => _AddingButtonState();
// }

// class _AddingButtonState extends State<AddingButton> {
//   int _flagc = 0;

//   @override
//   Widget build(BuildContext context) {
//     print('build btton');
//     print(_flagc);
// final addDeletePro = Provider.of<CartAddDelete>(context);
//     final cartInfo = Provider.of<CartInfoFlag>(context);
//     // var flag = addDeletePro.getStrFlag;
//     // if (flag == true) {
//     //   _btnString = 'added';
//     //   addDeletePro.setStrFlag = false;
//     // }
//     // print(_btnString);

//     // if ((_btnString != 'Added') && (widget.flag == false)) {
//     //   addDeletePro.checkIfInCart().then((value) {
//     //     if (value.contains(widget.id)) {
//     //       setState(() {
//     //         _btnString = 'Added';
//     //       });
//     //     } else {
//     //       setState(() {
//     //         widget.flag = true;
//     //         _btnString = 'Add to Cart';
//     //       });
//     //     }
//     //   }).catchError((error) {
//     //     print(error);
//     //   });
//     // }

//     if (cartInfo.getCartInfoReady) {
//       print('ll${addDeletePro.getlistId}');
//       if (addDeletePro.getlistId.contains(widget.id) ||
//           addDeletePro.getAddFlag) {
// return RaisedButton(
//   color: Colors.redAccent,
//   onPressed: () {},
//   child: Text('Added', style: TextStyle(color: Colors.white)),
//   shape:
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
// );
//       } else {
// return RaisedButton(
//   color: Colors.redAccent,
//   onPressed: () {
//     Toast.show("Adding Product...", context,
//         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     print('ko');
//     addDeletePro.addToCart(widget.id, widget.sellerId).then((value) {
//       if (value) {
//         Toast.show("Product Added", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//         addDeletePro.setAddFlag = false;
//       } else {
//         Toast.show("Failed to add", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       }
//     });
//   },
//   child: Text("Add to Cart", style: TextStyle(color: Colors.white)),
//   shape:
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
// );
//       }
//     } else
//       return CircularProgressIndicator();
//   }
// }
