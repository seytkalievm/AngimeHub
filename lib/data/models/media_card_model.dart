class MediaCardEntity{
  final String mediaUrl;
  final String previewUrl;
  final String mediaName;
  final int mediaId;
  final String artistFirstName;
  final String artistSecondName;
  final int type;

  MediaCardEntity({
    required this.mediaUrl,
    required this.previewUrl,
    required this.mediaName,
    required this.mediaId,
    required this.artistFirstName,
    required this.artistSecondName,
    required this.type,
  });


  static MediaCardEntity fromJson(Map<String, Object?> json) =>
      MediaCardEntity(
        mediaId: json["idVideo"] as int,
        mediaUrl: json["urlVideo"] as String,
        previewUrl: json["urlImage"] as String,
        mediaName: json["mediaName"] as String,
        artistFirstName: json["artistFirstName"] as String,
        artistSecondName: json["artistSecondName"] as String,
        type: json["type"] as int,
      );

}