import 'package:ecomm_app/providers/orderProvider.dart';
import 'package:ecomm_app/screens/locationSelect.dart';
import 'package:ecomm_app/widgets/cartCard.dart';
import 'package:ecomm_app/widgets/orderList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatelessWidget {
  var shopData;
  var cartData;
  var counter = Map<int, int>();
  var myOrders;
  @override
  Widget build(BuildContext context) {
    // myOrders = Provider.of<OrderProvider>(context, listen: false).getMyOrders();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: TextStyle(color: Colors.white)),
      ),
//       body: ListView(
//         padding: EdgeInsets.only(
//           left: 10.0,
//           right: 10.0,
//         ),
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 20.0),
//             child: Container(
//                 // height: MediaQuery.of(context).size.height - 300.0,
//                 child: FutureBuilder<List<Object>>(
//                     future: myOrders,
//                     builder: (context, snapshot) {
// //                                TODO: Snapshot end then no loading.
//                       if (snapshot.data != null) {
//                         return snapshot.data.length > 0
//                             ? ListView.builder(
//                                 primary: false,
//                                 shrinkWrap: true,
//                                 itemCount: snapshot.data.length,
//                                 itemBuilder: (context, i) {
//                                   counter[i] = 0;
//                                   return new Column(
//                                     children: <Widget>[
//                                       _buildStoreData(snapshot.data[i])
//                                     ],
//                                   );
//                                 })
//                             : Center(
//                                 child: Text('No orders yet'),
//                               );
//                       } else {
//                         return Center(child: Text('Loading...'));
//                       }
//                     })),
//           )
//         ],
//       ),

      body: OrderList(),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {
          // Navigator.of(context).pushNamed(LocationSelect.routeName);
          var b = '5f2b28c1265010001776ebfc';
          Provider.of<OrderProvider>(context, listen: false).deleteFromOrder(b);
        },
        label: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
      ),

//       FutureBuilder(
//         future: myOrders,
//         key: Key(),
//         builder: ListView.builder(itemBuilder: CartCard(product, index, str, btnStatus))),

//     );
//   }

//   //---returns store card---------------------------------------------------------------------------------------------------------
//   Widget _buildStoreData(var product) {
//     //print(product);
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//       child: Container(
//         margin: EdgeInsets.only(bottom: 20.0),
//         decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.red,
//               width: 1.0,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(10.0))),
//         child: GestureDetector(
//             onTap: () {},
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.only(right: 8.0),
//                     child: Image.network(
//                       product['product']['img'],
//                       height: 80,
//                       width: 60,
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                         child: ListTile(
// //contentPadding: EdgeInsets.all(10.0),

//                       title: Text(product['product']['name'],
//                           style: TextStyle(
//                               fontFamily: 'QuickSand',
//                               fontSize: 15.0,
//                               color: Colors.red[400],
//                               fontWeight: FontWeight.bold)),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         // mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             '₹${product['product']['price'].toString()}',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 fontSize: 12.0,
//                                 color: Colors.orange[400]),
//                           ),
//                           Text('Shop: ${product['userId']['shopName']}',
//                               style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 10.0,
//                                   color: Colors.blue)),
//                           Text(
//                               'Shop Phn: ${product['userId']['phone'].toString()}',
//                               style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 10.0,
//                                   color: Colors.brown)),
//                         ],
//                       ),
//                     )
// //
//                         ),
//                   ),

      // Padding(
      //   padding: EdgeInsets.only(left: 10),
      //   child: RaisedButton(
      //     color: product['completed']
      //         ? Colors.green
      //         : Colors.redAccent,
      //     onPressed: () {},
      //     child: Text(
      //         product['completed'] ? "Delivered" : "Pending...",
      //         style: TextStyle(color: Colors.white)),
      //     shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(5.0)),
      //   ),
      // ),
// //                  Container(
// //                    child: Row(
// //                      children: <Widget>[
// //                        Icon(Icons.add),
// //                        Padding(
// //                          padding: const EdgeInsets.all(2.0),
// //                          child: Text('12'),
// //                        ),
// //                        Icon(Icons.remove)
// //                      ],
// //                    ),
// //                  )
//                 ],
//               ),
//             )),
//       ),
    );
  }
}
