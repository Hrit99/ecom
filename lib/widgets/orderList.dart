import 'dart:ffi';

import 'package:ecomm_app/main.dart';
import 'package:ecomm_app/providers/orderProvider.dart';
import 'package:ecomm_app/providers/productsManager.dart';
import 'package:ecomm_app/providers/totalCountProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import './cartCard.dart';
import '../providers/cartAddDelete.dart';

class OrderList extends StatefulWidget {
  // const CartList({
  //   Key key,
  //   @required this.showPrice,
  //   @required this.subtot,
  //   @required this.delcharge,
  //   @required this.tax,
  // }) : super(key: key);

  // final bool showPrice;
  // final int subtot;
  // final int delcharge;
  // final int tax;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  // double total;
  @override
  Widget build(BuildContext context) {
    print('build Order list');
    // final productsManage = Provider.of<ProductsManager>(context, listen: false);
    // final cartProducts = productsManage.getCartProducts();

    var myOrders =
        Provider.of<OrderProvider>(context, listen: false).getMyOrders();

    // .then((_) {
    // });
    // final adddeletePro = Provider.of<CartAddDelete>(context, listen: false);
    // var tcpPro = Provider.of<TotalCountProvider>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print('kol');
    // });

    // final addDeletePro = Provider.of<CartAddDelete>(context, listen: false);
    // final cartInfo = Provider.of<CartInfoFlag>(context, listen: false);
    // cartInfo.setCartInfoReady = false;
    // addDeletePro.checkIfInCart().then((_) {
    //   print('df${addDeletePro.getlistId}');
    //   cartInfo.setCartInfoReady = true;
    //   print('lkl${addDeletePro.getlistId}');
    // });
    // // return ListView(
    //   padding: EdgeInsets.only(
    //     left: 10.0,
    //     right: 10.0,
    //   ),
    //   children: <Widget>[
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        // height: MediaQuery.of(context).size.height - 300.0,
        child: FutureBuilder<List<Map<dynamic, dynamic>>>(
          future: myOrders,
          builder: (context, snapshot) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   print('mnm');
            //   tcpPro.setBar(total);
            // });
//                                TODO: Snapshot end then no loading.
            if (snapshot.data != null) {
              print(snapshot.data);
              // total = productsManage.getTot;
              // print('this$total');
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      color: Colors.amber,
                      height: 1,
                    );
                  },
                  primary: false,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    // var s = snapshot.data[i];
                    // return SlidableDismissal(
                    //     dismissThresholds: {SlideActionType.secondary: 0.5},
                    //     dragDismissible: true,
                    //     onDismissed: (direction) {
                    // print('is dismissed${tcpPro.getquant}');
                    // print('removing ${s['_id']}');

                    // adddeletePro.setIndex = i;

                    // adddeletePro.addToCart(
                    //     snapshot.data[i]['product']['_id'].toString(),
                    //     snapshot.data[i]['userId']['_id'].toString(),
                    //     '1');

                    // adddeletePro.deleteFromCart(
                    //     snapshot.data[i]['product']['_id']);
                    // print('hiii');
                    // print(tcpPro.getquant);
                    // tcpPro.setBar(tcpPro.getTotalBill -
                    //     (snapshot.data[i]['product']['price'] *
                    //         tcpPro.getquant));

                    //       // setState(() {
                    //       //   print('this is setstate');
                    //       // });
                    //     },
                    return CartCard(snapshot.data[i], i, 'order', 4);
                    // return FutureBuilder<List<Map<dynamic, dynamic>>>(
                    //   future: cartProducts,
                    //   builder: (context, snap) {
                    //     if (snap.data != null) {
                    //       for (int j = 0; j < snap.data.length; j++) {
                    //         if ((snapshot.data[i]['_id']) ==
                    //             (snap.data[j]['product']['_id'])) {
                    //           return CartCard(snapshot.data[i], i, 'add', 1);
                    //         }
                    //       }
                    //       return CartCard(snapshot.data[i], i, 'add', 2);
                    //     } else {
                    //       return CartCard(snapshot.data[i], i, 'add', 0);
                    //     }
                    //   },
                    //   // child: CartCard(snapshot.data[i], i, 'add'));
                    // );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
// return SafeArea(
//   //   child: (
//   // children: <Widget>[
//   //   SizedBox(
//   //     height: 10,
//   //   ),
//     // Container(
//     //   height: MediaQuery.of(context).size.height - 225,
//     //   decoration: BoxDecoration(
//     //     color: Colors.white,
//     //     borderRadius: BorderRadius.only(
//     //         topLeft: Radius.circular(20.0),
//     //         topRight: Radius.circular(20.0)),
//     //   ),
//     //   child: Padding(
//     //     padding: EdgeInsets.only(
//     //       top: 10.0,
//     //       left: 8.0,
//     //       right: 8.0,
//     //     ),
//     //     child: Column(children: <Widget>[
//     //       FutureBuilder<List<Object>>(
//     //         future: asyncCartProducts,
//     //         builder: (context, snapshot) {
//     //           if (snapshot.hasData) {
//     //             subtot = 0;
//     //             return Expanded(child: buildListView(snapshot.data));
//     //           } else {
//     //             return Center(child: CircularProgressIndicator());
//     //           }
//     //         },
//     //       ),
//     //     ]),
//     //   ),
//     // ),
//     // Stack(
//     //   children: <Widget>[
//     //     Container(
//     //       margin: EdgeInsets.fromLTRB(15, 8, 0, 0),
//     //       child: RaisedButton(
//     //         child: Text(
//     //           'Get Total',
//     //           style: TextStyle(
//     //               color: Colors.red,
//     //               fontFamily: 'QuickSand',
//     //               fontSize: 15.0,
//     //               fontWeight: FontWeight.bold),
//     //         ),
//     //         color: showPrice ? Colors.transparent : Colors.white,
//     //         onPressed: () {
//     //           setState(() {
//     //             showPrice = true;
//     //           });
//     //         },
//     //       ),
//     //     ),
//     //     showPrice
//     //         ? Container(
//     //             // margin: EdgeInsets.only(left: 10.0),
//     //             //height: 90,
//     //             color: Colors.red,
//     //             child: Padding(
//     //               padding: EdgeInsets.only(left: 25.0),
//     //               child: Column(
//     //                   crossAxisAlignment: CrossAxisAlignment.start,
//     //                   children: <Widget>[
//     //                     SizedBox(height: 10.0),
//     //                     Text(
//     //                       'Subtotal: ₹${subtot}',
//     //                       style: TextStyle(
//     //                         color: Colors.white,
//     //                         fontFamily: 'QuickSand',
//     //                         fontSize: 10.0,
//     //                         fontWeight: FontWeight.bold,
//     //                       ),
//     //                     ),
//     //                     Text(
//     //                       'Delivery Charges: ₹$delcharge',
//     //                       style: TextStyle(
//     //                         color: Colors.white,
//     //                         fontFamily: 'QuickSand',
//     //                         fontSize: 10.0,
//     //                         fontWeight: FontWeight.bold,
//     //                       ),
//     //                     ),
//     //                     Text(
//     //                       'Taxes: ₹$tax',
//     //                       style: TextStyle(
//     //                         color: Colors.white,
//     //                         fontFamily: 'QuickSand',
//     //                         fontSize: 10.0,
//     //                         fontWeight: FontWeight.bold,
//     //                       ),
//     //                     ),
//     //                     Text(
//     //                       'Total: ₹${subtot + delcharge + tax}',
//     //                       style: TextStyle(
//     //                         color: Colors.white,
//     //                         fontFamily: 'QuickSand',
//     //                         fontSize: 20.0,
//     //                         fontWeight: FontWeight.bold,
//     //                       ),
//     //                     )
//     //                   ]),
//     //             ),
//     //           )
//     //         : SizedBox(
//     //             height: 0,
//     //           )
//     //   ],
//     // )
//   // ],)

//   Container(alignment: ,)
// );
//   }
// }
