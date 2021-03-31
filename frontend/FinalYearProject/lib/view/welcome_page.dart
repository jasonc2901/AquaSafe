import 'package:FinalYearProject/CustomDialog/InvalidLoginAlert.dart';
import 'package:FinalYearProject/CustomDialog/accountCreatedDialog.dart';
import 'package:FinalYearProject/CustomDialog/signInDialog.dart';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/sign_up_page.dart';
import 'package:FinalYearProject/view/welcome_back.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  bool signedIn = false;

  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _success;
  String _userEmail;

  resetPageFunction() {
    _emailController.text = "";
    _passwordController.text = "";
  }

  //this method will check if there is a user logged in currently
  //if there is you will be automatically logged in
  //if not you will be brought to the login screen
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WelcomeBack(user)),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            apptitle,
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: waterBlueColour,
        ),
        backgroundColor: waterBlueColour,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/water_logo.png", height: 200, width: 180),
                Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 65, top: 30),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 300,
                        child: TextFormField(
                          key: Key('emailTextField'),
                          controller: _emailController,
                          validator: (val) =>
                              val.length < 2 ? 'Still too short' : null,
                          decoration: new InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color(0xFFC4C4C4),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Calibri",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 300,
                        child: TextFormField(
                          key: Key('passwordTextField'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (val) =>
                              val.length < 2 ? 'Still too short' : null,
                          decoration: new InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color(0xFFC4C4C4),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Calibri",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: 150,
                        height: 40,
                        child: RaisedButton(
                          key: Key('loginBtnKey'),
                          color: waterBlueColour,
                          onPressed: () async {
                            _signInWithEmailAndPassword();
                          },
                          child: Text('Login'),
                        ),
                      ),
                      SizedBox(height: 30),
                      FlatButton(
                        child: Text(
                          "Need an account? Click here to sign up!",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final FirebaseUser user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
              .user;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
          widget.signedIn = true;

          showDialog(
            context: context,
            child: SignInDialog(
              title: "Welcome back!",
              description: "You are now logged in",
              alertImage: "assets/tick.png",
              buttonText: "Continue",
              buttonColor: Colors.green[400],
              user: user,
            ),
          );

          resetPageFunction();
        });
      } else {
        setState(() {
          _success = false;
        });
      }
    } on Exception catch (exception) {
      print("Exception: $exception");
      showDialog(
          context: context,
          child: InvalidLoginAlert(
            title: "Invalid login details!",
            description: "Please check your details are correct and try again",
            buttonText: "Try again",
            alertImage: "assets/x.png",
            buttonColor: Colors.red[400],
          ));
    }
  }
}
