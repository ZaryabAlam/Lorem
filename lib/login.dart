import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1/home2.dart';
import 'package:task1/main.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

//test

class _LoginState extends State<Login> {
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
        child: Column(
          children: [
///////////////////////////////////////////////////////////////////////
            SizedBox(
              height: _h * 0.08,
            ),
///////////////////////////////////////////////////////////////////////
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/logo2.png"))),
              ),
            ),
///////////////////////////////////////////////////////////////////////
            SizedBox(
              height: _h * 0.08,
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
                child: TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    hintText: 'Username',
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
                child: TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscured,
                  focusNode: textFieldFocusNode,
                  cursorColor: Colors.black,
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
              height: _h * 0.03,
            ),
///////////////////////////////////////////////////////////////////////
            Column(
              children: [
                Text(
                  "Delevoped by © Zaryab Alam",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Made for MS-Global Inc with LOVE",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w300),
                ),
                Text(
                  'Terms of Service | Privacy Policy',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future checkLogin() async {
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
}
