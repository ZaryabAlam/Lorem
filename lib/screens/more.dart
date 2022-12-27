import 'package:flutter/material.dart';

class More extends StatefulWidget {
  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _h * 0.3,
              width: _w * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo3.png"),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height: _h * 0.01,
            ),
            Text(
              "More coming soon!",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
