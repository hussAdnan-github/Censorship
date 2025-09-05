import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'bulletins.db');
    return await openDatabase(
      path,
      version: 2, // ✅ غيّر رقم النسخة (مثلاً من 1 إلى 2)
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // ✅ أضفنا onUpgrade
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bulletins(
        id INTEGER PRIMARY KEY,
        name_code TEXT,        -- ✅ أضفنا العمود الجديد
        name_day TEXT,
        name_date_day TEXT,
        name_product TEXT,
        name_unit TEXT,
        old_price TEXT,
        new_price TEXT,
        note TEXT,
        created_at TEXT,
        updated_at TEXT,
        day INTEGER,
        product INTEGER
      )
    ''');
  }

  // ✅ هذا مهم لما يكون فيه نسخة قديمة
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // إضافة العمود الجديد بدون حذف البيانات القديمة
      await db.execute('ALTER TABLE bulletins ADD COLUMN name_code TEXT');
    }
  }

  Future<void> insertBulletin(Map<String, dynamic> bulletin) async {
    final db = await database;
    await db.insert(
      'bulletins',
      bulletin,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getBulletins() async {
    final db = await database;
    return await db.query('bulletins');
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('bulletins');
  }
}
