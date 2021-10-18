
import 'dart:io';

import 'package:apliee/UploadPicture_Screen.dart';
import 'package:apliee/UploadedShowImgeScreen.dart';
import 'package:apliee/Login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}
class _HomeContentState extends State<HomeScreen> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  static convertTimeStamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }
   Future _signOut()  async{
    await FirebaseAuth.instance.signOut();
  }

  Widget DisplayUploadedimage()
  {
    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").doc(firebaseUser.uid).collection("images").orderBy("date").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No images found!!"),
            );
          }
          else if(snapshot.hasData){
            final images = snapshot.data.docs;
            List<ShowImageData> allImage = [];
            for (var image in images)
            {
                final imageText = image.get('name');
                final imageUrl = image.get('url');
                final hastag = image.get('hashtag');
                final imagedate=convertTimeStamp(image.get('date'));

                //ShowImageData Screen
                final imageUI = ShowImageData(
                url: imageUrl.toString(),
                name: imageText.toString(),
                date: imagedate.toString(),
                hashtag: hastag.toString(),
              );
              allImage.add(imageUI);
            }
            return ListView(
              children: allImage,
              reverse: false,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            IconButton(
            onPressed: (){
              _signOut().whenComplete(()
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LOGIN()),);
              });
            },
            icon: Icon(Icons.logout_rounded,color: Colors.black,))
          ])
        ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red.withOpacity(0.7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              child: Icon(Icons.add),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => upload()),);
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

        body: DisplayUploadedimage()

      ),
    );
  }

}