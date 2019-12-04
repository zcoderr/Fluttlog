import 'dart:convert';
import 'dart:io';
import 'package:front_matter/front_matter.dart' as frontmatter;

void main() {
  listFile();
  //listTest();
  //parseArray();
  // aa();
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

  var dir =
      await new Directory("/Users/zachary/code/flutter_web/blog/web/content")
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
  final filePath = "/Users/zachary/code/flutter_web/blog/test/data.json";
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
          // 读取到一行 frontmatter
          if (line.split(":")[0].trim() != "tags") {
            map[line.split(":")[0].trim()] = line.split(":")[1].trim();
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
              String temp = r.group(0).replaceAll(new RegExp('''['|"]'''), '');
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
            print(jsonTags[0]);
            var tags = [];
            for (var item in jsonTags) {
              print(item);
              tags.add(item);
            }

            map['tags'] = tags;
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
