import 'package:ecomm_app/providers/cartAddDelete.dart';
import 'package:ecomm_app/providers/orderProvider.dart';
import 'package:ecomm_app/providers/totalCountProvider.dart';
import 'package:ecomm_app/widgets/cartList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottombarCart extends StatefulWidget {
  BottombarCart() {
    print('hry');
  }

  @override
  _BottombarCartState createState() => _BottombarCartState();
}

class _BottombarCartState extends State<BottombarCart> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    var st = Provider.of<TotalCountProvider>(context);
    print(st.getFlag);
    var op = Provider.of<OrderProvider>(context, listen: false);
    if ((st.getTotalBill != null) && (st.getFlag != true)) {
      print('bar build${st.getTotalBill}');
      return FloatingActionButton.extended(
        onPressed: () {
          // if (!flag) {
          //   op.placeOrder(context, 1).then((value) {
          //     setState(() {
          //       flag = true;
          //       print('a');

          //       op.setCart();
          //     });
          //   });
          // }
        },
        label: Container(
          width: MediaQuery.of(context).size.width / 1.25,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Total',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  Text(
                    '₹${st.getTotalBill.toString()}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              Text(
                (flag) ? 'Order Placed' : 'Place Order',
                style: TextStyle(color: Colors.black26, fontSize: 25),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.amber,
      );
    } else {
      st.setFlag = false;
      return FloatingActionButton.extended(
        onPressed: () {},
        label: Container(
          width: MediaQuery.of(context).size.width / 1.25,
          height: 30,
        ),
        backgroundColor: Colors.amber,
      );
    }
  }
}
