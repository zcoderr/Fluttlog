import 'dart:convert';
import 'dart:io';

void main() {
  listFile();
}

void listFile() async {
  List<Map> mapList = [];
  Map dataMap = Map();

  var postDir = await new Directory("web/content/post").create(recursive: true);

  Stream<FileSystemEntity> entityList =
      postDir.list(recursive: true, followLinks: false);

  await for (FileSystemEntity entity in entityList) {
    if (entity is File) {
      await readFrontMatter(entity.path).then((map) {
        mapList.add(map);
      });
    }
  }

  var n = mapList.length;
  // 这里排序
  for (int i = 0; i < n; ++i) {
    bool flag = false;

    for (int j = 0; j < n - i - 1; ++j) {
      var time1 = mapList[j]['time'];
      var time2 = mapList[j + 1]['time'];

      if (aSmallerThanB(time1, time2)) {
        Map temp = mapList[j];
        mapList[j] = mapList[j + 1];
        mapList[j + 1] = temp;
        flag = true;
      }
    }
    if (!flag) break;
  }

  dataMap['data'] = mapList;
  writeAsJson(dataMap);
}

bool aSmallerThanB(String s1, String s2) {
  var aArray = s1.split('');
  var bArray = s2.split('');

  if (s1.split('-')[1].length == 1) {
    aArray[4] = '0';
  }

  if (s1.split('-')[2].length == 1) {
    aArray[s1.length - 2] = '0';
  }

  if (s2.split('-')[1].length == 1) {
    bArray[4] = '0';
  }

  if (s2.split('-')[2].length == 1) {
    bArray[s2.length - 2] = '0';
  }

  var date1 = int.parse(aArray.join().replaceAll('-', ''));
  var date2 = int.parse(bArray.join().replaceAll('-', ''));

  print(date1.toString() + '-----' + date2.toString());
  return date1 < date2;
}

void writeAsJson(Map map) {
  final filePath = "/Users/zachary/code/flutter_web/blog/web/data/data.json";
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
    map['path'] = path.replaceFirst("web", '');
  } catch (_) {
    await _handleError(path);
  }
  //print(map);
  return map;
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
