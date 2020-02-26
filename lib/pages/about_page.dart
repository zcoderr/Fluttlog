import 'package:blog/widgets/centered_view/centered_view.dart';
import 'package:blog/widgets/footer.dart';
import 'package:blog/widgets/header_hero_image/header_hero_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/colors.dart';
import 'dart:html' as html;

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: ListView(
        children: <Widget>[HeaderHeroImage("About", "Desc"), _maxAboutBody()],
      ),
    );
  }

  Widget _maxAboutBody() {
    return CenteredView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 7),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "About ",
                    style: TextStyle(
                        fontSize: 40,
                        color: ThemeColors.firstColor,
                        fontWeight: FontWeight.w100),
                  ),
                  TextSpan(
                    text: "Me",
                    style: TextStyle(
                        fontSize: 40,
                        color: ThemeColors.secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _thirdPartIcon(
                    "images/icon_gmail.png", "mailto:zcoderrr@gmail.com"),
                _thirdPartIcon(
                    "images/icon_github.png", "https://github.com/zcoderr"),
                _thirdPartIcon(
                    "images/icon_weibo.png", "https://weibo.com/zacwa"),
                _thirdPartIcon("images/icon_zhihu.png",
                    "https://www.zhihu.com/people/zachary-wang-53"),
                _thirdPartIcon("images/icon_instagram.png",
                    "https://www.instagram.com/zcoderrr/"),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                  '''一个目前主业 Android，做着独立产品梦的开发者。\n自认为略懂产品，略懂设计，并且对个人效率和协作效率有强迫症式的执念。\n能写 Android 能写 iOS，能写前端和后台，能写 Python、Shell、 Golang 的伪全栈。'''),
            ),
//            Padding(
//              padding: EdgeInsets.only(top: 20, bottom: 10),
//              child: Text(
//                'Experience',
//                style: TextStyle(fontSize: FontSize.fontSizeSubTitleMax),
//              ),
//            ),
//            ProjectInfoSection(
//                "十点文化传播有限公司",
//                "高级 Android 开发工程师",
//                "2018.10 - present",
//                "知识付费 APP「十点读书」",
//                "开发核心业务和模块封装、解决大量工作流中的痛点、负责 Flutter 的推广和接入。"),
//            ProjectInfoSection("问问科技有限公司", "Android 开发工程师", "2018.1 - 2018.10",
//                "直播 App「小直播」", "独立负责 Android 端技术选型、框架搭建、及所有的业务开发和后续迭代。"),
//            ProjectInfoSection("糖块信息技术有限公司", "Android 开发工程师",
//                "2016.10 - 2018.1", "LBS 社交 App「Any」", "主要业务开发和迭代。"),
//            Padding(
//              padding: EdgeInsets.only(bottom: 10),
//              child: Text(
//                'What Skii I Have',
//                style: TextStyle(fontSize: FontSize.fontSizeSubTitleMax),
//              ),
//            ),
//            Wrap(
//              children: _buildTagList([
//                'Java',
//                'Dart',
//                'Python',
//                'GoLang',
//                'Android',
//                'Flutter',
//                'Spring',
//                'iOS',
//                'Shell',
//                'Linux',
//                'Git'
//              ]),
//            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "About This Site",
                style: TextStyle(fontSize: FontSize.fontSizeSubTitleMax),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      style: TextStyle(color: ThemeColors.firstColor),
                      text: "本站是使用 Flutter for web 编写的静态网站，已经踩平响应式、路由管理等坑，详见"),
                  TextSpan(
                    text: " 仓库地址。 ",
                    recognizer: TapGestureRecognizer()..onTap = () {
                      html.window.open("https://github.com/zcoderr/Fluttlog", "");
                    },
                    style: TextStyle(color: ThemeColors.secondaryColor),
                  ),
                ]),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTagList(List tags) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < tags.length; index++) {
      result.add(_buildTagItem(tags[index]));
    }
    return result;
  }

  Widget _buildTagItem(String tag) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, bottom: 10),
      child: Container(
        padding: EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
        decoration: BoxDecoration(
            color: Color(0xffdcdcdc),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          tag,
          style: TextStyle(fontSize: 12, color: ThemeColors.firstColor),
        ),
      ),
    );
  }

  Widget _thirdPartIcon(String icon, String url) {
    return InkWell(
      onTap: () {
        html.window.open(url, "");
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: 7.0, right: 7.0, top: 10.0, bottom: 10.0),
        child: Image.asset(
          icon,
          width: 23,
          height: 23,
        ),
      ),
    );
  }
}

class ProjectInfoSection extends StatelessWidget {
  String _companyName;
  String _jobTitle;
  String _duration;
  String _projectDesc;
  String _responsibility;

  ProjectInfoSection(this._companyName, this._jobTitle, this._duration,
      this._projectDesc, this._responsibility);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: _companyName,
                style: TextStyle(
                    color: ThemeColors.firstColor,
                    fontSize: FontSize.fontSizeBodyMax),
              ),
              TextSpan(
                text: "     " + _projectDesc,
                style: TextStyle(
                    fontSize: FontSize.fontSizeBodyMax,
                    color: ThemeColors.secondaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              _jobTitle,
              style: TextStyle(
                  color: ThemeColors.firstColor,
                  fontSize: FontSize.fontSizeBodyMax),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              _duration,
              style: TextStyle(
                  color: ThemeColors.textColor555555,
                  fontSize: FontSize.fontSizeFootnoteMax),
            ),
          ),
//          Padding(
//            padding: EdgeInsets.only(top: 5),
//            child: Text(
//              _responsibility,
//              style: TextStyle(
//                  color: ThemeColors.textColor555555,
//                  fontSize: FontSize.fontSizeFootnoteMax),
//            ),
//          )
//        Text(_projectDesc),
//        Text(_responsibility),
        ],
      ),
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
        break;
    }
    return null;
  }
}
