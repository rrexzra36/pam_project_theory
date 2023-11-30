import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_ahlul_quran_app/data/models/users_model.dart';

class DatabaseHelper {
  final databaseName = "notes3.db";
  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, fullname TEXT, usrName TEXT UNIQUE, usrPassword TEXT)";

  //We are done in this section

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);

      await db.execute('''
      CREATE TABLE payment (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        usrId INTEGER NOT NULL,
        paymentDate TEXT,
        expiredDate TEXT,
        categoryPremium TEXT,
        price TEXT,
        FOREIGN KEY (usrId) REFERENCES users (usrId)
      )
    ''');

      await db.execute('''
      CREATE TABLE favorite (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        usrId INTEGER NOT NULL,
        nomorSurat TEXT,
        namaSuratLatin TEXT,
        jumlahAyatSurat TEXT,
        FOREIGN KEY (usrId) REFERENCES users (usrId)
      )
    ''');
    });
  }

  //Now we create login and sign up method
  //as we create sqlite other functionality in our previous video

  //IF you didn't watch my previous videos, check part 1 and part 2

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }

  //Get current user
  Future<List<Map<String, dynamic>>> getCurrentUser(String username) async {
    Database db = await initDB();
    return await db.query("users", where: 'usrName = ?', whereArgs: [username]);
  }

  Future<int> insertPayment(int usrId, String date, String category,
      String price, String expired) async {
    Database db = await initDB();
    Map<String, dynamic> row = {
      'usrId': usrId,
      'paymentDate': date,
      'expiredDate': expired,
      'categoryPremium': category,
      'price': price,
    };
    return await db.insert("payment", row);
  }

  Future<List<Map<String, dynamic>>> getListPayment(int userId) async {
    Database db = await initDB();
    return await db.query("payment", where: 'usrId = ?', whereArgs: [userId]);
  }

  Future<int> insertFavorite(
      int usrId, String nomorSurat, String namaSurat, String jumlahAyat) async {
    Database db = await initDB();
    Map<String, dynamic> row = {
      'usrId': usrId,
      'nomorSurat': nomorSurat,
      'namaSuratLatin': namaSurat,
      'jumlahAyatSurat': jumlahAyat,
    };
    return await db.insert("favorite", row);
  }

  Future<List<Map<String, dynamic>>> getListFavorite(int userId) async {
    Database db = await initDB();
    return await db.query("favorite", where: 'usrId = ?', whereArgs: [userId]);
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await initDB();
    return await db.delete("favorite", where: 'id = ?', whereArgs: [id]);
  }
}
