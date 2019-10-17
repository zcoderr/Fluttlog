import 'package:flutter/material.dart';

class MinPostCard extends StatelessWidget {
  final Map post;

  MinPostCard({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04,
          top: 20,
          bottom: 20),
      child: Card(
        // 卡片
        clipBehavior: Clip.hardEdge,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          // 圆角
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                // child: Hero(
                //   tag: post['title'],
                  child: Image.network(post['thumb'], fit: BoxFit.cover),
                // ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      post['title'],
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        post['location'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
