import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/meal_plan/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMealPlan {
  static const String tableName = 'mealPlans';

  static Future<Database> openDatabaseMealPlan() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mealPlan_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT,
            timestamp TEXT,
            status TEXT,
            foodName TEXT,
            foodImage TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertMealPlan(MealPlan mealPlan) async {
    final Database db = await openDatabaseMealPlan();
    await db.insert(
      tableName,
      {
        'id': mealPlan.id,
        'name': mealPlan.name,
        'timestamp': mealPlan.timestamp,
        'status': mealPlan.status,
        'foodName': mealPlan.foodName,
        'foodImage': mealPlan.foodImage,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllMealPlans() async {
    final Database db = await openDatabaseMealPlan();
    await db.delete(tableName);
  }

  static Future<List<MealPlan>> getMealPlans() async {
    print(0);
    final Database db = await openDatabaseMealPlan();
    print(db);
    final List<Map<String, dynamic>> maps = await db.query("mealPlans");
    print(maps);
    return List.generate(maps.length, (i) {
      return MealPlan(
        id: maps[i]['id'],
        name: maps[i]['name'],
        timestamp: maps[i]['timestamp'],
        status: (maps[i]['status']),
        foodImage: (maps[i]['foodImage']),
        foodName: (maps[i]['foodName']),
      );
    });
  }
}
