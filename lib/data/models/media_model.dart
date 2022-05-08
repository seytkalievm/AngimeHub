import 'package:angime_hub/data/models/user_model.dart';

import 'artist_model.dart';

class MediaEntity {
  late int _id;
  late String _url;
  late String _preview;
  late String _mediaName;
  late Artist _artist;
  late int _views;
  late int _type;

  MediaEntity({
    required int id,
    required String url,
    required String preview,
    required String mediaName,
    required Artist artist,
    required int views,
    required int type,
  }) {
    _id = id;
    _url = url;
    _preview = preview;
    _mediaName = mediaName;
    _artist = artist;
    _views = views;
    _type = type;
  }

  int get id {
    return _id;
  }

  String get url {
    return _url;
  }

  String get preview {
    return _preview;
  }

  String get name {
    return _mediaName;
  }

  Artist get artist {
    return _artist;
  }

  int get views {
    return _views;
  }


  int get type {
    return _type;
  }

  @override
  String toString() {
    return artist.toString() + ": " + name;
  }

}
