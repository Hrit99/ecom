import 'package:ecomm_app/widgets/bottombarCart.dart';
import 'package:flutter/material.dart';

class TotalCountProvider with ChangeNotifier {
  double _total = 0.0;
  bool _flag = false;
  int _quant = 0;
  // set setTotalBill(double val) {
  //   notifyListeners();
  //   _totalBill = val;
  // }

  set setFlag(bool val) {
    _flag = val;
  }

  bool get getFlag {
    return _flag;
  }

  set setquant(int val) {
    _quant = val;
  }

  int get getquant {
    return _quant;
  }

  double get getTotalBill {
    return _total;
  }

  void setBar(double val) {
    _total = val;
    print('not');
    notifyListeners();
  }
}
