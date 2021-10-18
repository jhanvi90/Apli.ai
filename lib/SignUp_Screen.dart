
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Login_Screen.dart';

class signUp extends StatefulWidget{
  @override
  _signUpState createState()=> _signUpState();
}
class _signUpState extends State<signUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  //SignUp Screen design widget
  Widget SignUpWidget(BuildContext context)
  {
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
              child:Text("Sign Up", style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 3),
            Container(child:  Text("Create your account",style: TextStyle(fontSize: 14, color: Colors.red.withOpacity(0.8))),),
            SizedBox(height:screenHeight*0.03),
            Padding(
              padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01,right:screenWidth*0.02 ),
              child: Container(
                child: TextFormField(
                  controller: _emailController,
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
                      hintText: 'EMAIL', prefixIcon: Icon(Icons.email,color: Colors.black,),
                      filled: true, fillColor: Colors.white70),
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
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return 'Please enter password';
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
                      ), filled: true,fillColor: Colors.white70),
                ),
              ),
            ),
            SizedBox(height:screenHeight*0.05),
            GestureDetector(
              onTap: (){
                if (_formKey.currentState.validate()) {
                  setState(()
                  {
                    //Method to register user
                    _registerUser();
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
                        IconButton(icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),iconSize: 25,color: Colors.black54)
                    ]
                ),
              ),
            ),
            SizedBox(height: screenHeight*0.03),
            Text("Already have an account?",style: TextStyle(fontSize: 13)),
            SizedBox(height: screenHeight*0.01),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LOGIN()),);
              },
              child: Container(child:Text("SIGN IN NOW", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
            ),
          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Balsamiq_Sans'),
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                    // SignUp design widget
                  child: SignUpWidget(context)
                )
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



  void _registerUser()async{
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

      try {
        final User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password)).user;
        setState(() {
          if (user != null) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
          }
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }

  }
