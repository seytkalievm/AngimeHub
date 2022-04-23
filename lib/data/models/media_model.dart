import 'package:angime_hub/data/models/user_model.dart';

class MediaEntity{
  late int _id;
  late String _url;
  late String _mediaName;
  late User _artist;
  late int _duration;
  late int _views;
  late int _type;

  MediaEntity({
    required int id,
    required String url,
    required String mediaName,
    required User artist,
    required int duration,
    required int views,
    required int type,
  }){
    _id = id;
    _url = url;
    _mediaName = mediaName;
    _artist = artist;
    _duration = duration;
    _views = views;
    _type = type;
  }

  int get id{
    return _id;
  }
  String get url{
    return _url;
  }
  String get name{
    return _mediaName;
  }
  User get artist{
    return _artist;
  }
  int get duration{
    return _duration;
  }
  int get views{
    return _views;
  }
  int get type{
    return _type;
  }



}