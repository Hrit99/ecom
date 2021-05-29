import 'dart:convert';

import 'package:ecomm_app/providers/cartInfoFlag.dart';
import 'package:ecomm_app/widgets/addingButton.dart';
import 'package:ecomm_app/widgets/cartCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/productsManager.dart';
import '../providers/cartAddDelete.dart';

class ProductsList extends StatelessWidget {
  final String categoryName;
  ProductsList(this.categoryName);
  var counter = Map<int, int>();
  @override
  Widget build(BuildContext context) {
    print('build list');
    final productsManage = Provider.of<ProductsManager>(context, listen: false);
    final categoryProducts = productsManage.getProducts(categoryName);
    final cartProducts = productsManage.getCartProducts();
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
          future: categoryProducts,
          builder: (context, snapshot) {
//                                TODO: Snapshot end then no loading.
            if (snapshot.data != null) {
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
                    counter[i] = 0;

                    return Dismissible(
                      key: Key(snapshot.data[i]['_id']),
                      background: Container(
                        color: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              height: 20,
                              color: Theme.of(context).accentColor,
                              width: double.infinity,
                              child: Text(
                                "Details",
                                style: TextStyle(color: Colors.amber),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: Colors.grey,
                                padding: EdgeInsets.only(left: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //     'Shop Keeper: ${product['userId']['name']}',
                                    //     style: TextStyle(
                                    //         fontFamily: 'Montserrat',
                                    //         fontSize: 12.0,
                                    //         color: Colors.black)),

                                    Text(
                                        'Shop Phn: ${snapshot.data[i]['userId']['phone'].toString()}',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12.0,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      ),
                      dismissThresholds: {DismissDirection.startToEnd: 100},
                      direction: DismissDirection.startToEnd,
                      child: FutureBuilder<List<Map<dynamic, dynamic>>>(
                        future: cartProducts,
                        builder: (context, snap) {
                          if (snap.data != null) {
                            for (int j = 0; j < snap.data.length; j++) {
                              if ((snapshot.data[i]['_id']) ==
                                  (snap.data[j]['product']['_id'])) {
                                return CartCard(snapshot.data[i], i, 'add', 1);
                              }
                            }
                            return CartCard(snapshot.data[i], i, 'add', 2);
                          } else {
                            return CartCard(snapshot.data[i], i, 'add', 0);
                          }
                        },
                        // child: CartCard(snapshot.data[i], i, 'add'));
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
    //   ],
    // );
  }
}
