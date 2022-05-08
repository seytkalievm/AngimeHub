import 'package:angime_hub/data/models/user_model.dart';

class Artist{
  final int id;
  final String firstName;
  final String secondName;
  final String profilePic;

  Artist({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.profilePic,
  });

  @override
  String toString() {
    return "$firstName $secondName";
  }
}