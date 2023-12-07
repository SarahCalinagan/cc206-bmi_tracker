import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = 'bmi_database.db';
  static final _databaseVersion = 1;

  static final table = 'users';

  static final columnId = '_id';
  static final columnName = 'username';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnDateOfBirth = 'date_of_birth';
  static final columnGender = 'gender';

  static final bmiTable = 'bmi_results';

  static final bmiColumnId = '_id';
  static final bmiColumnUserId = 'user_id';
  static final bmiColumnHeight = 'height';
  static final bmiColumnWeight = 'weight';
  static final bmiColumnBmiResult = 'bmi_result';
  static final bmiColumnClassification = 'classification';
  static final bmiColumnDate = 'date';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnDateOfBirth TEXT NOT NULL,
        $columnGender TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $bmiTable (
        $bmiColumnId INTEGER PRIMARY KEY,
        $bmiColumnUserId INTEGER,
        $bmiColumnHeight REAL NOT NULL,
        $bmiColumnWeight REAL NOT NULL,
        $bmiColumnBmiResult REAL NOT NULL,
        $bmiColumnClassification TEXT NOT NULL,
        $bmiColumnDate TEXT NOT NULL
    )
  ''');
  }

  // Helper methods

  Future<int> insertBMIResult(Map<String, dynamic> row) async {
    Database db = await instance.database;
    row[DatabaseHelper.bmiColumnDate] = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Extracting only the date
    return await db.insert(bmiTable, row);
  }

  Future<int> updateBMIRecord(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[bmiColumnId];
    return await db
        .update(bmiTable, row, where: '$bmiColumnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryBMIResults(int userId) async {
    Database db = await instance.database;
    return await db.query(
      bmiTable,
      where: '$bmiColumnUserId = ?',
      whereArgs: [userId],
      orderBy: '$bmiColumnDate DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getBMIResults(int userId) async {
    Database db = await instance.database;
    return await db.query(
      bmiTable,
      where: '$bmiColumnUserId = ?',
      whereArgs: [userId],
      orderBy: '$bmiColumnDate ASC', // Order by date in ascending order
    );
  }

  Future<void> deleteBMIRecord(int id) async {
    final db = await instance.database;
    await db.delete(
      bmiTable,
      where: '$bmiColumnId = ?',
      whereArgs: [id],
    );
  }

  // Insert a user into the database
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<Map<String, dynamic>?> getUserDetailsById(int userId) async {
    Database db = await instance.database;
    try {
      List<Map<String, dynamic>> result = await db.query(
        table,
        columns: [columnName, columnEmail],
        where: '$columnId = ?',
        whereArgs: [userId],
      );

      return result.isNotEmpty
          ? {
              'username': result.first[columnName],
              'email': result.first[columnEmail],
            }
          : null;
    } catch (e) {
      print('Error fetching user details by ID: $e');
      return null;
    }
  }

  // Query a specific user by username and password
  Future<Map<String, dynamic>?> queryUser(
      String username, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnName = ? AND $columnPassword = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update a user's information
  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete a user from the database
  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> getUserById(int userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> queryUserById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> closeDatabase() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> readDatabase() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> users = await db.query(table);

    users.forEach((user) {
      print(
          'User ID: ${user[columnId]}, Username: ${user[columnName]}, Password: ${user[columnPassword]}');
    });
  }

  Future<void> eadDatabase() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> bmiResults = await db.query(bmiTable);

    bmiResults.forEach((result) {
      print(
          'BMI Result ID: ${result[bmiColumnId]}, User ID: ${result[bmiColumnUserId]}, BMI: ${result[bmiColumnBmiResult]}');
    });
  }
}
