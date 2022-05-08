import 'package:file_picker/file_picker.dart';
import '../../../data/models/user_model.dart';

class UploadEntity{
  late final PlatformFile _preview;
  late final PlatformFile _media;
  late final String _mediaName;
  late final User _user;
  late final int _type;

  UploadEntity({
    required PlatformFile preview,
    required PlatformFile media,
    required String mediaName,
    required User user,
    required int type,
  }){
    _preview = preview;
    _media = media;
    _mediaName = mediaName;
    _user = user;
    _type = type;
  }

  PlatformFile get preview{
    return _preview;
  }

  PlatformFile get media{
    return _media;
  }

  String get mediaName{
    return _mediaName;
  }

  User get user {
    return _user;
  }

  int get type{
    return _type;
  }
}