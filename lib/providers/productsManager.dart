import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsManager with ChangeNotifier {
  int _index;

  set setProductIndex(int val) {
    _index = val;
  }

  int get getProductIndex {
    return _index;
  }

  double _totalPrice = 0;

  double get getTot {
    return _totalPrice;
  }

  set setTot(double val) {
    _totalPrice = val;
  }

  Future<List<Map<dynamic, dynamic>>> getProducts(String category) async {
    List<Map<dynamic, dynamic>> categoryProducts =
        new List<Map<dynamic, dynamic>>();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/products/category/${category}';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };
    // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
    // make GET request
    http.Response response = await http.get(url, headers: headers);
    //  var response = await http.post("https://radiant-badlands-00539.herokuapp.com/users/login", body:data);
    // print('pl');
    // print(response.body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      //return jsonResponse;

      for (var item in jsonResponse) {
        categoryProducts.add(item);
      }
      return categoryProducts;
    } else {
      return null;
    }
  }

  Future<List<Map<dynamic, dynamic>>> getCartProducts() async {
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
      jsonResponse = jsonDecode(response.body);
      //return jsonResponse;
      //print(jsonResponse);
      _totalPrice = 0;
      for (var item in jsonResponse) {
        _totalPrice = _totalPrice + item['product']['price'] * item['quantity'];
        cartProducts.add(item);
      }
      print('total done here');
      return cartProducts;
    } else {
      return null;
    }
  }
}
