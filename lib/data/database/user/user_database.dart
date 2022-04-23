import 'package:angime_hub/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('appDB');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = dbPath+filePath;

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async{
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const stringType = "STRING NOT NULL";
    await db.execute('''
     CREATE TABLE $userTable(
     ${UserFields.id} $idType,
     ${UserFields.firstName} $stringType,
     ${UserFields.secondName} $stringType,
     ${UserFields.email} $stringType
     )
     ''');
  }

  Future _close() async{
    final db = await instance.database;
    db.close();
  }


  Future<void> addUser(User user) async{
    final db = await instance.database;
    await db.insert(userTable, user.toJson());
  }


  Future<User> getUser() async{
    final db = await instance.database;
    final maps = await db.query(
      userTable,
      columns: UserFields.all,
    );

    if (maps.isNotEmpty){
      return User.fromJson(maps.first);
    } else{
      throw Exception("No user in the database");
    }
  }

  Future <int> deleteUser(String email) async{
    final db = await instance.database;
    return await db.delete(userTable);
  }

}