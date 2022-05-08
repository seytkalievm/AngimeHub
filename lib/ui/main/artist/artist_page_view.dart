import 'package:angime_hub/data/models/media_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/styles.dart';
import 'package:angime_hub/ui/main/artist/artist_all_shows.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../content/icons.dart';
import '../../../data/models/artist_model.dart';
import '../../../data/models/media_card_model.dart';
import '../content/media_card.dart';


class ArtistPage extends StatefulWidget{

  final Artist artist;

  const ArtistPage({required this.artist, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArtistPageState();
  }

}
class _ArtistPageState extends State<ArtistPage> {
  late DataRepository dataRepo;

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return FutureBuilder<Artist>(
      future: _getFullArtistInfo(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return _body(context, snapshot.data!);
        }
        return const CircularProgressIndicator();
      },
    );

  }

  Future<Artist> _getFullArtistInfo() async{
    return await dataRepo.getArtistInfo(widget.artist.id);
  }

  Widget _body(BuildContext context, Artist newArtist){
    bool hasStandUps = newArtist.standUps.isNotEmpty;
    bool hasPodcasts = newArtist.podcasts.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        context: context,
        pageTitle: "About an Artist",
        showProfileButton: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _info(newArtist),
              hasPodcasts?_popularsBlock(newArtist, type: "Podcasts"):_noShows(),
              hasStandUps?_popularsBlock(newArtist, type: "Stand-Ups"):_noShows(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noShows(){
    return const Text(
      "",
    );
  }

  Widget _info(Artist newArtist) {
    return Column(
      children: [
        _photo(newArtist),
        _name(newArtist),
      ],
    );
  }

  Widget _photo(Artist newArtist) {
    return Container(
        height: 90,
        width: 90,
        margin: const EdgeInsets.only(bottom: 16, top: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            newArtist.profilePic,
            height: 90,
            width: 90,
          ),
        ));
  }

  Widget _name(Artist newArtist) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        newArtist.toString(),
        style: const TextStyle(
          fontFamily: "OpenSans",
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }

  Widget _popularsBlock(Artist newArtist, {required String type}) {
    return Column(
      children: [
        _heading(newArtist, type: type),
        _showShows(newArtist, type: type),
      ],
    );
  }

  Widget _showShows(Artist newArtist,{required String type}){
    List <MediaCardEntity> shows =
                        type == "Podcasts"? newArtist.podcasts : newArtist.standUps;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        shows.length > 3? 3 : shows.length,
            (index) {
          MediaCardEntity current = shows[index];
          return MediaCard(
            mediaCardEntity: current,
            icon: MyFlutterApp.saved,
          );
        },
      ),
    );
  }


  Widget _heading(Artist newArtist, {required String type}) {
    int showType = type == "Podcasts"? 1:0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sectionTitle("Popular $type"),
        Row(
          children: [
            _showAll(showType, newArtist),
            _iconShow(newArtist),
          ],
        ),
      ],
    );
  }

  Widget _showAll(int type, Artist newArtist) {
    var shows = type==1?newArtist.podcasts:newArtist.standUps;
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: const Text(
          "Show All",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) {
            return AllShows(shows: shows, type: type);
          }),
        );
      },
    );
  }

  Widget _iconShow(Artist newArtist) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}
