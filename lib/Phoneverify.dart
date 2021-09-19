


import 'package:apliee/OTP.dart';
import 'package:apliee/SignUp.dart';
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
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
   String verificationId;
  bool showLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("asd")));
    }
  }



  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: showLoading
          ? Center(
        child: Container(
          width: 35.0,
          height: 35.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircularProgressIndicator(
              backgroundColor: Colors.red,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
      )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
          ? Scaffold(
        body:
            Container(
              height: MediaQuery.of(context).size.height,
              child:  Padding(
                  padding:  EdgeInsets.only( top:200,left: screenWidth * 0.05, right: screenWidth * 0.05),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child:
                          const Text("Verify Phone Number",
                            style: TextStyle(
                                fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
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
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child:Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top:screenHeight*0.04,left: screenWidth*0.02,right: screenWidth*0.02),

                                      child:
                                      Container(
                                        height: 50,
                                        child: TextField(
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.phone,
                                          controller: phoneController,
                                          decoration:
                                          InputDecoration(
                                              prefix: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Text('+91'),
                                              ),
                                              prefixIcon: Icon(Icons.phone,  color: Colors.black,),
                                              hintText: 'Phone number',
                                              border: OutlineInputBorder(
                                                borderSide:  BorderSide(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder:  OutlineInputBorder(
                                                borderSide:  BorderSide(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder:OutlineInputBorder(
                                                borderSide:  BorderSide(color: Colors.black.withOpacity(0.4), width: 2.0),
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white70),

                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight*0.01,),

                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(

                                        margin:
                                        const EdgeInsets.only(left:20,top: 20, bottom: 60,right: 20),
                                        // padding: setPadding(5),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            // borderRadius: setRadius(5),
                                            gradient:  LinearGradient(colors: [Colors.red, Colors.red.withOpacity(0.7)])),
                                        child: TextButton(
                                          onPressed: () async {
                                            if(phoneController.text.length>10 || phoneController.text.length<10)
                                            {
                                              Fluttertoast.showToast(msg: 'Please enter valid phone number');
                                            }
                                            else{
                                              setState(() {
                                                showLoading = true;
                                              });
                                              await _auth.verifyPhoneNumber(
                                                  phoneNumber:
                                                  '+91' + phoneController.text,
                                                  verificationCompleted:
                                                      (phoneAuthCredential) {
                                                    setState(() {
                                                      showLoading = false;
                                                    });

                                                  },
                                                  verificationFailed:
                                                      (FirebaseAuthException e) {
                                                    setState(() {
                                                      showLoading = false;
                                                    });

                                                    // Fluttertoast.showToast(
                                                    //     msg: 'Multiple sign in requests made and your number is blocked for security purposes. Please try again in sometime.',
                                                    //     toastLength: Toast.LENGTH_LONG,
                                                    //     gravity: ToastGravity.BOTTOM,
                                                    //     timeInSecForIosWeb: 1,
                                                    //     backgroundColor: Colors.white,
                                                    //     textColor: Colors.black,
                                                    //     fontSize: 16.0);
                                                  },
                                                  codeSent:
                                                      (verificationId, resendingToken) {
                                                    setState(() {
                                                      showLoading = false;
                                                      // currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                                                      this.verificationId =
                                                          verificationId;
                                                    });

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Otp_screen(
                                                              phonenumber: phoneController.text,
                                                              verificationid: verificationId,
                                                            )));

                                                    print("Code Sent");
                                                  },
                                                  codeAutoRetrievalTimeout:
                                                      (verificationId) {
                                                    setState(() {
                                                      this.verificationId =
                                                          verificationId;
                                                    });
                                                    print("Tinme Out");
                                                  },
                                                  timeout: Duration(seconds: 30));
                                            }

                                          },
                                          child: const Text(
                                            'GET OTP',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),

                        ],
                      )

                    ],
                  ),
                ),
              ),



      )
          : Otp_screen(
        verificationid: verificationId,
        phonenumber: phoneController.text,
      ),
    );
  }
}
