import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/assembly_line.dart';

class AssemblyDB {
  static final AssemblyDB _instance = AssemblyDB._internal();
  factory AssemblyDB() => _instance;
  AssemblyDB._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'assembly_line.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE assembly_lines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        serialNumber TEXT NOT NULL,
        productType TEXT NOT NULL,
        status TEXT NOT NULL,
        operatorName TEXT NOT NULL,
        speed REAL NOT NULL,
        startedAt TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAssembly(AssemblyLine a) async {
    final db = await database;
    return await db.insert('assembly_lines', a.toMap());
  }

  Future<List<AssemblyLine>> getAll() async {
    final db = await database;
    final maps = await db.query('assembly_lines', orderBy: 'id DESC');
    return maps.map((m) => AssemblyLine.fromMap(m)).toList();
  }

  Future<int> updateAssembly(AssemblyLine a) async {
    final db = await database;
    return await db.update('assembly_lines', a.toMap(), where: 'id = ?', whereArgs: [a.id]);
  }

  Future<int> deleteAssembly(int id) async {
    final db = await database;
    return await db.delete('assembly_lines', where: 'id = ?', whereArgs: [id]);
  }
}