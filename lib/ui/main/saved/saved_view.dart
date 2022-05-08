import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/media_card_model.dart';
import '../../../data/models/media_model.dart';
import '../../../data/models/user_model.dart';
import '../../../styles.dart';
import '../content/components.dart';

class SavedRecordingsView extends StatelessWidget {
  SavedRecordingsView({Key? key}) : super(key: key);
  late DataRepository dataRepo;

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return Scaffold(
        appBar: appBar(context: context, pageTitle: "Saved Recordings", showProfileButton: true),
        body: Column(
          children: [
            searchField("Artists or shows"),
            _savedRecordings(),
          ],
        ),
    );
  }

  Future<List<MediaCardEntity>> _getSavedRecordings()async{
    User user = await dataRepo.getUser();
    return dataRepo.getSavedRecordings(user.token);
  }
  
  Widget _savedRecordings(){
    return Column(
      children: [
        sectionTitle("Saved Stand-up shows and Podcasts"),
        showsList(showsFuture: _getSavedRecordings()),
      ],
    );
  }
}
