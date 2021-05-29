import 'package:flutter/material.dart';
import 'package:ecomm_app/LoginPage.dart';
import 'package:ecomm_app/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static const routeName = './signIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  getSignInVerification() async {
    try {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      final phone = routeArgs['phone'];
      final pass = routeArgs['pass'];
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var jsonResponse;
      String url =
          'https://arcane-badlands-38563.herokuapp.com/api/login/customer';
      Map<String, String> headers = {"Content-type": "application/json"};
      // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
      String json =
          jsonEncode(<String, String>{'phone': phone, 'password': pass});
      // make POST request
      await http.post(url, headers: headers, body: json).then((response) {
        print(response.body);
        print('hiii');
        print(response.statusCode);
        if (response.statusCode == 200) {
          print('1');
          jsonResponse = jsonDecode(response.body);

          if (jsonResponse != null) {
            var token = response.headers['x-auth-token'];
            sharedPreferences.setString("token", token);
            print('2');
            print(response.body);
            Navigator.of(context).pushNamedAndRemoveUntil(
                MyHomePage.routeName, (route) => false);
          }
        } else {
          Alert(
                  context: context,
                  title: "Login Failed",
                  desc: "Please try again")
              .show()
              .then((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginPageState.routeName, (route) => false);
          });
        }
      }).catchError((e) {
        print("Got error: ${e.error}"); // Finally, callback fires.
        return 42; // Future completes with 42.
      });
    } on Exception catch (_) {
      print('nothing');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    getSignInVerification();
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
