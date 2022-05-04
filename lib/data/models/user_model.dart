import 'package:angime_hub/data/models/media_model.dart';

const String userTable = 'user';

class UserFields {
  static const String id = '_id';
  static const String firstName = "firstName";
  static const String secondName = "secondName";
  static const String email = "email";
  static const List<String> all = [id, firstName, secondName, email];
}

class User {
  final int? id;
  late String _firstName;
  late String _secondName;
  late String _email;
  late String? _profilePic;
  List<MediaEntity> _medias = <MediaEntity>[];

  User({
    this.id,
    required String firstName,
    required String secondName,
    required String email,
    String? profilePic,
  }) {
    _firstName = firstName;
    _secondName = secondName;
    _email = email;
    _profilePic = profilePic;
  }

  String get firstName {
    return _firstName;
  }

  String get secondName {
    return _secondName;
  }

  String get email {
    return _email;
  }

  List<MediaEntity> get medias {
    return _medias;
  }

  void addMedia(MediaEntity media) {
    _medias.add(media);
  }

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.firstName: _firstName,
        UserFields.secondName: _secondName,
        UserFields.email: _email,
      };

  User copyWith({
    int? id,
    String? firstName,
    String? secondName,
    String? email,
    String? profilePic,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? _firstName,
        secondName: secondName ?? _secondName,
        email: email ?? _email,
        profilePic: profilePic ?? _profilePic,
      );

  static User fromJson(Map<String, Object?> json) => User(
      firstName: json[UserFields.firstName] as String,
      secondName: json[UserFields.secondName] as String,
      email: json[UserFields.email] as String);
}
