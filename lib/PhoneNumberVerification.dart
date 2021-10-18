
import 'package:apliee/OTP_Screen.dart';
import 'package:apliee/SignUp_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class Enternumber extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Enternumber> {
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  bool showLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // PhoneNumber SignIn Method
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential?.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => signUp()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      setState(() {
        showLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: showLoading ?
      Center(
        child: Container(
          width: 35.0,
          height: 35.0,
          decoration: new BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: CircularProgressIndicator(backgroundColor: Colors.red, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        )) :
      currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE ? Scaffold(
        body: Container(
              height: MediaQuery.of(context).size.height,
              child:Padding(
                  padding:  EdgeInsets.only( top:200,left: screenWidth * 0.05, right: screenWidth * 0.05),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(child: const Text("Verify Phone Number", style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold),),),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Stack(
                        children: [
                          Container(
                            height:screenHeight*0.32,
                            width:screenWidth*0.80,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,
                                        blurRadius: 7,offset: Offset(0, 3)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child:Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top:screenHeight*0.04,left: screenWidth*0.02,right: screenWidth*0.02),
                                      child:Container(
                                        height: 50,
                                        child: TextField(
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.phone,
                                          controller: phoneController,
                                          decoration:InputDecoration(
                                              prefix: Padding(padding: EdgeInsets.all(4),child: Text('+91')),
                                              prefixIcon: Icon(Icons.phone,  color: Colors.black,),
                                              hintText: 'Phone number',
                                              filled: true,
                                              fillColor: Colors.white70),
                                        )
                                      )
                                    ),

                                    SizedBox(height: screenHeight*0.01),

                                     //Get OTP Button
                                     RaisedButton(
                                       color: Colors.red,
                                          onPressed: () async {
                                            if(phoneController.text.length>10 || phoneController.text.length<10)
                                            {
                                              Fluttertoast.showToast(msg: 'Please enter valid phone number');
                                            }
                                            else{
                                              setState(() {
                                                showLoading = true;
                                              });


                                            //Method to receive OTP on the PhoneNumber
                                              await _auth.verifyPhoneNumber(
                                                  phoneNumber:'+91' + phoneController.text,
                                                  verificationCompleted:(phoneAuthCredential){
                                                    setState(() {
                                                      showLoading = false;
                                                    });
                                                  },

                                                  verificationFailed: (FirebaseAuthException e)
                                                  {
                                                    setState(() {
                                                      showLoading = false;
                                                    });
                                                  },
                                                  codeSent: (verificationId, resendingToken)
                                                  {
                                                    setState(() {
                                                      showLoading = false;
                                                      this.verificationId = verificationId;
                                                    });

                                                    // Will navigate to OTP Screen
                                                    Navigator.push(
                                                        context, MaterialPageRoute(
                                                        builder: (context) => Otp_screen(
                                                              phonenumber: phoneController.text,
                                                              verificationid: verificationId)));
                                                  },
                                                  codeAutoRetrievalTimeout: (verificationId) {
                                                    setState(() {
                                                      this.verificationId = verificationId;
                                                    });
                                                  },
                                                  timeout: Duration(seconds: 30));
                                            }

                                          },
                                          child: const Text('GET OTP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)
                                        )
                                  ]
                                )
                            )
                          )
                        ]
                      )
                    ]
                  )
                )
              )
      ):
      Otp_screen(
        verificationid: verificationId,
        phonenumber: phoneController.text,
      ),
    );
  }
}
