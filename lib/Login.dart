

import 'package:apliee/Forgotpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Home.dart';
import 'SignUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LOGIN extends StatefulWidget {

  @override
  _LOGINState createState() => _LOGINState();
}
class _LOGINState extends State<LOGIN> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  //signIn Method
  _signInWithEmailAndPassword() async{
    try{
      final User user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text.trim(), password: _passwordController.text.trim())).user;
      if(user!=null){
        setState(() {
          Fluttertoast.showToast(msg: "Signed In Sucessfully");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeContent()),);
        });
      }
    }catch(e){
      Fluttertoast.showToast(msg:'Invalid User');
    }
  }

  //Login Screen Widget
  Widget logindesgn(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child:
                const Text("Welcome",
                  style: TextStyle(
                    fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              Container(
                child: Text("Login to continue",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.withOpacity(0.8)
                  ),
                ),
              ),
              SizedBox(height:screenHeight*0.03),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
                child: Container(
                  child: TextFormField(
                    controller: _emailController,
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
                      hintText: 'EMAIL',
                        prefixIcon: Icon(Icons.email,color: Colors.black,),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          //borderSide:  BorderSide(color: Colors.black),
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

              SizedBox(height: screenHeight*0.01),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
                child: Container(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
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
                        hintText: 'PASSWORD',
                        prefixIcon: Icon(Icons.lock,color: Colors.black,),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword?Icons.visibility:Icons.visibility_off,color: Colors.black,size: 20,),
                          onPressed: ()
                          {
                            _togglevisibility();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          //borderSide:  BorderSide(color: Colors.black),
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
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: ()
                    {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                         ForgotPassword()),);
                     },
                    child: Text("Forgot password ?",style: TextStyle(color: Colors.black),)),
              ),

              GestureDetector(
                onTap: (){
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _signInWithEmailAndPassword();
                    });
                  }
                },
                child: Container(
                  padding:  EdgeInsets.only(left: screenWidth*0.09, top: screenHeight*0.01, right: screenWidth*0.01, bottom: screenHeight*0.01),
                  decoration:  BoxDecoration(
                      gradient:  LinearGradient(colors: [Colors.red, Colors.red.withOpacity(0.7)]),
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(40), left: Radius.circular(40))
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("LOG IN", style: TextStyle(color: Colors.white, fontSize: 20),),
                        Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent.withOpacity(0.7)
                            ),
                            child: IconButton(
                                icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),iconSize: 25,
                                color: Colors.black54), width: screenWidth*0.12, height: screenHeight*0.05,),
                      ]
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.05),
              const Text("Don't have an account?", style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: screenHeight*0.01),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Navigate to Mobile verification Screen
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                        signUp()),);
                  });
                },
                child: Container(
                    child: const Text("SIGN UP NOW",
                      style: TextStyle(
                          color: Colors.red,fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    //Screen Width and Height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Balsamiq_Sans'),
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: logindesgn(context)),
                ),

            )
    );

  }



}