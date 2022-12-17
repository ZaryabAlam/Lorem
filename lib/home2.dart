import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1/login.dart';
import 'package:task1/models/post.dart';
import 'package:task1/services/remote.dart';

class Home2 extends StatefulWidget {
  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  Future<String> getUsersName() async {
    // Function name
    final CollectionReference users =
        firestore.collection('users'); // collection name
    final String uid = auth.currentUser.uid;
    final result = await users.doc(uid).get();
    return result.data()['Username']; // Field Name
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lorem Ipsum"),
          leading: IconButton(icon: Icon(Icons.menu_rounded), onPressed: () {}),
          actions: [
            IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
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
                                fontSize: 20,
                              ),
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
                            Text(
                              "Leanne Graham",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ), // this holds the data

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
                            Text(
                              "Bret",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
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
                                "sincere@april.com",
                                textAlign: TextAlign.center,
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
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Kulas Light, Apt. 556, Gwenborough",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
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
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "92998-3874",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _h * 0.03,
                    ),
                    // ElevatedButton(
                    //     onPressed: () => FirebaseAuth.instance.signOut(),
                    //     child: Text("Sign Out")),

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
                            gradient: LinearGradient(colors: [
                              Color(0xffb82b23),
                              Color(0xffE43228)
                            ])),
                        height: _h * 0.08,
                        width: _w * 0.78,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Text(
                              "Sign Out",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
