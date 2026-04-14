import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocab_flash_app/model/progress_model.dart';
import 'package:vocab_flash_app/model/word_model.dart';

class DbHelper {
  static Database? _database;
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB();
      return _database!;
    }
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'vocabflash.db');
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.execute('''
    CREATE TABLE words (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      word TEXT NOT NULL,
      meaning TEXT NOT NULL,
      phonetic TEXT NOT NULL,
      example TEXT NOT NULL,
      isKnown INTEGER NOT NULL DEFAULT 0,
      addedDate TEXT NOT NULL
    )
    ''');
    await db.execute('''
     CREATE TABLE progress (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL UNIQUE,
      cardsReviewed INTEGER NOT NULL DEFAULT 0,
      correctCount INTEGER NOT NULL DEFAULT 0
    )
    ''');
  }

  // word table
  static Future<void> insertWord(WordModel word) async {
    Database db = await database;
    db.insert('words', word.toMap());
  }

  static Future<List<WordModel>> getAlltheWords() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('words');
    return result.map((e) => WordModel.fromMap(e)).toList();
  }

  static Future<List<WordModel>> searchWords(String query) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'words',
      where: 'word LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((e) => WordModel.fromMap(e)).toList();
  }

  static Future<WordModel?> getWordByName(String word) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'words',
      where: 'word = ?',
      whereArgs: [word],
    );
    if (result.isNotEmpty) {
      return WordModel.fromMap(result.first);
    }
    return null;
  }

  static Future<void> updateWord(WordModel word) async {
    Database db = await database;
    db.update('words', word.toMap(), where: 'id = ?', whereArgs: [word.id]);
  }

  static Future<void> deleteWord(int id) async {
    Database db = await database;
    db.delete('words', where: 'id = ?', whereArgs: [id]);
  }

  // progress table
  static Future<ProgressModel?> getProgressByDate(String date) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'progress',
      where: 'date = ?',
      whereArgs: [date],
    );
    if (result.isEmpty) return null;
    return ProgressModel.fromMap(result.first);
  }

  static Future<void> insertProgress(ProgressModel progress) async {
    Database db = await database;
    await db.insert('progress', progress.toMap());
  }

  static Future<void> updateProgress(ProgressModel progress) async {
    Database db = await database;
    await db.update(
      'progress',
      progress.toMap(),
      where: 'id = ?',
      whereArgs: [progress.id],
    );
  }
  static Future<List<ProgressModel>> getWeeklyProgress() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'progress',
      orderBy: 'date DESC',
      limit: 7,
    );
    return result.map((e) => ProgressModel.fromMap(e)).toList();
  }
}
