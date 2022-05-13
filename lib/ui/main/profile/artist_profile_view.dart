import 'package:angime_hub/content/icons.dart';
import 'package:angime_hub/data/models/user_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/media_card_model.dart';
import '../upload/upload_recording_view.dart';

class ArtistProfilePage extends StatelessWidget {
  late final DataRepository dataRepo;
  late final SessionCubit sessionCubit;
  final User user;

  // ignore: prefer_const_constructors_in_immutables
  ArtistProfilePage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    sessionCubit = context.read<SessionCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        context: context,
        pageTitle: "My Profile",
        showProfileButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _info(),
            _buttons(context),
            _recordings(),
          ],
        ),
      ),
    );
  }

  Future<List<MediaCardEntity>> _getMyRecordings() {
    return dataRepo.getUserRecordings(user.token);
  }

  Widget _info() {
    return Column(
      children: [
        _photo(),
        _contacts(),
      ],
    );
  }

  Widget _photo() {
    return Container(
      height: 48,
      width: 48,
      margin: const EdgeInsets.only(bottom: 16, top: 16),
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 156, 160, 199),
        radius: 100,
        child: Icon(
          MyFlutterApp.account,
          size: 32,
        ),
      ),
    );
  }

  Widget _contacts() {
    String name = user.firstName + " " + user.secondName;
    String email = user.email;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 26),
      child: Center(
        child: Column(
          children: [_name(name: name), _email(email: email), _artist()],
        ),
      ),
    );
  }

  Widget _name({String name = 'name'}) {
    return Text(
      name,
      style: const TextStyle(
        fontFamily: "OpenSans",
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  Widget _email({String email = 'email'}) {
    return Text(
      email,
      style: const TextStyle(
        fontFamily: "OpenSans",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  Widget _artist() {
    return const Text(
      "Artist",
      style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 11, 191, 184),
      ),
    );
  }

  Widget _recordings() {
    return Column(
      children: [
        sectionTitle("My Recordings"),
        showsListForArtist(showsFuture: _getMyRecordings())
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Row(
        children: [
          Expanded(
            child: _signOut(),
          ),
          Expanded(
            child: _uploadRecording(context),
          ),
        ],
      ),
    );
  }

  Widget _uploadRecording(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
            return UploadRecordingPage(user: user);
          }));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 11, 191, 184)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Upload",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Open Sans",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _signOut() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          sessionCubit.signOut();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 156, 160, 199)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Text(
          "Sign Out",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Open Sans",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
