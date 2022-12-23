import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task1/home2.dart';
import 'package:task1/main.dart';
import 'package:task1/signup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({
    Key key,
    this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String email1 = "sincere@april.biz";
  String pass1 = "Bret";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.05,
              ),
///////////////////////////////////////////////////////////////////////
              Center(
                child: Container(
                  height: 230,
                  width: 230,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo2.png"))),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.05,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.08,
                width: _w * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 7),
                      )
                    ]),
                child: Center(
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter a valid email"
                            : null,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      hintText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.03,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.08,
                width: _w * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 7),
                      )
                    ]),
                child: Center(
                  child: TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value) => value != null && value.length < 3
                        ? "Enter corrent password"
                        : null,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      hintText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: Colors.red[700],
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.05,
              ),
///////////////////////////////////////////////////////////////////////
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 7),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Color(0xffb82b23), Color(0xffE43228)])),
                      height: _h * 0.08,
                      width: _w * 0.85,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: checkLogin,
                          child: Text(
                            "LOG IN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))),

///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.05,
              ),
///////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create Account  "),
                  GestureDetector(
                    onTap: singup,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffE43228),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.01,
              ),
///////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: _h * 0.1,
                    width: _w * 0.2,
                    child: IconButton(
                        icon: Image.asset(
                          "assets/google.png",
                          fit: BoxFit.cover,
                        ),
                        onPressed: () async {
                          const url =
                              'https://accounts.google.com/v3/signin/identifier?dsh=S-251231302%3A1663782779691460&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F%26ogbl%2F&emr=1&ltmpl=default&ltmplcache=2&osid=1&passive=true&rm=false&scc=1&service=mail&ss=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin&ifkv=AQDHYWov1HYEBHuWBN_m80xuHQYWeafjv3SjrJPJWHgKO0hkWIU7vbUzR1H1up9hCzvJK9h74UO5iw';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                  ),
                  Container(
                    height: _h * 0.1,
                    width: _w * 0.2,
                    child: IconButton(
                        icon: Image.asset("assets/facebook.png"),
                        onPressed: () async {
                          const url = 'https://www.facebook.com/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                  ),
                ],
              ),
///////////////////////////////////////////////////////////////////////
//             SizedBox(
//               height: _h * 0.03,
//             ),
// ///////////////////////////////////////////////////////////////////////
//             Column(
//               children: [
//                 Text(
//                   "Delevoped by © Zaryab Alam",
//                   style: TextStyle(
//                       color: Colors.black54, fontWeight: FontWeight.w300),
//                 ),
//                 Text(
//                   "Made for MS-Global Inc with LOVE",
//                   style: TextStyle(
//                       color: Colors.black54, fontWeight: FontWeight.w300),
//                 ),
//                 Text(
//                   'Terms of Service | Privacy Policy',
//                   style: TextStyle(
//                       color: Colors.black54, fontWeight: FontWeight.w300),
//                 ),
//               ],
//             ),
            ],
          ),
        ),
      ),
    );
  }

  Future checkLogin() async {
    final isValid = formKey.currentState.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    if (emailController.text == email1 && passwordController.text == pass1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home2()));
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      navigatorKey.currentState.popUntil((route) => route.isFirst);
    }
  }

  Future singup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
  }
}
