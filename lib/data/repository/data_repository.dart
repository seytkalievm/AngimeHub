import 'package:angime_hub/content/requests.dart';
import 'package:angime_hub/data/database/user/user_database.dart';
import 'package:angime_hub/data/models/artist_model.dart';
import 'package:angime_hub/data/models/media_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DataRepository{
  late Database db;

  DataRepository(){
    getDatabase();
  }

  Future<Database> getDatabase()async{
    db = await UserDatabase.instance.database;
    return db;
  }


   Future<void> addUser(User user) async{
     db.insert(userTable, user.toJson());
  }


  Future<User> getUser() async{
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
    return await db.delete(userTable);
  }

  Future <List<Artist>> getPopularArtists()async{
    var artists = getArtists();
    return artists;
  }

  Future <List<MediaEntity>> getPopularPodcasts() async{
    var podcasts = getPodcasts();
    return podcasts;
  }

  Future <List<MediaEntity>> getPopularStandUps()async{
    var standUps = getStandUps();
    return standUps;
  }
}