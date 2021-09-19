import 'dart:async';
import 'package:apliee/Home.dart';
import 'package:apliee/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _auth.authStateChanges().listen((user) {
        if (user == null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LOGIN()));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeContent()));
        }
      });

    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/updimg.png'),
          Text("PicToShare",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
        ],
      ),
    );
  }
}
