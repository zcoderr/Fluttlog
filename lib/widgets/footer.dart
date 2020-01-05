import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1000),
        padding: EdgeInsets.only(top: 10, bottom: 30, left: 25, right: 25),
        child: Column(
          children: <Widget>[
            Container(
              width: 1000,
              height: 0.5,
              decoration: BoxDecoration(color: Color(0xff2c3e50)),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Zachary © 2019 - present | Powered by Flutter",
                style: TextStyle(color: Color(0xff2c3e50), fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
