import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/main/profile/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import 'artist_profile_view.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }

}

class _ProfilePageState extends State<ProfilePage>{

  late DataRepository dataRepo;

  Future<User> getUser() async {
    final user = await dataRepo.getUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return FutureBuilder<User>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.role == "simple user"){
              return UserProfilePage(user: snapshot.data!);
            }else{
              return ArtistProfilePage(user: snapshot.data!);
            }
          }
          return const CircularProgressIndicator();
        }
    );
  }

}