import 'package:ecomm_app/providers/cartAddDelete.dart';
import 'package:ecomm_app/providers/productsManager.dart';
import 'package:ecomm_app/providers/totalCountProvider.dart';
import 'package:ecomm_app/widgets/bottombarCart.dart';
import 'package:ecomm_app/widgets/cartList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'orders_page.dart';
import 'home_screen.dart';

class CartScreen extends StatelessWidget {
  static final routeName = './cartScreen';
  bool isLoading = false;
  bool showPrice = false;
  var cartData;
  int itemcount = 0;
  int currcount = 0;
  int totalcost = 0;
  int currcost = 0;
  int subtot = 0;
  int surcharge = 0;
  int delcharge = 0;
  int tax = 0;
  int curritemqty = 0;
  String store = "";
  Map<int, int> counter = Map();
  var cartProducts;
  var async_cartProducts;
  // @override
  // void initState() {
  //   super.initState();
  //   async_cartProducts = getCartProducts(context);
  //   async_getCartProducts();
  //   //subtot=calculateTotalPrice();
  //   setState(() {
  //     isLoading = false;
  //     print(subtot);
  //   });
  //   print('hello 1');
  // }

//   void async_getCartProducts() async {
//     print('hello 2');
//     cartProducts = await getCartProducts(context);
//     print(cartProducts);
//   }

//   int max(int a, int b) {
//     if (a > b)
//       return a;
//     else
//       return b;
//   }

//   int calculateTotalPrice() {
// //    if(cartProducts==null)
// //    { print('hello 3');async_getCartProducts();}
// //
// //    //print(cartProducts);
// //    if(cartProducts!=null)
// //      for(var item in cartProducts )
// //      {
// //        subtot+=(item['quantity']*item['product']['price']);
// //      }
//     setState(() {});
//     return subtot;
//   }

//   //Future<int> getText(var productId) async
//   int getText(var productId) {
//     //cartProducts=await getCartProducts(context);

//     if (cartProducts == null) {
//       print('hello 3');
//       async_getCartProducts();
//     }

//     //print(cartProducts);
//     if (cartProducts != null)
//       for (var item in cartProducts) {
//         if (item['product']['_id'] == productId) return item['quantity'];
//       }

//     return 0;
//   }

//   void addToCart(var id, var sellerId) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var jsonResponse = null;
//     String url =
//         'https://arcane-badlands-38563.herokuapp.com/api/customers/cart';
//     Map<String, String> headers = {
//       "x-auth-token": sharedPreferences.getString("token"),
//       "Content-type": "application/json"
//     };
//     String json = jsonEncode(<String, String>{'_id': id, 'userId': sellerId});
//     http.Response response = await http.post(url, headers: headers, body: json);
//     if (response.statusCode == 200) {
//       Toast.show("Cart Changed", context,
//           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     } else {
//       Toast.show("Failed to Add Product", context,
//           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     }
//   }

  // void placeOrder() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var jsonResponse = null;
  //   String url =
  //       'https://arcane-badlands-38563.herokuapp.com/api/customers/orders';
  //   Map<String, String> headers = {
  //     "x-auth-token": sharedPreferences.getString("token"),
  //     "Content-type": "application/json"
  //   };
  //   http.Response response = await http.post(url, headers: headers);
  //   if (true) {
  //     //Alert(context: context, title: "Order Placed Successfully", desc: "Please check My Orders for more details").show();
  //     Alert(
  //       context: context,
  //       type: AlertType.success,
  //       title: "Success",
  //       desc: "Check My Orders for more details.",
  //       buttons: [
  //         DialogButton(
  //           child: Text(
  //             "Continue",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //           onPressed: () => Navigator.pop(context),
  //           width: 120,
  //         )
  //       ],
  //     ).show();
  //     Toast.show("Thanks For Placing Order", context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   } else {
  //     Toast.show("Failed to Place Order", context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   }
  // }

//   Widget buildCard(var product, var index) {
//     subtot +=
//         (counter[index] ?? product['quantity']) * product['product']['price'];
//     print(subtot);
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
//
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    var cartProducts = Provider.of<ProductsManager>(context, listen: false);
    Provider.of<TotalCountProvider>(context, listen: false).setFlag = true;
    return ChangeNotifierProvider<CartAddDelete>(
      create: (context) => CartAddDelete(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart", style: TextStyle(color: Colors.white)),
        ),
        // backgroundColor: Colors.red[400],
        body: CartList(),
        floatingActionButton: BottombarCart(),
        // async_cartProducts: async_cartProducts,
        // showPrice: showPrice,s
        // subtot: subtot,
        // delcharge: delcharge,
        // tax: tax),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           // Add your onPressed code here!
//           print(cartProducts);
//           if (cartProducts != null && cartProducts.length != 0) {
//             placeOrder();
//             setState(() {
//               isLoading = true;
//               subtot = 0;
//             });

// //            Navigator.push(
// //              context,
// //              MaterialPageRoute(
// //                builder: (context) {
// //                  return OrdersPage();
// //                },
// //              ),
// //            );
//             // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);
//           } else {
//             Toast.show("Cart is Empty", context,
//                 duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//           }
//         },
//         label: Text(
//           'Place Order',
//           style: TextStyle(
//               color: Colors.red,
//               fontFamily: 'QuickSand',
//               fontSize: 15.0,
//               fontWeight: FontWeight.bold),
//         ),
//         icon: Icon(
//           Icons.check_circle_outline,
//           color: Colors.red,
//         ),
//         backgroundColor: Colors.white,
//       ),
      ),
    );
  }
}
//   Widget buildListView(List<Object> cartProducts) {
//     return !isLoading && cartProducts.length > 0
//         ? ListView.builder(
//             //itemExtent: 200,
//             shrinkWrap: true,
//             itemCount: cartProducts.length,
//             itemBuilder: (BuildContext context, int index) {
//               //print(index);
//               //counter[index]=1;
//               return buildCard(cartProducts[index], index);
//             },
//           )
//         : Center(
//             child: Text("Please Add Items to your Cart"),
//           );
//     ;
//   }
// }

// const TextStyle textStyle = TextStyle(
//   color: Colors.white,
//   fontFamily: 'QuickSand',
//   fontSize: 12.0,
//   fontWeight: FontWeight.bold,
// )
