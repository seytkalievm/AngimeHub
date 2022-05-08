import 'package:angime_hub/content/requests.dart';
import 'package:angime_hub/data/database/user/user_database.dart';
import 'package:angime_hub/data/models/artist_model.dart';
import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/ui/main/upload/upload_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';



import '../models/user_model.dart';

const apiBase = 'http://35.246.32.45:80/';

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

  Future <int> deleteUser() async{
    return await db.delete(userTable);
  }

  Future <List<Artist>> getPopularPodcastArtists()async{
    var artists = getPodcastArtists();
    return artists;
  }

  Future<List<Artist>> getPopularStandUpArtists()async{
    var artists = getStandUpArtists();
    return artists;
  }

  Future <List<MediaEntity>> getPopularPodcasts() async{
    var podcasts = getPodcasts();
    return podcasts;
  }

  Future <void> becomeArtist(String email)async{
    var user = await getUser();
    try{
      final response = await http.post(
        Uri.parse(apiBase + "user/becomeartist?token=${user.token}")
      );
      if(response.statusCode == 200){
        await db.rawInsert("UPDATE user SET role = ? WHERE email = ?", ['artist', email]);
        user = await getUser();
      } else{
        throw Exception("Error from server side");
      }
    } catch (e){
      rethrow;
    }

  }

  Future <List<MediaEntity>> getPopularStandUps()async{
    var standUps = getStandUps();
    return standUps;
  }

  Future <List<MediaEntity>> getSavedRecordings()async{
    var user = await getUser();
    return user.medias;
  }


  Future<String> uploadFile(UploadEntity media) async {
    String showType = media.type == 1 ? "podcast" : "standup";
    String mediaType = media.type == 1 ? "audio": "video";

    var postUri = Uri.parse(apiBase + "$showType/upload");
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    try{
      http.MultipartFile videoFile = await http.MultipartFile.fromPath(
          "video", "${media.media.path}",
          contentType: MediaType(mediaType, '${media.media.extension}'));
      http.MultipartFile imageFile = await http.MultipartFile.fromPath(
          'splash_screen', "${media.preview.path}",
          contentType: MediaType('image', '${media.preview.extension}'));

      request.files.addAll([videoFile, imageFile]);
      request.fields.addAll({
        "name": media.mediaName,
        "type": "${media.type}",
        "token": media.user.token
      });
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return "Successfully uploaded video";
      }
      else {
        return "Couldnt upload video. Try again later";
      }
    } catch (e){
      return e.toString();
    }
  }

}
