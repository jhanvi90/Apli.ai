import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class upload extends StatefulWidget {
  @override
  _uploadState createState() => _uploadState();
}

class _uploadState extends State<upload> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController itemName=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController itemUnit=TextEditingController();
  TextEditingController category=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController stockUnit=TextEditingController();
  String _unitQty;
  String _stockQty;

  File _pickedImage;
  final picker=ImagePicker();

  Future GetImageFromGallery()
  async {
    final pickimage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickimage != null) {
        _pickedImage = File(pickimage.path);
      }
    });
  }
  var _qtys = [
    "Kgs",
    "grams"
  ];
  String imageToUpload;

  // uploading PopDailog
  Future<bool> showPopDialog(BuildContext context) async {
    return showDialog<bool>(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  Future<void> uploadImageToFirebase(File file) async {
    final _fireStorage = FirebaseStorage.instance;
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    var permissionStatus = await Permission.photos.status;

    // Permission Check for get image from device
    if (permissionStatus.isGranted)
    {
      String fileName = file.uri.path.split('/').last;
      // Uploading Image to FirebaseStorage
      var filePath = await _fireStorage.ref().child('demo/$fileName').putFile(file).then((value) {
        return value;
      });

      // Getting Uploaded Image Url from firebase
      String downloadUrl = await filePath.ref.getDownloadURL();
      setState(() {
        imageToUpload=downloadUrl;
      });


    } else {
      print('No Image Selected');
    }
  }

  Widget UploadDataWidget(BuildContext context)
  {
    //Screen Width and Height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height:screenHeight*0.04),
        GestureDetector(
          onTap: (){
            GetImageFromGallery();
          },
          child: Container(
              height: screenHeight*0.20,
              width:screenWidth,
              child:_pickedImage==null?Container(
                child: Center(child: RaisedButton(
                  color: Colors.black,
                  onPressed: (){
                   GetImageFromGallery();
                  },
                  child: Text("Upload Image",style: TextStyle(color: Colors.white),),
                ) ),
              ):Center(child: Image.file(_pickedImage,width:screenWidth*0.9,height:screenHeight*0.40,fit: BoxFit.cover))
          ),
        ),
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
                    controller: itemName,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter name';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText:'Item Name', filled: true, fillColor: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                child: Container(
                  child: TextFormField(
                    controller: price,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter price';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Price', filled: true, fillColor: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                child: Container(
                  child: TextFormField(
                    controller: itemUnit,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter unit';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Enter Unit', filled: true, fillColor: Colors.white70),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Quantity"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _unitQty,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _unitQty = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _qtys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                child: Container(
                  child: TextFormField(
                    controller: category,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter category';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Enter Category', filled: true, fillColor: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                child: Container(
                  child: TextFormField(
                    controller: description,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter description';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Description', filled: true, fillColor: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
                child: Container(
                  child: TextFormField(
                    controller: stockUnit,
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Please enter stock units';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Stock Units', filled: true, fillColor: Colors.white70),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Quantity"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _stockQty,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _stockQty = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _qtys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height:screenHeight*0.03),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: (){
                    showPopDialog(context);
                    if(_formKey.currentState.validate())
                    {
                      uploadImageToFirebase(_pickedImage).whenComplete(()
                      async {
                        var firebaseUser = await FirebaseAuth.instance.currentUser;
                        await  FirebaseFirestore.instance.collection("AddProducts").doc(firebaseUser.uid).
                        collection("Product").add({
                          "url": imageToUpload,
                          "itemName": itemName.text,
                          "userid":firebaseUser.uid,
                          "price":price.text,
                          "itemUnit":itemName.text,
                          "itemQty":_unitQty,
                          "category":category.text,
                          "desp": description.text,
                          "stockUnit":stockUnit.text,
                          "stockQty":_stockQty
                        }).whenComplete((){
                          Navigator.pop(context);
                        });
                      });
                    }
                  },child: Text("Add Item",style: TextStyle(color: Colors.white),),),
              ),

            ],
          ),
        ),
      ],
    );
  }


  @override
  void initState()
  {
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Add Product"),
      ),
        body:SingleChildScrollView(child: UploadDataWidget(context)),
    );
  }
}
