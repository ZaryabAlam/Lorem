import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
    }

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
                child: TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    hintText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
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
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    hintText: 'Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
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
                  controller: usernameController,
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
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    hintText: 'Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
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
                  controller: zipcodeController,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    hintText: 'Zipcode',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
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
                        onPressed: register,
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))),
          ],
        ),
      ),
    );
  }
}
