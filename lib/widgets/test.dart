import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("test build");
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).accentColor,
    );
  }
}
