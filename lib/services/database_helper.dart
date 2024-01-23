import 'package:emotion_tracker/models/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'emotion_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE emotions(id INTEGER PRIMARY KEY, emotion TEXT, timestamp TEXT, text TEXT, author TEXT)',
        );
      },
    );
  }

  Future<void> insertEmotion(String emotion, String timestamp, String text, String author) async {
    print("insert ????????* $emotion");
    final Database db = await database;
    await db.insert(
      'emotions',
      {'emotion': emotion, 'timestamp': timestamp, 'text': text, 'author': author},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getEmotions() async {
    final Database db = await database;
    return await db.query('emotions');
  }

  Future<List<Map<String, dynamic>>> getEmotionData(String emotion) async {
    final Database db = await database;
    return await db.query('emotions', where: 'emotion = ?', whereArgs: [emotion]);
  }

  Future<void> deleteAllEmotions() async {
    final Database db = await database;
    await db.delete('emotions');
  }
}
