import 'package:apliee/HOME.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: HomeInvatary()
    );
  }
}
// class data extends StatefulWidget {
//   const data({Key key}) : super(key: key);
//
//   @override
//   _dataState createState() => _dataState();
// }
//
// class _dataState extends State<data> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           showSearch(context: context, delegate: NameSearch());
//         },
//       ),
//     );
//   }
// }


