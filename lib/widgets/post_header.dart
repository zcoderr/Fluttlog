import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String title;
  final String desc;
  final Widget cover;


  PostHeader({Key key, this.title, this.desc, this.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          cover,
          Container(
            decoration:BoxDecoration(
                gradient:  LinearGradient(
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  colors: <Color>[
                    Colors.grey.shade600.withOpacity(0.2),
                    Colors.grey.shade600.withOpacity(0.5),
                    //const Color(0xff000000),
                    //const Color(0xff000000)
                  ],
                ),
              ),
            child: Center(
              child: Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold)),
                  Text(desc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
