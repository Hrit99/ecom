import 'package:ecomm_app/providers/productsManager.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import '../screens/orders_page.dart';
import '../screens/home_screen.dart';

class OrderProvider with ChangeNotifier {
  void setCart() {
    notifyListeners();
  }

  int _cartCount = 0;

  set setCartCount(int val) {
    _cartCount = val;
  }

  int get getCartCount {
    return _cartCount;
  }

  Future<List<Map<dynamic, dynamic>>> getCartProductsOrder() async {
    print('ji');
    List<Map<dynamic, dynamic>> cartProducts =
        new List<Map<dynamic, dynamic>>();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/customers/cart';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };
    // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
    // make GET request
    http.Response response = await http.get(url, headers: headers);
    //print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      jsonResponse = jsonDecode(response.body);
      //return jsonResponse;
      //print(jsonResponse);
      // _totalPrice = 0;
      for (var item in jsonResponse) {
        // _totalPrice = _totalPrice + item['product']['price'] * item['quantity'];
        cartProducts.add(item);
      }
      // print('total done here');
      print(cartProducts);
      return cartProducts;
    } else {
      return null;
    }
  }

  Future<bool> placeOrder(var context, var v) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/customers/myOrders';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };

    // String json = jsonEncode(
    //     <String, String>{'_id': id, 'userId': sellerId, 'quantity': quantity});
    print(_cartCount);
    http.Response response;

    getCartProductsOrder().then((product) async {
      print('nmnn$product');
      for (int i = 0; i < _cartCount; i++) {
        String json = jsonEncode(<String, String>{
          '_id': product[i]['_id'].toString(),
          'userId': product[i]['userId']['_id'].toString(),
          'quantity': product[i]['quantity'].toString(),
          '__v': v.toString(),
        });

        response = await http.post(url, headers: headers, body: json);
      }
    });

    // http.Response response = await http.get(url, headers: headers);

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('yet');
      return true;
    } else {
      return false;
    }

    // if (true) {
    //   //Alert(context: context, title: "Order Placed Successfully", desc: "Please check My Orders for more details").show();
    //   Alert(
    //     context: context,
    //     type: AlertType.success,
    //     title: "Success",
    //     desc: "Check My Orders for more details.",
    //     buttons: [
    //       DialogButton(
    //         child: Text(
    //           "Continue",
    //           style: TextStyle(color: Colors.white, fontSize: 20),
    //         ),
    //         onPressed: () => Navigator.pop(context),
    //         width: 120,
    //       )
    //     ],
    //   ).show();
    //   Toast.show("Thanks For Placing Order", context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // } else {
    //   Toast.show("Failed to Place Order", context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }
  }

  Future<List<Map<dynamic, dynamic>>> getMyOrders() async {
    print('I am In Orders');
    List<Map<dynamic, dynamic>> myOrders = new List<Map<dynamic, dynamic>>();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/customers/myOrders';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };
    // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
    // make GET request
    http.Response response = await http.get(url, headers: headers);
    //  var response = await http.post("https://radiant-badlands-00539.herokuapp.com/users/login", body:data);
    //print(response.body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      //return jsonResponse;

      for (var item in jsonResponse) {
        myOrders.add(item);
      }
      print('gh');
      var v = myOrders.reversed.toList();
      print(v.length);
      return v;
    } else {
      return null;
    }
  }

  Future<bool> deleteFromOrder(var id) async {
    print('del Or starts');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/customers/myOrders/${id}';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };
    http.Response response = await http.delete(url, headers: headers);

    print(response.body);
    if (response.statusCode == 200) {
      print('dleteOrrder');
      jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      // print(_index);
      // var quantity = jsonResponse[_index]['quantity'];
      // print('r$quantity');
      // _quant = quantity;
      // print('deld$_quant ${jsonResponse[_index]['_id']}');
      // notifyListeners();
      // _sum = _sum - jsonResponse[_index]['product']['price'];
      print('del close');
      return true;
    } else {
      print('jkl');
      return false;
    }
  }
}
