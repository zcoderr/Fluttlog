import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Image.network('https://picsum.photos/1920/1080/'),
    );
  }
}
