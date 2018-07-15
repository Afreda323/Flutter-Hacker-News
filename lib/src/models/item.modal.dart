import 'dart:convert' show jsonDecode, jsonEncode;

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'] ?? "",
        time = parsedJson['time'],
        text = parsedJson['text'] ?? "",
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> dbItem)
      : id = dbItem['id'],
        deleted = dbItem['deleted'] == 1,
        type = dbItem['type'],
        by = dbItem['by'],
        time = dbItem['time'],
        text = dbItem['text'],
        dead = dbItem['dead'] == 1,
        parent = dbItem['parent'],
        kids = jsonDecode(dbItem['kids']),
        url = dbItem['url'],
        score = dbItem['score'],
        title = dbItem['title'],
        descendants = dbItem['descendants'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "kids": jsonEncode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants
    };
  }
}
