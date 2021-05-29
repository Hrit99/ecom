import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartAddDelete with ChangeNotifier {
  int _index;
  bool _flag;
  bool _delRecent;
  int _quant;
  int _sum;
  var _listStrIdCart;
  var _addFlag;
  var _addhereFlag = false;
  double _totalBill = 0;

  set setIndex(int val) {
    _index = val;
  }

  int get getIndex {
    return _index;
  }

  bool get getStrFlag {
    return _flag;
  }

  set setStrFlag(bool val) {
    _flag = val;
  }

  bool get getDelFlag {
    return _delRecent;
  }

  int get getSum {
    return _sum;
  }

  set setDelFlag(bool val) {
    _delRecent = val;
  }

  int get getRecentQuant {
    return _quant;
  }

  List<String> get getlistId {
    return _listStrIdCart;
  }

  set setlistId(List<String> val) {
    print('setter');
    _listStrIdCart = val;
    print(_listStrIdCart);
  }

  bool get getAddFlag {
    return _addFlag;
  }

  set setAddFlag(bool val) {
    _addFlag = val;
  }

  bool get getAddhereFlag {
    return _addhereFlag;
  }

  set setAddhereFlag(bool val) {
    _addhereFlag = val;
  }

  Future<bool> addToCart(var id, var sellerId, var quantity) async {
    print('addcart starts');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/customers/cart';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };
    String json = jsonEncode(
        <String, String>{'_id': id, 'userId': sellerId, 'quantity': quantity});
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      // print(_index);
      // var quantity = jsonResponse[_index]['quantity'];
      // _quant = quantity;
      // print('addd$_quant ${jsonResponse[_index]['_id']}');
      _addhereFlag = true;
      // _sum = _sum + jsonResponse[_index]['product']['price'];
      // notifyListeners();
      print('add cart closes');
      return true;
    } else {
      // Toast.show("Failed to Add Product", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }

  Future<bool> deleteFromCart(var id) async {
    print('del cart starts');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    String url =
        'https://arcane-badlands-38563.herokuapp.com/api/customers/cart/${id}';
    Map<String, String> headers = {
      "x-auth-token": sharedPreferences.getString("token"),
      "Content-type": "application/json"
    };
    http.Response response = await http.delete(url, headers: headers);

    print(response.body);
    if (response.statusCode == 200) {
      print('dlete');
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

  // Future checkIfInCart() async {
  //   List<String> cartProductsId = new List<String>();

  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var jsonResponse = null;
  //   String url =
  //       'https://arcane-badlands-38563.herokuapp.com/api/customers/cart';
  //   Map<String, String> headers = {
  //     "x-auth-token": sharedPreferences.getString("token"),
  //     "Content-type": "application/json"
  //   };
  //   // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
  //   // make GET request
  //   http.Response response = await http.get(url, headers: headers);
  //   if (response.statusCode == 200) {
  //     jsonResponse = jsonDecode(response.body);
  //     //return jsonResponse;
  //     //print(jsonResponse);
  //     var t = jsonResponse.length;
  //     for (int i = 0; i < t; i++) {
  //       cartProductsId.add(jsonResponse[i]['product']['_id']);
  //     }
  //     print(cartProductsId);
  //     setlistId = cartProductsId;
  //   }
  // }
}
