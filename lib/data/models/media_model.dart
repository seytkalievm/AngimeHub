import 'package:angime_hub/data/models/user_model.dart';

import 'artist_model.dart';

class MediaEntity{
  late int _id;
  late String _url;
  late String _preview;
  late String _mediaName;
  late Artist _artist;
  late int _duration;
  late int _type;

  MediaEntity({
    required int id,
    required String url,
    required String preview,
    required String mediaName,
    required Artist artist,
    required int duration,
    required int type,
  }){
    _id = id;
    _url = url;
    _preview = preview;
    _mediaName = mediaName;
    _artist = artist;
    _duration = duration;
    _type = type;
  }

  int get id{
    return _id;
  }
  String get url{
    return _url;
  }
  String get preview{
    return _preview;
  }
  String get name{
    return _mediaName;
  }
  Artist get artist{
    return _artist;
  }
  String get duration{
    int h = _duration ~/ 60;
    int m = _duration % 60;
    String mm = m<10? "0$m" : "$m";
    return "$h:$mm";
  }
  int get type{
    return _type;
  }



}