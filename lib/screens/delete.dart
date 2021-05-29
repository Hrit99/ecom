// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:toast/toast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'dart:convert';

// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   var cartData;
//   int itemcount = 0;
//   int currcount = 0;
//   int totalcost = 0;
//   int currcost = 0;
//   int subtot = 0;
//   int surcharge = 0;
//   int delcharge = 0;
//   int curritemqty = 0;
//   String store = "";
//   Future<List<Object>> cartProducts;
//   // var data = cartDatabaseProvider.db.getAllItem();

//   @override
//   void initState() {
//     super.initState();
//     cartProducts = getCartProducts(context);
//     setState(() {});
//   }

//   Widget buildCard(var product) {
//     //print(product);
//     return Container(
//       margin: EdgeInsets.only(bottom: 20.0),
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.red,
//             width: 1.0,
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(10.0))),
//       child: Padding(
//         padding:
//             EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
//         child: GestureDetector(
//             onTap: () {},
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.only(right: 8.0),
//                   child: Image.network(
//                     product['product']['img'],
//                     height: 80,
//                     width: 60,
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         product['product']['name'],
//                         style: TextStyle(
//                             fontFamily: 'QuickSand',
//                             fontSize: 15.0,
//                             color: Colors.red[400],
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         product['product']['category'],
//                         style: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontSize: 12.0,
//                             color: Colors.orange[400]),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         'M.R.P: ₹${product['product']['price']}',
//                         style: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontSize: 12.0,
//                             color: Colors.orange[400]),
//                       ),
//                       SizedBox(height: 5.0),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.add),
//                       Text('12'),
//                       Icon(Icons.remove)
//                     ],
//                   ),
//                 )
// //                Column(children: <Widget>[
// //                  IconButton(
// //                    icon: Icon(Icons.add_circle,color: Colors.red,size: 25,),
// //
// //                onPressed: (){
// //                  setState(() {
// //                    counter[product['_id']]+=1;
// //                  });
// //                },
// //                  ),
// //                  Text(
// //                    '${counter[product['_id']]}',
// //                    style: TextStyle(
// //                        fontSize: 20.0,
// //                        color: Colors.red[400]),
// //                  ),
// //                  IconButton(
// //                    icon: Icon(Icons.remove_circle,color: Colors.red,size: 25,),
// //
// //                onPressed: (){
// //                  setState(() {
// //                    counter[product['_id']]-=1;
// //                  });
// //                },
// //                  ),
// //                  ButtonTheme(
// //                    minWidth: 10.0,
// //                    height: 30.0,
// //                    child: FlatButton(

// //                  onPressed: () async {
// //                    await cartDatabaseProvider.db.additemToDatabase(new Item(
// //                        name: productName,
// //                        id: productID,
// //                        mrp: productMRP,
// //                        storeprice: productStorePrice,
// //                        type: productType
// //                        ,quantity: 1));
// //
// //                    Toast.show("$productName has been added to your cart", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
// //                  },
// //                    onPressed: () async {
// ////                      print(productID);
// ////                      final docRef = await Firestore.instance.collection('Users/testuser/cart').add({
// ////                        'name': productName,
// ////                        'price': productMRP,
// ////                        'quantity': 1,
// ////                        'type':productType,
// ////
// ////                      });
// //
// //                    }
// //                      disabledColor: Colors.red[400],
// //                      color: Colors.red[400],
// //                      child: Text('Add to Cart',
// //                          style: TextStyle(
// //                              fontFamily: 'QuickSand',
// //                              fontSize: 10.0,
// //                              fontWeight: FontWeight.bold,
// //                              color: Colors.white)),
// //                    ),
// //                  )
// //                ])
//               ],
//             )),
//       ),
//     );
//   }

// //  Widget _buildcartData(productName, productQuantity, productPrice, productType,
// //      productID, productmrp) {
// //    return Container(
// //      margin: EdgeInsets.only(bottom: 20.0),
// //      decoration: BoxDecoration(
// //          border: Border.all(
// //            color: Colors.red,
// //            width: 1.0,
// //          ),
// //          borderRadius: BorderRadius.all(Radius.circular(10.0))),
// //      child: Padding(
// //        padding:
// //            EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
// //        child: GestureDetector(
// //            onTap: null,
// //            child: Row(
// //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //              children: <Widget>[
// //                Column(
// //                  crossAxisAlignment: CrossAxisAlignment.start,
// //                  children: <Widget>[
// //                    Text(
// //                      productName,
// //                      style: TextStyle(
// //                          fontFamily: 'QuickSand',
// //                          fontSize: 15.0,
// //                          color: Colors.red[400],
// //                          fontWeight: FontWeight.bold),
// //                    ),
// //                    SizedBox(height: 5.0),
// //                    Text(
// //                      productType,
// //                      style: TextStyle(
// //                          fontFamily: 'Montserrat',
// //                          fontSize: 12.0,
// //                          color: Colors.orange[400]),
// //                    ),
// //                    SizedBox(height: 5.0),
// //                    Text(
// //                      'Price: ₹$productPrice',
// //                      style: TextStyle(
// //                          fontFamily: 'Montserrat',
// //                          fontSize: 12.0,
// //                          color: Colors.orange[400]),
// //                    ),
// //                    SizedBox(height: 5.0),
// //                    Text(
// //                      'Store: $store',
// //                      style: TextStyle(
// //                          fontFamily: 'Montserrat',
// //                          fontSize: 12.0,
// //                          color: Colors.orange[400]),
// //                    ),
// //                  ],
// //                ),
// //                Column(children: <Widget>[
// //                  Row(
// //                    children: <Widget>[
// //                      IconButton(
// //                        color: Colors.red,
// //                        onPressed: () async {
// //                          //
// //
// //                          currcount=int.parse(productQuantity) - 1;
// //                          if(currcount==0){
// //                            await cartDatabaseProvider.db.deleteItemWithId(productID);
// //                            Toast.show("Removed $productName from cart", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
// //                          }else{
// //                            await cartDatabaseProvider.db.updateitem(new Item(
// //                                name: productName,
// //                                type: productType,
// //                                quantity: currcount,
// //                                storeprice: productPrice,
// //                                mrp: productmrp,
// //                                id: productID));
// //                          }
// //
// //                          setState(() {
// //                            data = cartDatabaseProvider.db.getAllItem();
// //                          });
// //                        },
// //                        icon: Icon(
// //                          Icons.remove,
// //                          size: 20,
// //                        ),
// //                      ),
// //                      Text(
// //                        productQuantity.toString(),
// //                        style: TextStyle(fontSize: 20),
// //                      ),
// //                      IconButton(
// //                        color: Colors.red,
// //                        onPressed: () async {
// //                          currcount = int.parse(productQuantity) + 1;
// //                          await cartDatabaseProvider.db.updateitem(new Item(
// //                              name: productName,
// //                              type: productType,
// //                              quantity: currcount,
// //                              storeprice: productPrice,
// //                              mrp: productmrp,
// //                              id: productID));
// //
// //                          setState(() {
// //                            data = cartDatabaseProvider.db.getAllItem();
// //                          });
// //                        },
// //                        icon: Icon(
// //                          Icons.add,
// //                          size: 20,
// //                        ),
// //                      )
// //                    ],
// //                  ),
// //                ])
// //              ],
// //            )),
// //      ),
// //    );
// //  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.red[400],
//         body: SafeArea(
//             child: ListView(
//           children: <Widget>[
//             SizedBox(height: 15.0),
//             Padding(
//               padding: EdgeInsets.only(left: 0.0),
//               child: Column(children: <Widget>[
//                 Text('Your Cart',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'QuickSand',
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                     )),
//                 SizedBox(height: 10.0),
//                 Text(
//                   'Subtotal: ₹$subtot',
//                   style: textStyle,
//                 ),
//                 Text(
//                   'Delivery Charges: ₹$delcharge',
//                   style: textStyle,
//                 ),
//                 Text(
//                   'Taxes: ₹$surcharge',
//                   style: textStyle,
//                 ),
//                 Text(
//                   'Total: ₹$totalcost',
//                   style: textStyle,
//                 )
//               ]),
//             ),
//             SizedBox(
//               height: 40.0,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height - 185.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0)),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: 10.0,
//                   left: 8.0,
//                   right: 8.0,
//                 ),
//                 child: Column(children: <Widget>[
//                   FutureBuilder<List<Object>>(
//                     future: cartProducts,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return Expanded(child: buildListView(snapshot.data));
//                       } else {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                     },
//                   ),
//                 ]),
//               ),
//             ),
//           ],
//         )),
//         floatingActionButton: FloatingActionButton(
//           onPressed: null,
//           backgroundColor: Colors.red[400],
//           foregroundColor: Colors.white,
//           child: Icon(Icons.play_arrow),
//         ));
//   }

//   Widget buildListView(List<Object> cartProducts) {
//     return cartProducts.length > 0
//         ? ListView.builder(
//             itemExtent: 120,
//             shrinkWrap: true,
//             itemCount: cartProducts.length,
//             itemBuilder: (BuildContext context, int index) {
//               return buildCard(cartProducts[index]);
//             },
//           )
//         : Center(
//             child: Text("No Products Available"),
//           );
//     ;
//   }

//   Future<List<Object>> getCartProducts(BuildContext context) async {
//     List<Object> cartProducts = new List<Object>();

//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var jsonResponse = null;
//     String url =
//         'https://arcane-badlands-38563.herokuapp.com/api/customers/cart';
//     Map<String, String> headers = {
//       "x-auth-token": sharedPreferences.getString("token"),
//       "Content-type": "application/json"
//     };
//     // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
//     // make GET request
//     http.Response response = await http.get(url, headers: headers);
//     print(response.body);
//     if (response.statusCode == 200) {
//       jsonResponse = jsonDecode(response.body);
//       //return jsonResponse;
//       print(jsonResponse);
//       for (var item in jsonResponse) {
//         cartProducts.add(item);
//       }
//       return cartProducts;
//     } else {
//       Alert(
//               context: context,
//               title: "Couldn't find products",
//               desc: "Please check your internet connection")
//           .show();
//     }
//   }
// }

// const TextStyle textStyle = TextStyle(
//   color: Colors.white,
//   fontFamily: 'QuickSand',
//   fontSize: 12.0,
//   fontWeight: FontWeight.bold,
// );
