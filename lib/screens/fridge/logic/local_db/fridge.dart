import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/fridge/logic/bloc/bloc.dart';
import 'package:shop_app/screens/fridge/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseFridge {
  static const String tableName = 'fridges';

  static Future<Database> openDatabaseFridge() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fridge_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT,
            quantity INTEGER,
            note TEXT,
            type TEXT,
            imageUrl TEXT,
            expiredDate TEXT,
            startDate TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertFridge(Fridge fridge) async {
    final Database db = await openDatabaseFridge();
    await db.insert(
      tableName,
      {
        'id': fridge.id,
        'name': fridge.name,
        'note': fridge.note,
        'quantity': fridge.quantity,
        'type': fridge.type,
        'startDate': DateFormat('yyyy-MM-dd hh:mm:ss').format(fridge.startDate),
        'expiredDate':
            DateFormat('yyyy-MM-dd hh:mm:ss').format(fridge.expiredDate),
        'imageUrl': fridge.imageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllFridges() async {
    final Database db = await openDatabaseFridge();
    await db.delete(tableName);
  }

  static Future<List<Fridge>> getFridges() async {
    print(1);
    final Database db = await openDatabaseFridge();
    print(1);
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    print(maps);
    return List.generate(maps.length, (i) {
      return Fridge(
        id: maps[i]['id'],
        name: maps[i]['name'],
        note: maps[i]['note'],
        quantity: maps[i]['quantity'],
        type: maps[i]['type'],
        startDate: DateTime.parse(maps[i]['startDate']),
        expiredDate: DateTime.parse(maps[i]['expiredDate']),
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
