import 'dart:convert';
import 'dart:io';
import 'package:apliee/Home.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class upload extends StatefulWidget {
  @override
  _uploadState createState() => _uploadState();
}

class _uploadState extends State<upload> {
  final _formKey = GlobalKey<FormState>();
   File _pickedImage;
  final picker=ImagePicker();

  Future getimgGallery()
  async {
    final pickimage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickimage != null) {
        _pickedImage = File(pickimage.path);
      }
    });
  }

  //TextEditing Controllers
  TextEditingController name=TextEditingController();
  TextEditingController hastag=TextEditingController();

  //PopDailog
  Future<bool> showPopDialog(BuildContext context) async {
    return showDialog<bool>(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                    shape:
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.white,
                    elevation: 20,
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10,),
                        Text("uploading...."),
                      ],
                    )

                );
              });
        });
  }
  Future<void> uploadImage(File file) async {
    final _fireStorage = FirebaseStorage.instance;
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    var permissionStatus = await Permission.photos.status;
    // Checking Permission
    if (permissionStatus.isGranted) {

      String fileName = file.uri.path.split('/').last;

      // Uploading Image to FirebaseStorage
      var filePath = await _fireStorage.ref().child('demo/$fileName').putFile(file).then((value) {
        return value;
      });
      // Getting Uploaded Image Url
      String downloadUrl = await filePath.ref.getDownloadURL();

      await  FirebaseFirestore.instance.collection("user").doc(firebaseUser.uid).collection("images").add({"url": downloadUrl, "name": name.text,
      "userid":firebaseUser.uid,"date": DateTime.now(),"hashtag":hastag.text
      });
    } else {
      print('No Image Selected');
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getimgGallery().whenComplete((){
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {

    //Screen Width and Height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){Navigator.pop(context);},
          ),
        ),
        body:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:screenHeight*0.05),
              Container(
                height: screenHeight*0.40,
                width:screenWidth,
                child:Center(
                  child: Image.file(_pickedImage,width:screenWidth*0.9,height:screenHeight*0.40,fit: BoxFit.cover))),

              SizedBox(height:screenHeight*0.03),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>
                  [
                    Padding(
                      padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                      child: Container(
                        child: TextFormField(
                          controller: name,
                          //validation
                          validator: (value){
                            if(value.isEmpty)
                            {
                              return 'Please enter name';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText:'Name',
                              filled: true,
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                      child: Container(
                        child: TextFormField(
                          controller: hastag,
                          validator: (value){
                            if(value.isEmpty)
                              {
                                return 'Please enter hashtag';
                              }
                            else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Write hashtag',
                              filled: true,
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),

                    SizedBox(height:screenHeight*0.05),

                    RaisedButton(
                      color: Colors.red.withOpacity(0.7),
                      onPressed: (){
                        showPopDialog(context);
                     if(_formKey.currentState.validate())
                       {
                         uploadImage(_pickedImage).whenComplete(()
                         {
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                               HomeContent()),);
                         });
                       }
                    },child: Text("Save",style: TextStyle(color: Colors.white),),)
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
