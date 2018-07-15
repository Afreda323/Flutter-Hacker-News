import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'repository.dart';
import '../models/item.modal.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          ) 
        """);
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final dbMap = await db.query(
      "Items",
      columns: null,
      where: "id == ?",
      whereArgs: [id],
    );

    if (dbMap.length > 0) {
      return ItemModel.fromDb(dbMap.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel model) => db.insert(
        "Items",
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

  Future<int> clear() {
    return db.delete('Items');
  }

  // TODO
  Future<List<int>> fetchTopIds() => null;
}

final newsDbProvider = NewsDbProvider();
