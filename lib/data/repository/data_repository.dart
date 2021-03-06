import 'dart:convert';
import 'package:angime_hub/data/database/user/user_database.dart';
import 'package:angime_hub/data/models/artist_model.dart';
import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/data/models/search_result_model.dart';
import 'package:angime_hub/ui/main/upload/upload_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/media_card_model.dart';
import '../models/user_model.dart';

const apiBase = 'http://35.246.32.45:80/';

class DataRepository {
  late Database db;

  DataRepository() {
    getDatabase();
  }

  Future<Database> getDatabase() async {
    db = await UserDatabase.instance.database;
    return db;
  }

  Future<void> addUser(User user) async {
    db.insert(userTable, user.toJson());
  }

  Future<User> getUser() async {
    final maps = await db.query(
      userTable,
      columns: UserFields.all,
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception("No user in the database");
    }
  }

  Future<int> deleteUser() async {
    return await db.delete(userTable);
  }

  Future<List<Artist>> getPopularPodcastArtists() async {
    try {
      final response = await http.get(Uri.parse(apiBase + "artist/getPopular"));
      if (response.body.isNotEmpty) {
        var popularArtists =
            (jsonDecode(utf8.decode(response.bodyBytes)) as List)
                .map((i) => Artist.fromJson(i, null, null))
                .toList();
        return popularArtists;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Artist>> getPopularStandUpArtists() async {
    try {
      final response = await http.get(Uri.parse(apiBase + "artist/getPopular"));
      if (response.body.isNotEmpty) {
        var popularArtists =
            (jsonDecode(utf8.decode(response.bodyBytes)) as List)
                .map((i) => Artist.fromJson(i, null, null))
                .toList();
        return popularArtists;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> becomeArtist(String email) async {
    var user = await getUser();
    try {
      final response = await http
          .post(Uri.parse(apiBase + "user/becomeartist?token=${user.token}"));
      if (response.statusCode == 200) {
        await db.rawInsert(
            "UPDATE user SET role = ? WHERE email = ?", ['artist', email]);
        user = await getUser();
      } else {
        throw Exception("Error from server side");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MediaCardEntity>> getPopularStandUps() async {
    try {
      final response =
          await http.get(Uri.parse(apiBase + "standup/getPopulars"));
      if (response.body.isNotEmpty) {
        var popularShows = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
            .map((i) => MediaCardEntity.fromJson(i))
            .toList();
        return popularShows;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MediaCardEntity>> getPopularPodcasts() async {
    try {
      final response =
          await http.get(Uri.parse(apiBase + "podcast/getPopulars"));
      if (response.body.isNotEmpty) {
        var popularShows = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
            .map((i) => MediaCardEntity.fromJson(i))
            .toList();
        return popularShows;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MediaCardEntity>> getSavedRecordings(String token) async {
    try {
      final response = await http
          .get(Uri.parse(apiBase + "user/favourite/get?token=$token"));
      if (response.body.isNotEmpty) {
        var savedShows = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
            .map((i) => MediaCardEntity.fromJson(i))
            .toList();
        return savedShows;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadFile(UploadEntity media) async {
    String showType = media.type == 1 ? "podcast" : "standup";
    String mediaType = media.type == 1 ? "audio" : "video";

    var postUri = Uri.parse(apiBase + "$showType/upload");
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    try {
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
      } else {
        return "Couldnt upload video. Try again later";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<MediaEntity> getFullMediaInfo(int id) async {
    try {
      final response = await http
          .get(Uri.parse(apiBase + "media/videoFullInfo?videoId=$id"));
      if (response.body.isNotEmpty) {
        String preview =
            jsonDecode(utf8.decode(response.bodyBytes))["urlImage"].toString();
        String url =
            jsonDecode(utf8.decode(response.bodyBytes))["urlVideo"].toString();
        String mediaName =
            jsonDecode(utf8.decode(response.bodyBytes))["mediaName"].toString();
        int artistId = jsonDecode(utf8.decode(response.bodyBytes))["artistId"];
        Artist artist = await getArtistInfo(artistId);
        int type = jsonDecode(utf8.decode(response.bodyBytes))["type"];
        int views = jsonDecode(utf8.decode(response.bodyBytes))["views"];
        return MediaEntity(
          id: id,
          url: url,
          preview: preview,
          mediaName: mediaName,
          artist: artist,
          views: views,
          type: type,
        );
      }
      throw Exception(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Artist> getArtistInfo(int id) async {
    try {
      final response =
          await http.get(Uri.parse(apiBase + "artist/getInfo?artistId=$id"));
      if (response.body.isNotEmpty) {
        List rawPodcasts =
            jsonDecode(utf8.decode(response.bodyBytes))['podcasts'];
        List rawStandUps =
            jsonDecode(utf8.decode(response.bodyBytes))['standups'];

        List<MediaCardEntity>? standUps;
        List<MediaCardEntity>? podcasts;
        // ignore: unnecessary_null_comparison
        if (rawStandUps != null) {
          standUps =
              (rawStandUps).map((i) => MediaCardEntity.fromJson(i)).toList();
        }
        // ignore: unnecessary_null_comparison
        if (rawPodcasts != null) {
          podcasts =
              (rawPodcasts).map((i) => MediaCardEntity.fromJson(i)).toList();
        }

        Artist artist = Artist.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)), standUps, podcasts);
        return artist;
      }
      throw Exception(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MediaCardEntity>> getUserRecordings(String token) async {
    try {
      final response =
          await http.get(Uri.parse(apiBase + "user/recordings?token=$token"));
      if (response.body.isNotEmpty) {
        var popularShows = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
            .map((i) => MediaCardEntity.fromJson(i))
            .toList();
        return popularShows;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addMediaToFavourites(
      {required String token, required int id}) async {
    try {
      final response = await http.post(
          Uri.parse(apiBase + "user/favourite/add?token=$token&videoId=$id"));
      if (response.statusCode == 200) {
        return "Successfully added show to favourites";
      }
      return "Error occured, couldn't add show to favourites";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteMediaFromFavourites(
      {required String token, required int id}) async {
    try {
      final response = await http.post(Uri.parse(
          apiBase + "user/favourite/delete?token=$token&videoId=$id"));
      if (response.statusCode == 200) {
        return "Successfully deleted show from favourites";
      }
      return "Error occurred, couldn't delete show from favourites";
    } catch (e) {
      return e.toString();
    }
  }

  Future<SearchResult> getSearchResult(String query) async {
    try {
      final response =
          await http.get(Uri.parse(apiBase + "search?searchValue=$query"));
      if (response.body.isNotEmpty) {
        List rawArtists =
            jsonDecode(utf8.decode(response.bodyBytes))['artists'];
        List rawPodcasts =
            jsonDecode(utf8.decode(response.bodyBytes))['podcasts'];
        List rawStandUps =
            jsonDecode(utf8.decode(response.bodyBytes))['standups'];
        List<Artist>? artists;
        List<MediaCardEntity>? standUps;
        List<MediaCardEntity>? podcasts;

        // ignore: unnecessary_null_comparison
        if (rawArtists != null) {
          artists =
              rawArtists.map((i) => Artist.fromJson(i, null, null)).toList();
        }
        // ignore: unnecessary_null_comparison
        if (rawStandUps != null) {
          standUps =
              (rawStandUps).map((i) => MediaCardEntity.fromJson(i)).toList();
        }
        // ignore: unnecessary_null_comparison
        if (rawPodcasts != null) {
          podcasts =
              (rawPodcasts).map((i) => MediaCardEntity.fromJson(i)).toList();
        }

        return SearchResult(
            artists: artists, standUps: standUps, podcasts: podcasts);
      }
      throw Exception(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
