import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/feedback_entry.dart';

class FeedbackDatabase {
  static final FeedbackDatabase instance = FeedbackDatabase._init();

  static Database? _database;
  static const String tableFeedback = 'feedback';

  FeedbackDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('feedback.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final ratingType = 'REAL NOT NULL';
    final feedbackType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableFeedback (
  id $idType,
  rating $ratingType,
  feedback $feedbackType
)
    ''');
  }

  Future<int> createFeedbackEntry(FeedbackEntry entry) async {
    final db = await instance.database;
    return await db.insert(tableFeedback, entry.toMap());
  }

  Future<List<FeedbackEntry>> getAllFeedbacks() async {
    final db = await instance.database;
    final result = await db.query(tableFeedback);

    return result.map((json) => FeedbackEntry(
      id: json['id'] as int,
      rating: json['rating'] as double,
      feedback: json['feedback'] as String,
    )).toList();
  }
}
