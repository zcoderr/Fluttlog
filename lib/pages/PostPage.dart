import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration:  BoxDecoration(
        gradient:  LinearGradient(
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          colors: <Color>[
            Colors.red.shade600.withOpacity(0.7),
            Colors.blue.shade600.withOpacity(0.1),
            //const Color(0xff000000),
            //const Color(0xff000000)
          ],
        ),
      ),
      child: Text(
        'Post页面',
        style: TextStyle(fontSize: 40, color: Colors.black),
      ),
    );
  }
}
