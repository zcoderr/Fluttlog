import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1000),
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            //"Zachary © 2019 - present | Powered by Flutter",
            "Designed by Zachary © 2020 - Powered by Flutter",
            style: TextStyle(color: Color(0xff999999), fontSize: 12,fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );
  }
}
