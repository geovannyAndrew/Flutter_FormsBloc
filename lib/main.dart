import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/pages/home_page.dart';
import 'package:forms_validation/src/pages/login_page.dart';
import 'package:forms_validation/src/pages/product_page.dart';
import 'package:forms_validation/src/pages/register_page.dart';
import 'package:forms_validation/src/user_preferences/user_preferences.dart';
 
void main() async{
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login'   : (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'home'    : (BuildContext context) => HomePage(),
          'product' : (BuildContext context) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}