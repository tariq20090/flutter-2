import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_page.dart';
import 'cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}


