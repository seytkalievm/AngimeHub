import 'media_card_model.dart';

class Artist{
  final int id;
  final String firstName;
  final String secondName;
  final String profilePic;
  List<MediaCardEntity> standUps = [];
  List<MediaCardEntity> podcasts = [];

  Artist({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.profilePic,
    List<MediaCardEntity>? standUps,
    List<MediaCardEntity>? podcasts,
  }){
    if (standUps!=null){
      this.standUps = standUps;
    }
    if(podcasts!=null){
      this.podcasts = podcasts;
    }
  }

  @override
  String toString() {
    return "$firstName $secondName";
  }

  Artist copyWith(
      int id,
      String firstName,
      String secondName,
      String profilePic,
      List<MediaCardEntity>? standUps,
      List<MediaCardEntity>? podcasts,
      ){
    return Artist(
        id: id,
        firstName: firstName,
        secondName: secondName,
        profilePic: profilePic,
        standUps: standUps?? this.standUps,
        podcasts: podcasts?? this.standUps,
    );
  }

  static Artist fromJson(
      Map<String, Object?> json,
      List<MediaCardEntity>? standUps,
      List<MediaCardEntity>? podcasts,
      ) {
    return Artist(
      id: json["artistId"] as int,
      firstName: json["artistFirstName"] as String,
      secondName: json["artistSecondName"] as String,
      profilePic: json["profileImage"] as String,
      standUps: standUps,
      podcasts: podcasts,
    );
  }
}