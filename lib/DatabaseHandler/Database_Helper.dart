// ignore_for_file: unused_import

import 'package:nomnomnerds/models/ingredients_model.dart';
import 'package:nomnomnerds/models/recipe_ingredient_model.dart';
import 'package:nomnomnerds/models/recipenolist_model.dart';
import 'package:nomnomnerds/models/user_categories.dart';
import 'package:nomnomnerds/models/user_diet_preferences.dart';
import 'package:nomnomnerds/models/user_recipe_model.dart';
import 'package:nomnomnerds/models/users_model.dart';
import 'package:nomnomnerds/models/recipes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE Users (
          userid INTEGER PRIMARY KEY AUTOINCREMENT, 
          username TEXT NOT NULL UNIQUE, 
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL )
          """);

    await database.execute("""CREATE TABLE Recipes (
            recipe_id INTEGER PRIMARY KEY ,
            recipe_name STRING NOT NULL ,
            description STRING NOT NULL ,
            cuisine STRING NOT NULL ,
            diet STRING ,
            prep_time INTEGER NOT NULL ,
            cook_time INTEGER NOT NULL ,
            instructions STRING NOT NULL,
            image_url STRING NOT NULL )
            """);

    await database.execute("""CREATE TABLE Ingredients (
            ing_id INTEGER PRIMARY KEY,
            ing_name STRING NOT NULL UNIQUE)       
            """);

    await database.execute("""CREATE TABLE RecipeIngredient (
            recipe_id INTEGER NOT NULL,
            ing_id INTEGER NOT NULL,
            PRIMARY KEY (recipe_id,ing_id)               
            FOREIGN KEY (ing_id) REFERENCES Ingredients (ing_id),
            FOREIGN KEY (recipe_id) REFERENCES Recipes (recipe_id)
            )
            """);
    await database.execute("""CREATE TABLE UsersCategories (
            userid INTEGER NOT NULL UNIQUE,
            category1 STRING NOT NULL,
            category2 STRING NOT NULL,
            category3 STRING NOT NULL,
            category4 STRING NOT NULL,
            category5 STRING NOT NULL,
            FOREIGN KEY (userid) REFERENCES Users (userid)
            )
            """);

    await database.execute("""CREATE TABLE UsersDietPreferences (
            userid INTEGER NOT NULL UNIQUE,
            diet1 STRING NOT NULL,
            diet2 STRING NOT NULL,
            FOREIGN KEY (userid) REFERENCES Users (userid)
            )
            """);
    await database.execute("""CREATE TABLE UserRecipes (
            userid INTEGER,
            recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
            recipe_name STRING NOT NULL UNIQUE ,
            description STRING NOT NULL ,
            cuisine STRING NOT NULL ,
            diet STRING ,
            prep_time INTEGER NOT NULL ,
            cook_time INTEGER NOT NULL ,
            instructions STRING NOT NULL)
            """);
    await database.execute("""CREATE TABLE UsersFavorites(
              userid INTEGER NOT NULL,
              recipe_id INTEGER NOT NULL,
              PRIMARY KEY (userid,recipe_id),
              FOREIGN KEY (userid) REFERENCES Users (userid)
              )
    """);
    print("Database was created!");
  }

  //whenever changing the datbase change the version of database
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'nomnomnerds1.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("asd1");
        await createTable(database);
      },
      onConfigure: _onConfigure,
    );
  }

  static Future<int> saveData(UserModel um) async {
    final dbs = await db();
    print(um.userid);
    final id = await dbs.insert('Users', um.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    print("asd2");
    print(id);
    return id;
  }

  static Future<int> saveRecipes(RecipeModel rm) async {
    final dbs = await db();
    print(rm.recipe_id[0]);
    for (int i = 0; i < rm.recipe_id.length; i++) {
      final data = {
        'recipe_id': rm.recipe_id[i],
        'recipe_name': rm.recipe_name[i],
        'description': rm.description[i],
        'cuisine': rm.cuisine[i],
        'diet': rm.diet[i],
        'prep_time': rm.prep_time[i],
        'cook_time': rm.cook_time[i],
        'instructions': rm.instructions[i],
        'image_url': rm.image_url[i],
      };
      final id = await dbs.insert('Recipes', data,
          conflictAlgorithm: sql.ConflictAlgorithm.ignore);
      print("RecipeSaved");
      print(id);
    }
    return 1;
  }

  static Future<int> saveIngredients(Ingredients im) async {
    final dbs = await db();
    for (int i = 0; i < im.ing_id.length; i++) {
      final data = {
        'ing_id': im.ing_id[i],
        'ing_name': im.ing_name[i],
      };
      final id = await dbs.insert('Ingredients', data,
          conflictAlgorithm: sql.ConflictAlgorithm.ignore);
      print("IngredientsSaved");
      print(id);
    }
    return 1;
  }

  static Future<int> saveRecipeIngredients(RecipeIngredients rim) async {
    final dbs = await db();
    for (int i = 0; i < rim.ing_id.length; i++) {
      final data = {
        'recipe_id': rim.recipe_id[i],
        'ing_id': rim.ing_id[i],
      };
      final id = await dbs.insert('RecipeIngredient', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print("RecipeIngredientsSaved");
      print(id);
    }
    return 1;
  }

  static Future<int> saveCategory(UserCategories uc) async {
    final dbs = await db();
    final data = {
      'userid': uc.userid,
      'category1': uc.categories[0],
      'category2': uc.categories[1],
      'category3': uc.categories[2],
      'category4': uc.categories[3],
      'category5': uc.categories[4]
    };
    final id = await dbs.insert('UsersCategories', data,
        conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    print("catsave");
    print(id);
    return id;
  }

  static Future<int> saveDietPref(UserDietPreferences ud) async {
    final dbs = await db();
    final data = {
      'userid': ud.userid,
      'diet1': ud.diet[0],
      'diet2': ud.diet[1],
    };
    final id = await dbs.insert('UsersDietPreferences', data,
        conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    print(ud.userid);
    print(ud.diet);
    print("dietsave");
    print(id);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getLoginUser(
      String email, String pass) async {
    final dbs = await db();
    final List<Map<String, dynamic>> info = await dbs.rawQuery(
      'SELECT * FROM USERS WHERE email=? AND password=?',
      [email, pass],
    );
    return info;
  }

  static Future<List<RecipenolistModel>> getRecipesfromSearch(searched) async {
    final dbs = await DatabaseHelper.db();
    print(searched);
    //final List<Map<String, dynamic>> results = await dbs.query('Recipes');
    String temp = searched;
    print("check2");
    print(temp);
    print("check3");
    final List<Map<String, dynamic>> results = await dbs
        .query('Recipes', where: 'recipe_name LIKE ?', whereArgs: ['%$temp%']);
    // final List<Map<String, dynamic>> results = await dbs
    //     .rawQuery('SELECT * FROM Recipes WHERE recipe_name LIKE (?)', ['Matar']);

    print(results.length);
    print("check4");
    return List.generate(results.length, (i) {
      return RecipenolistModel(
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
        image_url: results[i]['image_url'] as String,
      );
    });
  }

  static Future<List<RecipenolistModel>> getRecipesfromSearchviaIngredients(
      searched) async {
    final dbs = await DatabaseHelper.db();
    print(searched);
    //final List<Map<String, dynamic>> results = await dbs.query('Recipes');
    String temp = searched;
    print("check2");
    print(temp);
    print("check3");
    final List<Map<String, dynamic>> results = await dbs.rawQuery('''
    SELECT * FROM Recipes R
    INNER JOIN RecipeIngredient RI ON R.recipe_id = RI.recipe_id
    INNER JOIN Ingredients I ON RI.ing_id = I.ing_id
    WHERE I.ing_name LIKE ?
    ''', ['%$searched%']);
    // final List<Map<String, dynamic>> results = await dbs
    //     .query('Recipes', where: 'recipe_name LIKE ?', whereArgs: ['%$temp%']);
    // final List<Map<String, dynamic>> results = await dbs
    //     .rawQuery('SELECT * FROM Recipes WHERE recipe_name LIKE (?)', ['Matar']);

    print(results.length);
    print("check4");
    return List.generate(results.length, (i) {
      return RecipenolistModel(
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
        image_url: results[i]['image_url'] as String,
      );
    });
  }

  static Future<List<RecipenolistModel>> getRecommendedRecipes(userid) async {
    final dbs = await DatabaseHelper.db();
    print("In Recommended Reicpe function $userid");
    final List<Map<String, dynamic>> results = await dbs.rawQuery('''
      SELECT * FROM Recipes 
      LEFT JOIN UsersCategories UC1 ON cuisine = UC1.category1
      LEFT JOIN UsersCategories UC2 ON cuisine = UC2.category2
      LEFT JOIN UsersCategories UC3 ON cuisine = UC3.category3
      LEFT JOIN UsersCategories UC4 ON cuisine = UC4.category4
      LEFT JOIN UsersCategories UC5 ON cuisine = UC5.category5
      LEFT JOIN UsersDietPreferences DP1 ON diet = DP1.diet1
      LEFT JOIN UsersDietPreferences DP2 ON diet = DP2.diet2
      WHERE UC1.userid = ? OR UC2.userid = ? OR UC3.userid = ? OR UC4.userid = ? OR UC5.userid = ? OR DP1.userid = ? OR DP2.userid = ?
    ''', [userid, userid, userid, userid, userid, userid, userid]);

    print(results.length);
    return List.generate(results.length, (i) {
      return RecipenolistModel(
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
        image_url: results[i]['image_url'] as String,
      );
    });
  }

  //call this function when u create a third ROW
  static Future<List<RecipenolistModel>> getRecipesyoumaylike(userid) async {
    final dbs = await DatabaseHelper.db();
    print("In Recommended Reicpe function $userid");
    final List<Map<String, dynamic>> results = await dbs.rawQuery('''
      SELECT DISTINCT * FROM Recipes 
      LEFT JOIN UsersCategories UC1 ON cuisine = UC1.category1
      LEFT JOIN UsersCategories UC2 ON cuisine = UC2.category2
      WHERE UC1.userid = ? OR UC2.userid = ? OR cuisine = ?
    ''', [userid, userid, 'Indian']);

    print(results.length);
    return List.generate(results.length, (i) {
      return RecipenolistModel(
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
        image_url: results[i]['image_url'] as String,
      );
    });
  }

  static Future<List<RecipenolistModel>> getHealthyOptions(userid) async {
    //uses only diet
    final dbs = await DatabaseHelper.db();
    print("In Recommended Reicpe function $userid");
    // final List<Map<String, dynamic>> results = await dbs.rawQuery('''
    //   SELECT * FROM Recipes
    //   LEFT JOIN UsersDietPreferences DP1 ON diet = DP1.diet1
    //   LEFT JOIN UsersDietPreferences DP2 ON diet = DP2.diet2
    //   WHERE DP1.userid = ? OR DP2.userid = ?
    // ''', [userid, userid]);
    final List<Map<String, dynamic>> results = await dbs.rawQuery('''
      SELECT * FROM Recipes
      WHERE diet = ? OR diet = ? OR diet = ?
    ''', [
      'High Protein Non Vegetarian',
      'High Protein Vegetarian',
      'Diabetic Friendly'
    ]);
    print(results.length);
    return List.generate(results.length, (i) {
      return RecipenolistModel(
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
        image_url: results[i]['image_url'] as String,
      );
    });
  }

  static Future<List<int>> getIngredientID(recipeid) async {
    final dbs = await DatabaseHelper.db();
    //print("In get INGRED ID function $recipeid");
    final List<Map<String, dynamic>> results = await dbs.query(
      'RecipeIngredient',
      //columns: ['ing_id'],
      where: 'recipe_id = ?',
      whereArgs: ['$recipeid'],
    );
    return List.generate(results.length, (i) {
      return (results[i]['ing_id'] as int);
    });
  }

  static Future<List<String>> getIngredientname(ingid) async {
    final dbs = await DatabaseHelper.db();
    print("In get INGRED NAME function $ingid");
    final List<Map<String, dynamic>> results = await dbs.query(
      'Ingredients',
      //columns: ['ing_id'],
      where: 'ing_id IN (${('?' * (ingid.length)).split('').join(', ')})',
      whereArgs: ingid,
    );
    print(results.length);
    //final List<Map<String, dynamic>> results = await dbs.rawQuery("SELECT * FROM Ingredients WHERE ing_id = ?")
    return List.generate(results.length, (i) {
      return (results[i]['ing_name'] as String);
    });
  }

  static Future<List<String>> getIngredientNames() async {
    final dbs = await DatabaseHelper.db();
    final List<Map<String, dynamic>> results = await dbs.query('Ingredients');

    print(results.length);

    return List.generate(results.length, (i) {
      return (results[i]['ing_name'] as String);
    });
  }

  static Future<List<RecipenolistModel>> getGeneratedRecipes(searched) async {
    final dbs = await DatabaseHelper.db();
    print("check2");
    print(searched);
    print("check3");
    final List<Map<String, dynamic>> result1 = await dbs.query(
      'Ingredients',
      columns: ['ing_id'],
      where: 'ing_name IN (${('?' * (searched.length)).split('').join(', ')})',
      whereArgs: searched,
    );
    print(result1);
    print("check4");

    List ingids = result1
        .map(
          (e) => e['ing_id'].toString(),
        )
        .toList();
    print(ingids);
    print("check5");
    final List<Map<String, dynamic>> result2 = await dbs.query(
      'RecipeIngredient',
      columns: ['recipe_id'],
      where: 'ing_id IN (${('?' * (ingids.length)).split('').join(', ')})',
      whereArgs: ingids,
    );
    print("check6");
    print(result2);
    List recipeids = result2
        .map(
          (i) => i['recipe_id'].toString(),
        )
        .toList();
    print(recipeids);
    print("check7");
    final List<Map<String, dynamic>> result3 = await dbs.query(
      'Recipes',
      where:
          'recipe_id IN (${('?' * (recipeids.length)).split('').join(', ')})',
      whereArgs: recipeids,
    );
    print(result3.length);
    print("check4");
    return List.generate(result3.length, (i) {
      return RecipenolistModel(
        recipe_id: result3[i]['recipe_id'] as int,
        recipe_name: result3[i]['recipe_name'] as String,
        description: result3[i]['description'] as String,
        cuisine: result3[i]['cuisine'] as String,
        diet: result3[i]['diet'] as String,
        prep_time: result3[i]['prep_time'] as int,
        cook_time: result3[i]['cook_time'] as int,
        instructions: result3[i]['instructions'] as String,
        image_url: result3[i]['image_url'] as String,
      );
    });
  }

  static Future<int> saveUserRecipes(UserRecipeModel rm) async {
    final dbs = await db();
    final data = rm.toMap();
    final id = await dbs.insert('UserRecipes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    print("RecipeSaved");
    print(id);

    return 1;
  }

  static Future<List<UserRecipeModel>> getUserRecipes(userid) async {
    final dbs = await DatabaseHelper.db();
    print(userid);
    //final List<Map<String, dynamic>> results = await dbs.query('Recipes');
    int temp = userid;
    print("check2");
    print(temp);
    print("check3");
    final List<Map<String, dynamic>> results =
        await dbs.query('UserRecipes', where: 'userid = ?', whereArgs: [temp]);
    // final List<Map<String, dynamic>> results = await dbs
    //     .rawQuery('SELECT * FROM Recipes WHERE recipe_name LIKE (?)', ['Matar']);

    print(results.length);
    print("check4");
    return List.generate(results.length, (i) {
      return UserRecipeModel(
        userid: results[i]['userid'] as int,
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
      );
    });
  }

  static Future<int> saveUserFavorites(int userid, int recipe_id) async {
    final dbs = await db();
    final data = {'userid': userid, 'recipe_id': recipe_id};
    final id = await dbs.insert('UsersFavorites', data,
        conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    print("RecipeSaved");
    print(id);

    return 1;
  }

  static Future<bool> checkFavt(int userid, int recipe_id) async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query('UsersFavorites',
        where: 'userid = ? AND recipe_id = ?', whereArgs: [userid, recipe_id]);
    if (results.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<List<RecipenolistModel>> getUserFavorites(userid) async {
    //uses only diet
    final dbs = await DatabaseHelper.db();
    print("In Get User Favt function $userid");
    final List<Map<String, dynamic>> results = await dbs.rawQuery('''
      SELECT * FROM Recipes R
      LEFT JOIN UsersFavorites UF ON R.recipe_id = UF.recipe_id
      WHERE UF.userid = ?
    ''', [userid]);
    // final List<Map<String, dynamic>> results = await dbs.rawQuery('''
    //   SELECT * FROM Recipes
    //   WHERE recipe_id = ? OR diet = ? OR diet = ?
    // ''', [
    //   'High Protein Non Vegetarian',
    //   'High Protein Vegetarian',
    //   'Diabetic Friendly'
    // ]);
    print(results.length);
    return List.generate(results.length, (i) {
      return RecipenolistModel(
        recipe_id: results[i]['recipe_id'] as int,
        recipe_name: results[i]['recipe_name'] as String,
        description: results[i]['description'] as String,
        cuisine: results[i]['cuisine'] as String,
        diet: results[i]['diet'] as String,
        prep_time: results[i]['prep_time'] as int,
        cook_time: results[i]['cook_time'] as int,
        instructions: results[i]['instructions'] as String,
        image_url: results[i]['image_url'] as String,
      );
    });
  }

  static Future<void> dropFavtRecipe(int userid, int recipe_id) async {
    final dbs = await db();
    await dbs.delete('UsersFavorites',
        where: 'userid = ? AND recipe_id = ?', whereArgs: [userid, recipe_id]);
  }

  static Future<void> dropTable() async {
    final dbs = await db();
    print("check25");
    await dbs.execute('DELETE FROM Users');
    await dbs.execute('DELETE FROM UsersDietPreferences');
    await dbs.execute('DELETE FROM UsersCategories');
    // print(count);
  }

  // static Future<List<Map<String, dynamic>>?> getLoginUser(
  //     String email, String pass) async {
  //   final dbs = await db();
  //   final List<Map<String, dynamic>> info = await dbs.query('Users',
  //       where: "email = ? AND password = ?", whereArgs: [email, pass]);
  //   return info;
  // }
}
