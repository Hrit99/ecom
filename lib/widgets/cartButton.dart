import 'package:ecomm_app/providers/cartAddDelete.dart';
import 'package:ecomm_app/providers/cartInfoFlag.dart';
import 'package:ecomm_app/providers/productsManager.dart';
import 'package:ecomm_app/providers/totalCountProvider.dart';
import 'package:ecomm_app/widgets/cartCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CartButton extends StatefulWidget {
  var product;
  var i;
  int quantity;
  var flag = false;
  CartButton(this.product, this.i) {
    print('const ry');
    flag = true;
  }
  @override
  CartButtonState createState() => CartButtonState();
}

class CartButtonState extends State<CartButton> {
  var proadtocart;
  bool changeflag = false;
  var tcpPro;
  int get getQuantity => widget.quantity;

  CartButtonState() {
    print('its constr');
    // print(widget.quantity);
  }
  @override
  void initState() {
    print('init');
    print(widget.quantity);
    super.initState();
    Provider.of<CartInfoFlag>(context, listen: false);
    proadtocart = Provider.of<CartAddDelete>(context, listen: false);
    tcpPro = Provider.of<TotalCountProvider>(context, listen: false);
    // TODO: implement initState
  }

  @override
  void didChangeDependencies() {
    print('didi');
    print(widget.flag);
    print(widget.quantity);
    if (widget.flag) {
      widget.quantity = widget.product['quantity'];
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print('dispose');
    tcpPro.setquant = widget.quantity;
    print(tcpPro.getquant);
    if (changeflag == true) {
      proadtocart.setIndex = widget.i;
      print(
          '${widget.product['product']['_id'].toString()} , $widget.quantity');
      proadtocart.addToCart(
          widget.product['product']['_id'].toString(),
          widget.product['userId']['_id'].toString(),
          widget.quantity.toString());
    }

    print('dispose ends');
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product['product']['name']);
    print(widget.quantity);
    widget.flag = false;
    Provider.of<CartAddDelete>(context, listen: false);
    final productsManage = Provider.of<ProductsManager>(context, listen: false);
    final provCount = Provider.of<TotalCountProvider>(context, listen: false);
    // final countPro = Provider.of<TotalCountProvider>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print('kl${widget.product['product']['name']}');
    //   countPro.setTotalBill =
    //       countPro.getTotalBill + widget.product['product']['price'];
    // });

    // proadtocart.setTotalBill =
    //     proadtocart.getTotalBill + widget.product['product']['price'];
    return FittedBox(
      child: Container(
        padding: EdgeInsets.only(right: 0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent),
              onPressed: () {
                Toast.show("Please wait...", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                // proadtocart.setTotalBill = proadtocart.getTotalBill -
                //     widget.product['product']['price'];
                // addDeletePro.setIndex = widget.index;
                // addDeletePro
                //     .deleteFromCart(widget.product['product']['_id'])
                //     .then((value) {
                //   if (value) {
                //     setState(() {
                //       addDeletePro.setDelFlag = true;
                //     });
                //   Toast.show("deleted", context,
                //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                // } else {
                //   Toast.show("Could not be deleted", context,
                //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                //   }
                // }
                //   );
                if (widget.quantity > 1) {
                  setState(() {
                    productsManage.setTot = productsManage.getTot -
                        widget.product['product']['price'];
                    provCount.setBar(productsManage.getTot);
                    changeflag = true;
                    widget.quantity--;
                    // _propc.subtractElement = widget.product['product']['_id'];
                  });
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(widget.quantity.toString(),
                  style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontSize: 20.0,
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold)),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.redAccent),
              onPressed: () {
                Toast.show("Please wait...", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                // proadtocart.setTotalBill = proadtocart.getTotalBill +
                //     widget.product['product']['price'];
                // // addDeletePro.setIndex = widget.index;
                // addDeletePro
                //     .deleteFromCart(widget.product['product']['_id'])
                //     .then((value) {
                //   if (value) {
                //     setState(() {
                //       addDeletePro.setDelFlag = true;
                //     });
                //   Toast.show("deleted", context,
                //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                // } else {
                //   Toast.show("Could not be deleted", context,
                //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                //   }
                // }
                //   );
                setState(() {
                  productsManage.setTot = productsManage.getTot +
                      widget.product['product']['price'];
                  provCount.setBar(productsManage.getTot);
                  changeflag = true;
                  print(widget.quantity);
                  widget.quantity = widget.quantity + 1;
                  print(widget.quantity);
                  // _propc.addElement = widget.product['product']['_id'];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:ecomm_app/providers/cartAddDelete.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';

// class CartButton extends StatefulWidget {
//   final product;
//   final index;

//   CartButton(this.product, this.index);

//   @override
//   _CartButtonState createState() => _CartButtonState();
// }

// class _CartButtonState extends State<CartButton> {
//   @override
//   Widget build(BuildContext context) {
// return FittedBox(
//   child: Container(
//     padding: EdgeInsets.only(right: 0),
//     child: Row(
//       children: [
//         IconButton(
//           icon: Icon(Icons.remove_circle, color: Colors.redAccent),
//           onPressed: () {
//             Toast.show("Please wait...", context,
//                 duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             // addDeletePro.setIndex = widget.index;
//             // addDeletePro
//             //     .deleteFromCart(widget.product['product']['_id'])
//             //     .then((value) {
//             //   if (value) {
//             //     setState(() {
//             //       addDeletePro.setDelFlag = true;
//             //     });
//             //   Toast.show("deleted", context,
//             //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             // } else {
//             //   Toast.show("Could not be deleted", context,
//             //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             //   }
//             // }
//             //   );
//             //   if (quantity > 1) {
//             //     setState(() {
//             //       quantity--;
//             //     });
//             //   }
//           },
//         ),
//         Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Text(widget.product['quantity'].toString(),
//               style: TextStyle(
//                   fontFamily: 'QuickSand',
//                   fontSize: 20.0,
//                   color: Colors.red[400],
//                   fontWeight: FontWeight.bold)),
//         ),
//         IconButton(
//           icon: Icon(Icons.add_circle, color: Colors.redAccent),
//           onPressed: () {
//             Toast.show("Please wait...", context,
//                 duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             // addDeletePro.setIndex = widget.index;
//             // addDeletePro
//             //     .deleteFromCart(widget.product['product']['_id'])
//             //     .then((value) {
//             //   if (value) {
//             //     setState(() {
//             //       addDeletePro.setDelFlag = true;
//             //     });
//             //   Toast.show("deleted", context,
//             //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             // } else {
//             //   Toast.show("Could not be deleted", context,
//             //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             //   }
//             // }
//             //   );
//             // setState(() {
//             //   quantity++;
//             // });
//           },
//         ),
//       ],
//     ),
//   ),
// );
//   }
// }

// class CartButton extends StatefulWidget {
//   final product;
//   final index;
//   CartButton(this.product, this.index);

//   @override
//   _CartButtonState createState() => _CartButtonState();
// }

// class _CartButtonState extends State<CartButton> {
//   @override
//   Widget build(BuildContext context) {
//     var addDeletePro = Provider.of<CartAddDelete>(context, listen: false);
//     var quantity;
//     if (addDeletePro.getDelFlag == true) {
//       quantity = addDeletePro.getRecentQuant;
//       addDeletePro.setDelFlag = false;
//     } else {
//       quantity = widget.product['quantity'];
//     }
//     return Row(children: [
// IconButton(
//   icon: Icon(Icons.remove_circle, color: Colors.redAccent),
//   onPressed: () {
//     print('del pressed');
//     Toast.show("Please wait...", context,
//         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     addDeletePro.setIndex = widget.index;
//     addDeletePro
//         .deleteFromCart(widget.product['product']['_id'])
//         .then((value) {
//       if (value) {
//         setState(() {
//           addDeletePro.setDelFlag = true;
//         });
//         Toast.show("deleted", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       } else {
//         Toast.show("Could not be deleted", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       }
//     });
//   },
// ),
// Padding(
//   padding: const EdgeInsets.all(4.0),
//   child: Text(quantity.toString(),
//       style: TextStyle(
//           fontFamily: 'QuickSand',
//           fontSize: 20.0,
//           color: Colors.red[400],
//           fontWeight: FontWeight.bold)),
// ),
// IconButton(
//   icon: Icon(Icons.add_circle, color: Colors.redAccent),
//   onPressed: () {
//     print('add pressed');
//     Toast.show("Please wait...", context,
//         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     addDeletePro.setIndex = widget.index;
//     addDeletePro
//         .addToCart(widget.product['product']['_id'],
//             widget.product['userId']['_id'])
//         .then((value) {
//       if (value) {
//         setState(() {
//           addDeletePro.setDelFlag = true;
//         });
//         Toast.show("Added", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       } else {
//         Toast.show("Could not be Added", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       }
//     });
//   },
// ),
//     ]);
//   }
// }

//       ],
//       color: Colors.redAccent,
//        onPressed: () {
//             print('del pressed');
//             productManage
//                 .deleteFromCart(widget.product['product']['_id'])
//                 .then((value) {
//               if (value > -1) {
//                 quantity = value;
//                 Toast.show("deleted", context,
//                     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//               } else {
//                 Toast.show("Could not be deleted", context,
//                     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//               }
//             });
//       // onPressed: () {
//       //   Toast.show("Adding Product...", context,
//       //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       //   print('ko');
//       //   productManage.addToCart(widget.id, widget.sellerId).then((value) {
//       //     if (value) {
//       //       Toast.show("Product Added", context,
//       //           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       //     } else {
//       //       Toast.show("Failed to add", context,
//       //           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       //     }
//       //   });
//       },
//       child: Text(widget._btnString, style: TextStyle(color: Colors.white)),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//     );
//   }
// }
//   // Widget build(BuildContext context) {
//   //   print('heiy');
//   print('fj{${widget.product['quantity']}');
//   var quantity = widget.product['quantity'];
//   var productsManage = Provider.of<ProductsManager>(context);
//   return Row(children: <Widget>[
// IconButton(
//     icon: Icon(Icons.remove_circle, color: Colors.redAccent),
//         onPressed: () {
//           print('del pressed');
//           productsManage
//               .deleteFromCart(widget.product['product']['_id'])
//               .then((value) {
//             if (value > -1) {
//               quantity = value;
//               Toast.show("deleted", context,
//                   duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             } else {
//               Toast.show("Could not be deleted", context,
//                   duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             }
//           });
// Toast.show("Please wait...", context,
//     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//         }),
//   Padding(
//     padding: const EdgeInsets.all(4.0),
//     child: Text(quantity.toString(),
//         style: TextStyle(
//             fontFamily: 'QuickSand',
//             fontSize: 20.0,
//             color: Colors.red[400],
//             fontWeight: FontWeight.bold)),
//   ),
// ]);
// }
//             setState(() {
//               //print(counter);
//               if (counter[index] == null)
//                 counter[index] = getText(product['product']['_id']);
//               counter[index] = max(0, counter[index] - 1);
//               subtot = max(subtot - product['product']['price'], 0);
// //                            if(counter[index]==0)
// //                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => CartScreen()), (Route<dynamic> route) => false);
// //                           // print(counter);
//             });
//   },
// ),
// Padding(
//   padding: const EdgeInsets.all(4.0),
//   child: Text('${counter[index] ?? widget.product['quantity']}',
//       style: TextStyle(
//           fontFamily: 'QuickSand',
//           fontSize: 20.0,
//           color: Colors.red[400],
//           fontWeight: FontWeight.bold)),
// ),
// IconButton(
//   icon: Icon(
//     Icons.add_circle,
//     color: Colors.redAccent,
//   ),
//   onPressed: () {
//     Toast.show("Please wait...", context,
//         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     addToCart(product['product']['_id'], product['product']['userId']);
//     setState(() {
//       if (counter[index] == null)
//         counter[index] = getText(product['product']['_id']);

//       counter[index] += 1;
//       subtot += product['product']['price'];
//     });
//   },
// ),
//       ],
//     );
//   }
// }
