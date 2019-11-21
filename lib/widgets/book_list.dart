// 没有封面图的 post 模块
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../data_util.dart' as data_util;

class BookListView extends StatefulWidget {
  const BookListView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BookListViewState();
  }
}

class BookListViewState extends State<BookListView> {
  List _bookList = [];
  @override
  void initState() {
    super.initState();
    data_util.fetchBookList().then((Map resultMap) {
      setState(() {
        _bookList = resultMap['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildBookCard(_bookList[index]);
      },
      itemCount: _bookList.length,
    );
  }

  Widget _buildBookCard(Map book) {
    print(book);
    return InkWell(
      onTap: (){
        html.window.open(book['link'], "");
      },
      child: Card(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 200,
            child: Image.network(book['thumb']),
          ),
          Text(book['title'])
        ],
      ),
    ),
    );
  }
}
