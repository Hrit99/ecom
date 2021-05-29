import 'package:ecomm_app/widgets/setLocation.dart';
import 'package:flutter/material.dart';

class LocationSelect extends StatelessWidget {
  static final routeName = './locationSelect';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delievery Address', style: TextStyle(color: Colors.white)),
      ),
      body: SetLocation(),
    );
  }
}
