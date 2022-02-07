import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/utils/password_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DB{
  /// Helper class for Database initialization and use

  final storage = FlutterSecureStorage();

  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async{
    // Get the path to the documents on the device
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"credentials2.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE credentials(
        id INTEGER PRIMARY KEY,
        name TEXT,
        uname TEXT
      )
    ''');
  }

  Future<List<Password>> getPasswordCredentials() async{
    Database db = await instance.database;
    var credentials = await db.query("credentials");
    // Return a list of password objects or an empty list
    List<Password> passwordList = credentials.isNotEmpty ? credentials.map(
            (e) => Password.fromMap(e)).toList() : [];
    return passwordList;
  }

  void savePassword(Password password,Function callback) async{
    Database db = await instance.database;
    // db.insert takes a map
    await db.insert("credentials", password.toMap()).then(
            (_id){
              print(_id);
              storage.write(key: _id.toString(), value: password.password);
            });
    callback();

  }

  Future<String> getPassword(int id) async{
    return await storage.read(key: id.toString()) ?? "";
  }


}