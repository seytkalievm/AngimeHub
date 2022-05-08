import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/media_card_model.dart';
import '../../../data/models/media_model.dart';
import '../../../data/models/user_model.dart';
import '../../../styles.dart';
import '../content/components.dart';


class SavedRecordingsView extends StatefulWidget {
  SavedRecordingsView({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _SavedRecordingsViewState();
  }

}
class _SavedRecordingsViewState extends State<SavedRecordingsView>{
  late DataRepository dataRepo;
  late Future<List<MediaCardEntity>> saved;

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return Scaffold(
        appBar: appBar(context: context, pageTitle: "Saved Recordings", showProfileButton: true),
        body: SingleChildScrollView(
        child: Column(
          children: [
            searchField("Artists or shows"),
            _savedRecordings(),
          ],
        ),
        ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    _getSavedRecordings();
  }

  Future<List<MediaCardEntity>> _getSavedRecordings()async{
    User user = await dataRepo.getUser();
    saved = dataRepo.getSavedRecordings(user.token);
    return saved;
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
