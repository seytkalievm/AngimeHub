import 'package:angime_hub/data/models/user_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:angime_hub/ui/main/profile/become_artist_view.dart';
import 'package:angime_hub/ui/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../content/icons.dart';


class ProfilePage extends StatelessWidget {
  late DataRepository dataRepo;
  late SessionCubit sessionCubit;

  ProfilePage({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _info(),
            _becomeArtist(context),
            _signOut(),
          ],
        ),
      ),
    );
  }

  Future<User> getUser() async {
    final user = await dataRepo.getUser();
    return user;
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
      margin: const EdgeInsets.only(bottom: 16),
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
    String name;
    String email;
    return FutureBuilder<User>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          name = snapshot.data!.firstName + " " + snapshot.data!.secondName;
          email = snapshot.data!.email;
          return Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 72),
            child: Center(
              child: Column(children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(email,
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _becomeArtist(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (context){
            return BecomeArtistPage();
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
          "Become an Artist",
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
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
