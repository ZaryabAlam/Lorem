import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1/screens/login.dart';
import 'package:task1/main.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;
      final String name = nameController.text;
      final String address = addressController.text;
      final String zipcode = zipcodeController.text;

      final isValid = formKey.currentState.validate();
      if (!isValid) return;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()));
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        await db.collection("users").doc(user.user.uid).set({
          "Email": email,
          "Name": name,
          "Username": username,
          "Address": address,
          "Zipcode": zipcode
        });
      } catch (e) {
        print("**** ERROR ****");
        print(e);
      }
      navigatorKey.currentState.popUntil((route) => route.isFirst);
    }

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
                height: _h * 0.02,
              ),
///////////////////////////////////////////////////////////////////////
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo1.png"),
                          fit: BoxFit.cover)),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.0,
              ),
///////////////////////////////////////////////////////////////////////

              Container(
                padding: EdgeInsets.only(left: 33),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create your account",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xffE43228),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.03,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.07,
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
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 8, bottom: 2),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.01,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.07,
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
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscured,
                  focusNode: textFieldFocusNode,
                  cursorColor: Colors.black,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) => value != null && value.length < 6
                      ? "Enter atleast 6 letters"
                      : null,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    hintText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8, bottom: 2),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.01,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.07,
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
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: 'Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.01,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.07,
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
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: 'Username',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.01,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.07,
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
                    controller: addressController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: 'Address',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.01,
              ),
///////////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.07,
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
                    controller: zipcodeController,
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: 'Zipcode',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.04,
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
                          onPressed: register,
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))),
///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: _h * 0.03,
              ),
///////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account  "),
                  GestureDetector(
                    onTap: singin,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffE43228),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future singin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
