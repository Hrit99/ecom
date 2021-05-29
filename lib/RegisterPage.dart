import 'dart:convert';
import './LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = './registerPage';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();
  final TextEditingController phnController = new TextEditingController();
  final TextEditingController deliveryLocation = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.red[200]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  Register(String name, String phone, String pass, String location) async {
//    var response=http.post(
//      'https://radiant-badlands-00539.herokuapp.com/users/login',
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//      },
//      body: jsonEncode(<String, String>{
//        'email': email,
//        'password': pass,
//      }),
//    );
    String url = 'https://arcane-badlands-38563.herokuapp.com/api/customers';
    Map<String, String> headers = {"Content-type": "application/json"};
    // String json = '{"email": "priyansh@gmail.com", "password": "123456"}';
    String json = jsonEncode(<String, String>{
      'name': name,
      'phone': phone,
      'password': pass,
      'location': location
    });
    // make POST request
    http.Response response = await http.post(url, headers: headers, body: json);
    //  var response = await http.post("https://radiant-badlands-00539.herokuapp.com/users/login", body:data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginPageState.routeName, (route) => false);
    } else if (response.statusCode == 400) {
      Alert(
              context: context,
              title: "Registration Failed",
              desc: "User already registered")
          .show();
      setState(() {
        _isLoading = false;
        nameController.text = '';
        phnController.text = '';
        passwordController.text = '';
        confirmPasswordController.text = '';
        deliveryLocation.text = '';
      });
    } else {
      Alert(
              context: context,
              title: "Registration Failed",
              desc: "Invalid Phone number or Password")
          .show();
      setState(() {
        _isLoading = false;
        nameController.text = '';
        phnController.text = '';
        passwordController.text = '';
        confirmPasswordController.text = '';
        deliveryLocation.text = '';
      });
    }
  }

  Container buttonSection() {
    return Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0, left: 25.0, right: 25.0),
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          if ((phnController.text != "") &&
              (nameController.text != "") &&
              (passwordController.text != "") &&
              (deliveryLocation.text != '')) {
            setState(() {
              _isLoading = true;
            });
            Register(nameController.text, phnController.text,
                passwordController.text, deliveryLocation.text);
          } else {
            Alert(
                    context: context,
                    title: "Registration Failed",
                    desc: "Invalid Phone Number or Password")
                .show();
            setState(() {
              _isLoading = false;
              nameController.text = '';
              phnController.text = '';
              passwordController.text = '';
              confirmPasswordController.text = '';
              deliveryLocation.text = '';
            });
          }
        },
        child: Text("Register", style: TextStyle(color: Colors.black)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            cursorColor: Colors.white,
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              icon: Icon(Icons.perm_identity, color: Colors.white70),
              hintText: "Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: phnController,
            cursorColor: Colors.white,
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.white70),
              hintText: "Phone Number",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            validator: (String value) {
              return value.length == 10 ? null : 'invalid phone number';
            },
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              icon: Icon(Icons.lock_open, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: deliveryLocation,
            cursorColor: Colors.white,
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              icon: Icon(Icons.location_on, color: Colors.white70),
              hintText: "Delivery Location",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
