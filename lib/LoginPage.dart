import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './RegisterPage.dart';
import './widgets/signinAPI.dart';

class LoginPageState extends StatefulWidget {
  static const routeName = './loginPage';

  @override
  _LoginPageStateState createState() => _LoginPageStateState();
}

class _LoginPageStateState extends State<LoginPageState> {
  TextEditingController phnController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  @override
  void didChangeDependencies() {
    context.dependOnInheritedWidgetOfExactType();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
        child: ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            Container(

//      height: 40.0,
//
//      padding: EdgeInsets.symmetric(horizontal: 15.0),
//      margin: EdgeInsets.only(top: 15.0,left: 25.0,right: 25.0),
                child: Column(
              children: <Widget>[
                RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    if ((phnController.text != '') &&
                        (passwordController.text != '')) {
                      // SignIn(phnController.text, passwordController.text);
                      Navigator.of(context)
                          .pushNamed(SignIn.routeName, arguments: {
                        'phone': phnController.text,
                        'pass': passwordController.text,
                      });
                      // ob.build(context);
                      // ob.signIn(context);
                    } else {
                      setState(() {
                        phnController.text = '';
                        passwordController.text = '';
                      });
                    }
                  },
                  child: Text("Sign In", style: TextStyle(color: Colors.black)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RegisterPage.routeName, (route) => false);
                  },
                  child:
                      Text("Register", style: TextStyle(color: Colors.black)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: phnController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.white70),
              hintText: "Phone Number",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            validator: (String value) {
              print('validator');
              return value.length == 10 ? null : 'invalid Phone Number';
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
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
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
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: const Text("Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
