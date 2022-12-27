import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1/models/post.dart';
import 'package:task1/screens/more.dart';
import 'package:task1/services/remote.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  List<Post> posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Future<String> getName() async {
    // Function name
    final CollectionReference users =
        firestore.collection('users'); // collection name
    final String uid = auth.currentUser.uid;
    final result = await users.doc(uid).get();
    return result.data()['Name']; // Field Name
  }

  Future<String> getUsername() async {
    // Function name
    final CollectionReference users =
        firestore.collection('users'); // collection name
    final String uid = auth.currentUser.uid;
    final result = await users.doc(uid).get();
    return result.data()['Username']; // Field Name
  }

  Future<String> getAddress() async {
    // Function name
    final CollectionReference users =
        firestore.collection('users'); // collection name
    final String uid = auth.currentUser.uid;
    final result = await users.doc(uid).get();
    return result.data()['Address']; // Field Name
  }

  Future<String> getZipcode() async {
    // Function name
    final CollectionReference users =
        firestore.collection('users'); // collection name
    final String uid = auth.currentUser.uid;
    final result = await users.doc(uid).get();
    return result.data()['Zipcode']; // Field Name
  }

  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lorem Ipsum"),
          leading: IconButton(icon: Icon(Icons.menu_rounded), onPressed: () {}),
          actions: [
            IconButton(
                icon: Icon(Icons.search_rounded),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => More()));
                }),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Color(0xffE43228)),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25), // Creates border
                color: Colors.red[700]),
            tabs: [
              Tab(
                child: Text("All Posts"),
              ),
              Tab(
                child: Text("Profile"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Visibility(
              visible: isLoaded,
              child: ListView.builder(
                  itemCount: posts?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              posts[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Text(
                              posts[index].body,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              // style: TextStyle(
                              //     fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    );
                  }),
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Column(
              children: [
                Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  shadowColor: Colors.black87,
                  color: Colors.white,
                  child: Container(
                    height: _h * 0.55,
                    width: _w * 0.78,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 85,
                          color: Colors.black54,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        FutureBuilder(
                          future: getName(), // Calling Function name
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ); // this holds the data
                          },
                        ),
                        SizedBox(
                          height: _h * 0.01,
                        ),
                        Text(
                          "Username",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        FutureBuilder(
                          future: getUsername(), // Calling Function name
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ); // this holds the data
                          },
                        ),
                        SizedBox(
                          height: _h * 0.01,
                        ),
                        Text(
                          "Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            user.email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.01,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        FutureBuilder(
                          future: getAddress(), // Calling Function name
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ); // this holds the data
                          },
                        ),
                        SizedBox(
                          height: _h * 0.01,
                        ),
                        Text(
                          "Zipcode",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        FutureBuilder(
                          future: getZipcode(), // Calling Function name
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ); // this holds the data
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _h * 0.03,
                ),
                Container(
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
                    width: _w * 0.78,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
