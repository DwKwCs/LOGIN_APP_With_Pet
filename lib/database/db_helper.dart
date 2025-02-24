import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'withpet.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Letter 테이블 생성
        await db.execute('''
          CREATE TABLE Letter (
            Date TEXT PRIMARY KEY,
            Contents TEXT
          )
        ''');

        // TempLetter 테이블 생성
        await db.execute('''
          CREATE TABLE TempLetter (
            Date TEXT PRIMARY KEY,
            Contents TEXT
          )
        ''');

        // Diary 테이블 생성
        await db.execute('''
          CREATE TABLE Diary (
            Date TEXT PRIMARY KEY,
            Walk INTEGER,
            Health INTEGER,
            Medicine INTEGER,
            Sleep TEXT,
            Symptom TEXT,
            Memo_title TEXT,
            Memo_contents TEXT
          )
        ''');

        // Profile 테이블 생성
        await db.execute('''
          CREATE TABLE Profile (
            Id INTEGER PRIMARY KEY,
            Img BLOB,
            IsChecked INTEGER,
            Name TEXT NOT NULL,
            Comment TEXT,
            Species TEXT,
            Data TEXT,
            Ddate TEXT
          )
        ''');

        // Guides 테이블 생성
        await db.execute('''
          CREATE TABLE Guides (
            Code INTEGER PRIMARY KEY,
            Title TEXT NOT NULL,
            Tag TEXT NOT NULL,
            Percent REAL,
            IsSaved INTEGER
          )
        ''');

        // Contents 테이블 생성
        await db.execute('''
          CREATE TABLE Contents (
            G_code INTEGER,
            Number INTEGER,
            Content TEXT,
            IsChecked INTEGER,
            PRIMARY KEY (G_code, Number),
            FOREIGN KEY (G_code) REFERENCES Diary (Code)
          )
        ''');
      },
    );
  }

  // -----------------------------------------------
  // Letter 테이블: 삽입, 업데이트, 조회, 삭제 함수
  // -----------------------------------------------

  Future<int> insertLetter(Map<String, dynamic> letter) async {
    final db = await database;
    return await db.insert('Letter', letter);
  }

  Future<int> updateLetter(String date, Map<String, dynamic> letter) async {
    final db = await database;
    return await db.update(
      'Letter',
      letter,
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<int> deleteLetter(String date) async {
    final db = await database;
    return await db.delete(
      'Letter',
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<Map<String, dynamic>?> getLetterByDate(String date) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'Letter',
      where: 'Date = ?',
      whereArgs: [date],
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllLetters() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('Letter', orderBy: 'Date ASC');
    return result;
  }

  // -----------------------------------------------
  // TempLetter 테이블: 삽입, 업데이트, 조회, 삭제 함수
  // -----------------------------------------------

  Future<int> insertTempLetter(Map<String, dynamic> tempLetter) async {
    final db = await database;
    return await db.insert('TempLetter', tempLetter);
  }

  Future<int> updateTempLetter(String date, Map<String, dynamic> tempLetter) async {
    final db = await database;
    return await db.update(
      'TempLetter',
      tempLetter,
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<int> deleteTempLetter(String date) async {
    final db = await database;
    return await db.delete(
      'TempLetter',
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<int> deleteAllTempLetter() async {
    final db = await database;
    return await db.delete(
      'TempLetter',
    );
  }

  Future<Map<String, dynamic>?> getTempLetterByDate(String date) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'TempLetter',
      where: 'Date = ?',
      whereArgs: [date],
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllTempLetters() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('TempLetter', orderBy: 'Date ASC');
    return result;
  }

  // -----------------------------------------------
  // Diary 테이블: 삽입, 업데이트, 조회, 삭제 함수
  // -----------------------------------------------

  Future<int> insertDiary(Map<String, dynamic> diary) async {
    final db = await database;
    return await db.insert('Diary', diary);
  }

  Future<int> updateDiary(String date, Map<String, dynamic> diary) async {
    final db = await database;
    return await db.update(
      'Diary',
      diary,
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<int> updateDiaryPart(String date, String key, String value) async {
    final db = await database;
    return await db.update(
      'Diary',
      {key: value},
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<int> deleteDiary(String date) async {
    final db = await database;
    return await db.delete(
      'Diary',
      where: 'Date = ?',
      whereArgs: [date],
    );
  }

  Future<Map<String, dynamic>?> getDiaryByDate(String date) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'Diary',
      where: 'Date = ?',
      whereArgs: [date],
    );

    return result.isNotEmpty ? result.first : null; // 데이터 없으면 null 반환
  }

  Future<List<Map<String, dynamic>>> getAllDiary() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('Diary');
    return result;
  }

  // -----------------------------------------------
  // Profile 테이블: 삽입, 업데이트, 조회 함수
  // -----------------------------------------------

  Future<int> insertProfile(Map<String, dynamic> profile) async {
    final db = await database;
    return await db.insert('Profile', profile);
  }

  Future<int> updateProfile(int id, Map<String, dynamic> profile) async {
    final db = await database;
    return await db.update(
      'Profile',
      profile,
      where: 'Id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getAllProfiles() async {
    final db = await database;
    return await db.query('Profile'); // Profile 테이블의 모든 데이터 조회
  }

  // -----------------------------------------------
  // Guides 테이블: 삽입, 업데이트, 삭제 함수
  // -----------------------------------------------

  Future<int> insertGuide(Map<String, dynamic> guide) async {
    final db = await database;
    return await db.insert('Guides', guide);
  }

  Future<int> updateGuideIsSaved(int code, int isSaved) async {
    final db = await database;
    return await db.update(
      'Guides',
      {'IsSaved': isSaved},
      where: 'Code = ?',
      whereArgs: [code],
    );
  }

  Future<int> updateGuidePercent(int code, double percent) async {
    final db = await database;
    return await db.update(
      'Guides',
      {'Percent' : percent},
      where: 'Code = ?',
      whereArgs: [code],
    );
  }

  Future<int> deleteGuide(int code) async {
    final db = await database;
    return await db.delete(
      'Guides',
      where: 'Code = ?',
      whereArgs: [code],
    );
  }

  Future<List<Map<String, dynamic>>> getAllGuides() async {
    final db = await database;
    return await db.query('Guides'); // Guides 테이블의 모든 데이터 조회
  }

  Future<List<Map<String, dynamic>>> getGuides(String tag) async {
    final db = await database;
    return await db.query(
      'Guides',
      where: 'Tag = ?',
      whereArgs: [tag],
    );
  }

  Future<List<Map<String, dynamic>>> getSavedGuides() async {
    final db = await database;
    return await db.query(
      'Guides',
      where: 'IsSaved = 1',
    );
  }

  // -----------------------------------------------
  // Contents 테이블: 삽입, 업데이트, 삭제 함수
  // -----------------------------------------------

  Future<int> insertContent(Map<String, dynamic> content) async {
    final db = await database;
    return await db.insert('Contents', content);
  }

  Future<int> updateContentIsChecked(int gCode, int number, int isChecked) async {
    final db = await database;
    return await db.update(
      'Contents',
      {'IsChecked': isChecked},
      where: 'G_code = ? AND Number = ?',
      whereArgs: [gCode, number],
    );
  }

  Future<int> deleteContent(int gCode, int number) async {
    final db = await database;
    return await db.delete(
      'Contents',
      where: 'G_code = ? AND Number = ?',
      whereArgs: [gCode, number],
    );
  }

  Future<List<Map<String, dynamic>>> getContents(int code) async {
    final db = await database;
    return await db.query(
      'Contents',
      where: 'G_code = ?',
      whereArgs: [code],
      orderBy: 'Number',
    );
  }
}
