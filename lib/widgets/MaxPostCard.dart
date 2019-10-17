import 'package:flutter/material.dart';

class MaxPostCard extends StatelessWidget {
  final Map post;

  MaxPostCard({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: 20,
          bottom: 20),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Card(
            // 卡片
            clipBehavior: Clip.hardEdge,
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
              // 圆角
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Container(
                    width: 360,
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          post['title'],
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            post['location'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // child: Hero(
                    //   tag:post['path'],
                      child: Image.network(post['thumb'],
                          height: 300, fit: BoxFit.cover),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
