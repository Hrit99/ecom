import 'package:ecomm_app/providers/cartInfoFlag.dart';
import 'package:flutter/material.dart';
import 'package:ecomm_app/buildcard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LoginPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences;
    return Scaffold(
        appBar: AppBar(
          title: Text("Main Page", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.clear();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginPageState.routeName, (route) => false);
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: MediaQuery.of(context).size.width / 10,
              mainAxisSpacing: MediaQuery.of(context).size.height / 20,
            ),
            itemBuilder: (context, index) {
              return BuildCard(
                id: index + 1,
                ctx: context,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: 6,
          ),
        ));
  }
}
