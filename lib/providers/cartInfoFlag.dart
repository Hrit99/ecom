import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartInfoFlag with ChangeNotifier {
  Map<String, int> cartMap = {'123': 2};

  set addToMap(Map<String, int> val) {
    cartMap.addAll(val);
  }

  set removeFromMap(String val) {
    cartMap.remove(val);
  }

  set addElement(String val) {
    cartMap[val]++;
  }

  set subtractElement(String val) {
    cartMap[val]--;
  }

  Map<String, int> get printitMap {
    return cartMap;
  }
}
