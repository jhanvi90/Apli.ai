
import 'dart:io';
import 'package:apliee/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}
class _HomeContentState extends State<HomeContent> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //SignOut User Method
   Future _signOut()  async{
    await FirebaseAuth.instance.signOut();

  }


//Home Page data display widget
  Widget displayData()
  {
    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.requireData;
          final name=data.docs[0]['Username'];
          if (!snapshot.hasData) {
            return Center(
              child: Text("No data found!!"),
            );
          }
          else if(snapshot.hasData){
           return Center(
             child: Text("Welcome $name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)
           );
          }
        });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
       exit(0);
      },
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Home Page",style: TextStyle(color: Colors.black),),
            TextButton(
                onPressed: (){
              _signOut().whenComplete(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LOGIN()),);
              });
            }, child:Text("LogOut",style: TextStyle(color: Colors.black),))
          ],),
        ),

        body: displayData()
      ),
    );
  }

}