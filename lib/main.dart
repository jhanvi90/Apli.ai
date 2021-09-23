import 'package:apliee/Home.dart';
import 'package:apliee/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authSatus(),
    );
  }
}

class authSatus extends StatefulWidget {
  const authSatus({Key key}) : super(key: key);

  @override
  _authSatusState createState() => _authSatusState();
}

class _authSatusState extends State<authSatus> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

   _authStatus() async
  {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LOGIN()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeContent()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return _authStatus();
  }
}

