import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:recipe_finder/data/data_source/favorites_data_source/favorites_data_source.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDataSourceLocalDB extends FavoritesDataSource {
  static const _databaseName = 'recipes.db';

  final Completer<Database> _databaseCompleter = Completer();

  Future<Database> get _database => _databaseCompleter.future;

  FavoriteDataSourceLocalDB() {
    _initDB();
  }

  Future<void> _initDB() async {
    if (!_databaseCompleter.isCompleted) {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, _databaseName);

      _databaseCompleter.complete(
        await openDatabase(path, version: 1, onCreate: _createRecipeTable),
      );
    }
  }

  Future _createRecipeTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        preparationTime INTEGER NOT NULL,
        isFavorite INTEGER NOT NULL,
        imagePath TEXT NOT NULL,
        ingredients TEXT,
        instructions TEXT
      )
    ''');
  }

  @override
  Future<void> addFavorite(Recipe recipe) async {
    final db = await _database;

    await db.insert('recipes', {
      'id': recipe.id,
      'name': recipe.name,
      'preparationTime': recipe.preparationTime.inMinutes,
      'isFavorite': 1,
      'imagePath': recipe.imagePath,
      'ingredients': jsonEncode(recipe.ingredients),
      'instructions': jsonEncode(recipe.instructions),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    final db = await _database;

    final result = await db.query('recipes');

    return result
        .map(
          (json) => Recipe(
            id: json['id'] as String,
            name: json['name'] as String,
            preparationTime: Duration(minutes: json['preparationTime'] as int),
            isFavorite: (json['isFavorite'] as int) == 1,
            imagePath: json['imagePath'] as String,
            ingredients: List<String>.from(
              jsonDecode(json['ingredients'] as String),
            ),
            instructions: List<String>.from(
              jsonDecode(json['instructions'] as String),
            ),
          ),
        )
        .toList();
  }

  @override
  Future<void> removeFavorite(Recipe recipe) async {
    final db = await _database;

    await db.delete('recipes', where: 'id = ?', whereArgs: [recipe.id]);
  }
}
