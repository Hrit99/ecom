import 'package:ecomm_app/providers/cartAddDelete.dart';
import 'package:ecomm_app/providers/orderProvider.dart';
import 'package:ecomm_app/providers/totalCountProvider.dart';
import 'package:ecomm_app/screens/locationSelect.dart';
import 'package:ecomm_app/widgets/cartButton.dart';

import './RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './homepage.dart';
import './LoginPage.dart';
import './widgets/signinAPI.dart';
import './screens/products_page.dart';
import 'providers/productsManager.dart';
import './screens/cartscreen.dart';

void main() => runApp(MyApp());

final key = new GlobalKey<CartButtonState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('start');
    return ChangeNotifierProvider(
      create: (context) => CartAddDelete(),
      child: ChangeNotifierProvider(
        create: (context) => OrderProvider(),
        child: ChangeNotifierProvider(
          create: (context) => TotalCountProvider(),
          child: ChangeNotifierProvider<ProductsManager>(
            create: (context) => ProductsManager(),
            child: MaterialApp(
                title: "My App",
                debugShowCheckedModeBanner: false,
                home: LoadingPage(),
                theme: ThemeData(
                  primarySwatch: Colors.red,
                  accentColor: Colors.redAccent,
                ),
                routes: {
                  MyHomePage.routeName: (ctx) => MyHomePage(),
                  LoginPageState.routeName: (ctx) => LoginPageState(),
                  RegisterPage.routeName: (ctx) => RegisterPage(),
                  SignIn.routeName: (ctx) => SignIn(),
                  ProductsPage.routeName: (ctx) => ProductsPage(),
                  CartScreen.routeName: (ctx) => CartScreen(),
                  LocationSelect.routeName: (ctx) => LocationSelect(),
                }),
          ),
        ),
      ),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  SharedPreferences sharedPreferences;

//  gettodos() async{
//    http.Response response= await http.get('https://radiant-badlands-00539.herokuapp.com/todos');
//    print(response.body);
//  }
  @override
  void initState() {
    print('init');
    super.initState();
    // gettodos();
    // print(sharedPreferences.getString("token")==null);
    //print('pagal');
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));

    //To clear the shared prefences
    //sharedPreferences.clear();
    if (sharedPreferences.getString("token") == null) {
      print('pagal');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginPageState.routeName, (route) => false);
      print('end');
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MyHomePage.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('starts');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitDoubleBounce(
          duration: Duration(milliseconds: 2000),
          color: Colors.redAccent,
          size: 100.0,
        ),
      ),
    );
  }
}
