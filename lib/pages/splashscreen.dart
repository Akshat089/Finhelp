import 'dart:async';
import 'package:flutter/material.dart';
import 'package:finance_chatbot/pages/login_or_register.dart';

class Splashscreen extends StatefulWidget {
  @override
  SplashscreenState createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginOrRegister()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 122, 194),
      body: Center(
        child: Image.asset('lib/images/logo.jpg',
                    fit: BoxFit.contain,height: 200,width: 200,),
      )
    );
  }
}
