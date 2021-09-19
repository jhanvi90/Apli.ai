
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Login.dart';

class signUp extends StatefulWidget{
  @override
  _signUpState createState()=> _signUpState();
}
class _signUpState extends State<signUp> {
  final color3 = const Color(0xFF38BF68);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }


  Widget siupdesign(BuildContext context) {
    //Screen Width and Height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top:55.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child:
              const Text("Sign Up",
                style: TextStyle(
                    fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 3),
            Container(
              child:  Text("Create your account",
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
            SizedBox(height: 7),
            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _confpasswordController,
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
            SizedBox(height:screenHeight*0.05),
            GestureDetector(
              onTap: (){
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _register();
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
                      const Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 20),),
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
            SizedBox(height: screenHeight*0.03),
            const Text("Already have an account?",
              style: TextStyle(
                  fontSize: 13,
              ),
            ),
            SizedBox(height: screenHeight*0.01),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LOGIN()),);
              },
              child: Container(
                  child: const Text("SIGN IN NOW",
                    style: TextStyle(
                        color: Colors.red,fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ),
            SizedBox(height: 80, width: 20),
          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    const color3 = const Color(0xFF38BF68);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Balsamiq_Sans'),
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child:Container(
                //  margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView(
                    children: [
                      //Title,
                      Stack(
                          alignment: Alignment.center,
                          children: [
                           // back,
                            siupdesign(context),
                          ]
                      )
                    ]
                ),
              ),
            )
        )
    );

  }

  @override
  void dispose()  {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register()async{
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmpassword = _confpasswordController.text.trim();
    if(password == confirmpassword) {
      try {
        final User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password)).user;
        setState(() {
          if (user != null) {
            Fluttertoast.showToast(msg: "user created");
            Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeContent()),);
          }
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    else{
      Fluttertoast.showToast(msg: "Passwords don't match");
    }
  }

}