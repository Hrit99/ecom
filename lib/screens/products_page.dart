import 'package:ecomm_app/providers/cartAddDelete.dart';
import 'package:ecomm_app/providers/cartInfoFlag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../widgets/productsList.dart';

class ProductsPage extends StatelessWidget {
  static final routeName = './productsPage';

  @override
  Widget build(BuildContext context) {
    print('build page');
    final categoryName = ModalRoute.of(context).settings.arguments as String;

    return ChangeNotifierProvider<CartAddDelete>(
      create: (context) => CartAddDelete(),
      child: ChangeNotifierProvider<CartInfoFlag>(
        create: (context) => CartInfoFlag(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryName, style: TextStyle(color: Colors.white)),
          ),
          body: ProductsList(categoryName),
        ),
      ),
    );
  }
}
