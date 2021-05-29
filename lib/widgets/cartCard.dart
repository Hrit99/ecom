import 'package:ecomm_app/providers/cartInfoFlag.dart';
import 'package:ecomm_app/providers/orderProvider.dart';
import 'package:ecomm_app/providers/productsManager.dart';
import 'package:ecomm_app/providers/totalCountProvider.dart';
import 'package:ecomm_app/widgets/addingButton.dart';
import 'package:ecomm_app/widgets/cartButton.dart';
import 'package:ecomm_app/widgets/test.dart';
import 'package:provider/provider.dart';
import '../providers/cartAddDelete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartCard extends StatelessWidget {
  final product;
  final str;
  final index;
  final btnStatus;
  CartCard(this.product, this.index, this.str, this.btnStatus);
  @override
  Widget build(BuildContext context) {
    print('build card');

    final adddeletePro = Provider.of<CartAddDelete>(context, listen: false);
    var tcpPro = Provider.of<TotalCountProvider>(context, listen: false);
    var op = Provider.of<OrderProvider>(context, listen: false);
    var proManage = Provider.of<ProductsManager>(context, listen: false);

    if (str == 'cart') {
      op.setCartCount = op.getCartCount + 1;
    }
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.75,
      direction: Axis.horizontal,
      closeOnScroll: false,
      key: Key(product['_id']),
      actions: [
        Container(
          color: Colors.amber,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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

                      Text('Shop Phn: ${product['userId']['phone'].toString()}',
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
      ],
      secondaryActions: [
        Container(
          color: Colors.amber,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Center(
            child: Text(
              (str == 'add')
                  ? 'Slide more to like'
                  : ((str == 'cart')
                      ? 'Slide more to delete'
                      : 'Slide more to cancel order'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        dismissThresholds: {SlideActionType.primary: 1.0},
        onWillDismiss: (actionType) {
          if (str == 'add') {
            print('not dismissed');
            return false;
          } else {
            return true;
          }
        },
        onDismissed: (actionType) {
          if (str == 'cart') {
            print('is dismissed${tcpPro.getquant}');
            print('removing ${product['_id']}');
            op.setCartCount = op.getCartCount - 1;
            adddeletePro.setIndex = index;

            adddeletePro
                .addToCart(product['product']['_id'].toString(),
                    product['userId']['_id'].toString(), '1')
                .then((_) {
              adddeletePro.deleteFromCart(product['product']['_id']).then((_) {
                print(tcpPro.getquant);
                proManage.setTot = proManage.getTot -
                    (product['product']['price'] * tcpPro.getquant);
                tcpPro.setBar(tcpPro.getTotalBill -
                    (product['product']['price'] * tcpPro.getquant));
              });
              print('hiii');
            });
          }
        },
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (str == 'add')
                        ? ' '
                        : ((str == 'cart')
                            ? ' '
                            : 'Qty : ${product['quantity'].toString()}'),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        color: Colors.orange[400]),
                  ),
                  Text(
                    '₹${(str == 'add') ? product['price'].toString() : ((str == 'cart') ? product['product']['price'].toString() : (product['product']['price'] * product['quantity']).toString())}',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        color: Colors.orange[400]),
                  ),
                ]),
          ),
          ListTile(
            enabled: true,
            autofocus: true,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            leading: Image.network(
              (str == 'add') ? product['img'] : product['product']['img'],
              height: 80,
              width: 60,
            ),
            title: Text(
                (str == 'add') ? product['name'] : product['product']['name'],
                style: TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 15.0,
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold)),
            subtitle:
                //  Column(
                //   children: [
                // Text(
                //   '₹${(str == 'add') ? product['price'].toString() : product['product']['price'].toString()}',
                //   style: TextStyle(
                //       fontFamily: 'Montserrat',
                //       fontSize: 20.0,
                //       fontWeight: FontWeight.w700,
                //       color: Colors.orange[400]),
                // ),
                Text('Shop: ${product['userId']['shopName']}',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 10.0,
                        color: Colors.blue)),
            //   ],
            // ),

            trailing:
                // Column(
                //   children: [
                //     Text(
                //       '₹${(str == 'add') ? product['price'].toString() : product['product']['price'].toString()}',
                //       style: TextStyle(
                //           fontFamily: 'Montserrat',
                //           fontSize: 12.0,
                //           color: Colors.orange[400]),
                //     ),
                (str == 'add')
                    // ? Test()
                    ? ((btnStatus == 0)
                        ? CircularProgressIndicator()
                        : ((btnStatus == 1)
                            ? AddingButton(
                                product['_id'],
                                product['userId']['_id'],
                                'Added',
                                product['price'])
                            : AddingButton(
                                product['_id'],
                                product['userId']['_id'],
                                'Add to Cart',
                                product['price'])))
                    : ((str == 'cart')
                        ? ChangeNotifierProvider(
                            create: (context) => CartInfoFlag(),
                            child: CartButton(product, index))
                        : Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: RaisedButton(
                              color: product['completed']
                                  ? Colors.green
                                  : Colors.redAccent,
                              onPressed: () {},
                              child: Text(
                                  product['completed']
                                      ? "Delivered"
                                      : "Pending...",
                                  style: TextStyle(color: Colors.white)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          )),
            // ],
          ),
        ],
      ),
    );
    // );
  }
}
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//         child: Container(
//           margin: EdgeInsets.only(bottom: 20.0),
//           decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.red,
//                 width: 1.0,
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(10.0))),
//           child: GestureDetector(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.only(right: 8.0),
//                       child: Image.network(
//                         (str == 'add')
//                             ? product['img']
//                             : product['product']['img'],
//                         height: 80,
//                         width: 60,
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                           child: ListTile(
// //contentPadding: EdgeInsets.all(10.0),

// title: Text(
//     (str == 'add')
//         ? product['name']
//         : product['product']['name'],
//     style: TextStyle(
//         fontFamily: 'QuickSand',
//         fontSize: 15.0,
//         color: Colors.red[400],
//         fontWeight: FontWeight.bold)),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
// Text(
//   '₹${(str == 'add') ? product['price'].toString() : product['product']['price'].toString()}',
//   style: TextStyle(
//       fontFamily: 'Montserrat',
//       fontSize: 12.0,
//       color: Colors.orange[400]),
// ),
//                             Text('Shop: ${product['userId']['shopName']}',
//                                 style: TextStyle(
//                                     fontFamily: 'Montserrat',
//                                     fontSize: 10.0,
//                                     color: Colors.blue)),
//                             Text(
//                                 'Shop Phn: ${product['userId']['phone'].toString()}',
//                                 style: TextStyle(
//                                     fontFamily: 'Montserrat',
//                                     fontSize: 10.0,
//                                     color: Colors.brown)),
//                           ],
//                         ),
//                       )
// //
//                           ),
//                     ),
// Padding(
//   padding: EdgeInsets.only(left: 10),
//   child: (str == 'add')
//       ? AddingButton(
//           product['_id'], product['userId']['_id'])
//       : ((str == 'cart')
//           ? CartButton(product, index)
//           : null),
// ),
//                   ],
//                 ),
//               )),
//         ),
//       ),
