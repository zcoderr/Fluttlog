import 'dart:convert';
import 'dart:io';

void main() {
  //listFile();
  //listTest();
  //parseArray();
  // aa();
  //testt();
  //splitFrontMatter();
  print("ᴸⁱᶠᵉ ⁱˢ ᵈᵒʷⁿᵈᵒʷⁿᵘᵖᵘᵖᵘᵖᵘᵖᵘᵖᵘᵖᵘᵖ ˙˘˙");
}

void testt() {
  String a = ":.*";
  final regExp = new RegExp(a);
  final input =
      'thumb: http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/91/6/thumb.jpg';
  final result = regExp.allMatches(input);
  result.first.group(0).replaceFirst(":", "").trim();
}

void testFrontmatter() {}

void listTest() {
  List l = ["a", "b"];
  String sl = "[a,b]";

  print(sl);
}

void aa() {
  String a = '["Markdown","Blog"]';
  var ab = json.decode(a);
  print(a);
  print(ab[0]); // return
}

void parseArray() {
  // ['a','b']
  // ["a","b"]
  // [a,b]

  var buffer = StringBuffer();
  buffer.write('\'[');

  String a = "[\'|\"].*?[\'|\"]";
  final regExp = new RegExp(a);
  final input = '''["Markdown","Blog"]''';
  final result = regExp.allMatches(input);

  for (var i = 0; i < result.length; i++) {}

  for (var r in result) {
    String temp = r.group(0).replaceAll(new RegExp('''['|"]'''), '');
    buffer.write("\"");
    buffer.write(temp);
    buffer.write("\"");
    if (r.group(0) != result.last.group(0)) {
      buffer.write(",");
    }
  }
  buffer.write(']\'');
  print(buffer);
}

void ttt() {
  // [Markdown,Blog]
  final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
  final input = '[[sometext],[122],[411]]';
  final result = regExp
      .allMatches(input)
      .map((m) => m.group(1))
      .map((String item) => item.replaceAll(new RegExp(r'[\[\],]'), ''))
      .map((m) => [m])
      .toList();
  print(result);
}

void tt() {
  var lists = jsonDecode('["sdfgdf","22vfsf"]');
  print(lists[1]);
}

void readFile() {}

void listFile() async {
  List<Map> datt = [];
  Map dataMap = Map();

  var dir = await new Directory(
          "/Users/zachary/code/flutter_web/blog/web/content/post")
      .create(recursive: true);

  Stream<FileSystemEntity> entityList =
      dir.list(recursive: true, followLinks: false);

  await for (FileSystemEntity entity in entityList) {
    if (entity is File) {
      await readFrontMatter(entity.path).then((map) {
        datt.add(map);
        //print(map.toString());
      });
    }
  }
  dataMap['data'] = datt;
  writeAsJson(dataMap);
}

void writeAsJson(Map map) {
  final filePath = "/Users/zachary/code/flutter_web/blog/web/data/post_data.json";
  try {
    File file = new File(filePath);
    file.writeAsString(jsonEncode(map));
  } catch (e) {
    print(e);
  }
}

Future<Map> readFrontMatter(String path) async {
  Map map = Map();
  bool isFrontMatter = false;
  final lines =
      utf8.decoder.bind(File(path).openRead()).transform(const LineSplitter());
  try {
    await for (var line in lines) {
      if (isFrontMatter) {
        if (line == "---") {
          isFrontMatter = false;
        } else {
          if (line.split(":").length > 1) {
            // 读取到一行 frontmatter
            if (line.split(":")[0].trim() != "tags") {
              String a = ":.*";
              final regExp = new RegExp(a);
              final result = regExp.allMatches(line);
              map[line.split(":")[0].trim()] =
                  result.first.group(0).replaceFirst(":", "").trim();
            } else {
              // 是 tag 数组
              //map['tags'] = line.split(":")[1].trim();
              var buffer = StringBuffer();
              buffer.write('[');

              String a = "[\'|\"].*?[\'|\"]";
              final regExp = new RegExp(a);
              final input = line.split(":")[1].trim();
              final result = regExp.allMatches(input);
              for (var r in result) {
                String temp =
                    r.group(0).replaceAll(new RegExp('''['|"]'''), '');
                buffer.write("\"");
                buffer.write(temp);
                buffer.write("\"");
                if (r.group(0) != result.last.group(0)) {
                  buffer.write(",");
                }
              }
              buffer.write(']');
              //print(buffer.toString());
              var jsonTags = json.decode(buffer.toString());

              var tags = [];
              for (var item in jsonTags) {
                tags.add(item);
              }

              map['tags'] = tags;
            }
          }
        }
      } else {
        if (line == "---") {
          isFrontMatter = true;
        }
      }
    }
    map['path'] = path.split('content')[1];
  } catch (_) {
    await _handleError(path);
  }
  //print(map);
  return map;
}

Map readKVAsMap(String kv) {
  return {kv.split(":")[0].trim(): kv.split(":")[1].trim()};
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}

void splitFrontMatter() {
  String content = """ 
  ---
title: Markdown 测试
desc: 测试 Markdown 样式
thumb: http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/91/6/thumb.jpg
location: Be[Markdown,Blog]ijing
time: 2019-10-22
catalog: 技术日志
tags:
---


###  1. 斜体和粗体

使用 * 和 ** 表示斜体和粗体。

示例：

这是 *斜体*，这是 **粗体**。

### 2. 分级标题


示例：

# 这是一个一级标题

## 这是一个二级标题

### 这是一个三级标题



### 3. 外链接

使用 [描述](链接地址) 为文字增加外链接。

示例：

这是去往 [本人博客](https://yscoder.github.io/vuepress-theme-indigo/) 的链接。

### 4. 无序列表

使用 *，+，- 表示无序列表。

示例：

- 无序列表项 一
- 无序列表项 二
- 无序列表项 三

### 5. 有序列表

使用数字和点表示有序列表。

示例：

1. 有序列表项 一
2. 有序列表项 二
3. 有序列表项 三

### 6. 文字引用

使用 > 表示文字引用。

示例：

> 野火烧不尽，春风吹又生。

### 7. 行内代码块

使用 `代码` 表示行内代码块。

示例：

让我们聊聊 `html`。

### 8. 代码块

使用 四个缩进空格 表示代码块。

示例：

```
这是一个代码块，此行左侧有四个不可见的空格。
export default {
  data () {
    return {
      msg: 'Highlighted!'    }
  }
}
```

### 9. 插入图像

使用 ` ![描述](图片链接地址)` 插入图像。

示例：

![](https://storage-1251325576.cos.ap-beijing.myqcloud.com/blog/9746525.png)

### 10. 删除线

使用 ~~ 表示删除线。

这是一段错误的文本。

### 11. 表格
---
| 项目   |  价格 | 数量 |
| ------ | ----: | :--: |
| 计算机 | 1600 |  5   |
| 手机   |   12 |  12  |
| 管线   |    1 | 234  |
  """;
  var lines = content.split('\n');
  StringBuffer buffer = StringBuffer();
  int splitNum = 0;
  for (int i = 0; i < lines.length; i++) {
    buffer.write(lines[i] + '\n');
    if (lines[i] == "---") {
      splitNum++;
    }
    if (splitNum == 1) {
      break;
    }
  }
  print(content.replaceFirst(buffer.toString(), ""));
}
