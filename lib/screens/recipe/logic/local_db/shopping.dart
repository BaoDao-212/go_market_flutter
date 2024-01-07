import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/recipe/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRecipe {
  static const String tableName = 'mealPlans';

  static Future<Database> openDatabaseRecipe() async {
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

  static Future<void> insertRecipe(Recipe mealPlan) async {
    final Database db = await openDatabaseRecipe();
    await db.insert(
      tableName,
      {
        'id': mealPlan.id,
        'name': mealPlan.name,
        'htmlContent': mealPlan.htmlContent,
        'description': mealPlan.description,
        'foodName': mealPlan.foodName,
        'foodImage': mealPlan.foodImage,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllRecipes() async {
    final Database db = await openDatabaseRecipe();
    await db.delete(tableName);
  }

  static Future<List<Recipe>> getRecipes() async {
    print(0);
    final Database db = await openDatabaseRecipe();
    print(db);
    final List<Map<String, dynamic>> maps = await db.query("mealPlans");
    print(maps);
    return List.generate(maps.length, (i) {
      return Recipe(
        id: maps[i]['id'],
        name: maps[i]['name'],
        htmlContent: maps[i]['htmlContent'],
        description: (maps[i]['description']),
        foodImage: (maps[i]['foodImage']),
        foodName: (maps[i]['foodName']),
      );
    });
  }
}
