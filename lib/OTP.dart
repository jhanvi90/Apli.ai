import 'dart:async';
import 'dart:convert';

import 'package:apliee/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



class Otp_screen extends StatefulWidget {
  String verificationid;
  final String phonenumber;

  Otp_screen({  this.verificationid,  this.phonenumber});

  @override
  _otpState createState() => _otpState();
}

class _otpState extends State<Otp_screen> {
   String optctn;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;

//Send mobile number to server

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //startTimer(30);
  }

  var email_ = "";
  var username_;
  var distno_;
  var distname_;
  var phoneNo_;
  var user_type_;
  var dis_no;
  int _start = 30;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//Phone Credential
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential?.user != null) {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => signUp(

                )));

      }
    } on FirebaseAuthException catch (e) {
      // setState(() {
      //   showLoading = false;
      // });
      // ignore: deprecated_member_use
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }
  }



  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: new
          Container(
            height: MediaQuery.of(context).size.height,
            child:Padding(
                padding:  EdgeInsets.only(top:200,left: screenWidth * 0.05, right: screenWidth * 0.05),
                child:
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child:
                        const Text("OTP",
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
                          height:screenHeight*0.39,
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
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight*0.05,),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14, left: 14,top: 14),
                                    child: PinCodeTextField(
                                      autoDismissKeyboard: true,
                                      keyboardType: TextInputType.number,
                                      appContext: context,
                                      length: 6,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 50,
                                        fieldWidth: 40,
                                        selectedColor: Color(0xffD0D0D0),
                                        inactiveColor: Color(0xffD0D0D0),
                                        activeColor: Color(0xffD0D0D0),
                                        selectedFillColor: Color(0xffD0D0D0),
                                      ),
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          optctn = value;
                                        });
                                      },
                                    ),
                                  ),



                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 49,
                                      margin: const EdgeInsets.only(top: 40, bottom: 60),
                                      padding: const EdgeInsets.all(8.0),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          // borderRadius: setRadius(5),
                                          gradient: LinearGradient(colors: [Colors.red, Colors.red.withOpacity(0.7)])),
                                      child: TextButton(
                                        onPressed: () {
                                          PhoneAuthCredential phoneAuthCredential =
                                          PhoneAuthProvider.credential(
                                              verificationId: widget.verificationid,
                                              smsCode: optctn);
                                          signInWithPhoneAuthCredential(phoneAuthCredential);
                                          // _timer.cancel();
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
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

    );
  }
}