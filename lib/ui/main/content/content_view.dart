import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../content/icons.dart';
import '../../../data/models/artist_model.dart';
import '../../../data/models/media_model.dart';
import '../../../data/repository/data_repository.dart';
import '../../../styles.dart';
import 'artist_card.dart';
import 'media_card.dart';


class Content extends StatelessWidget{
  final String pageTitle;
  late int pageType;
  late DataRepository dataRepo;

  Content({required this.pageTitle, Key? key,}) : super(key: key){
    pageType = pageTitle == "Podcasts"? 0 : 1;
  }

  Future<List<Artist>> _getPopularArtists(){
    if (pageType == 0){
      return dataRepo.getPopularPodcastArtists();
    }
    return dataRepo.getPopularStandUpArtists() ;
  }

  Future<List<MediaEntity>> _getPopularShows(){
    if (pageType == 0){
      return dataRepo.getPopularPodcasts();
    }
    return dataRepo.getPopularStandUps();
  }

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 22, 38),
        fontFamily: "Open Sans",
      ),
      home: Scaffold(
        appBar: _appBar(pageTitle),
        body: SingleChildScrollView(
          child: _content(),
        ),
      ),
    );


  }

  AppBar _appBar(String pageTitle){
    return AppBar(
      elevation: 3,
      toolbarHeight: 80,
      backgroundColor: CommonStyle.mainColor(),
      title: Text(
        pageTitle,
        style: const  TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28,
            fontFamily: "OpenSans",
            color: Color.fromARGB(255, 255, 255, 255)
        ),
      ),
      actions: <Widget>[_profileButton()],
    );
  }


  Widget _profileButton(){
    return SizedBox(
      width: 50,
      height: 50,
      child: IconButton(
        onPressed: (){},
        icon: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 156, 160, 199),
          radius: 32,
          child: Icon(
            MyFlutterApp.account,
          ),
        ),
      ),
    );
  }

  Widget _content(){
    return Column(
      children: [
        _searchField("Artists or shows"),
        _popularArtists(),
        _popularShows(),
      ],
    );
  }

  Widget _searchField(String hint){
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 34),
      child: TextField(
        textInputAction: TextInputAction.search,
        style: CommonStyle.textFieldInputStyle(),
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          fillColor: CommonStyle.secondaryColor(),
          hintStyle: CommonStyle.descriptionTextStyle(),
          contentPadding: const EdgeInsets.fromLTRB(0, 13.5, 15, 13.5),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          prefixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(20, 11, 10, 11),
            child: Icon(
              Icons.search,
              color: Color.fromARGB(255, 133, 135, 159),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }


  Widget _popularArtists(){
    return Column(
      children: [
        _sectionTitle("Popular Artists"),
        _popularArtistsList(),
      ],
    );
  }


  Widget _sectionTitle(String title){
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 133, 135, 159),
          ),
        ),
      ),
    );
  }

  Widget _popularArtistsList(){
    List<Artist> popularArtists;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
      child: SizedBox(
        height: 125,
        child: FutureBuilder<List<Artist>>(
          future:_getPopularArtists(),
          builder: (BuildContext context, AsyncSnapshot<List<Artist>> snapshot) {
            if (snapshot.hasData){
              popularArtists = snapshot.data!;
              return ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  popularArtists.length, (index) {
                  Artist current = popularArtists[index];
                  return ArtistCard(artist: current);
                },
                ),
              );
            }
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _popularShows(){
    return Column(
      children: [
        _sectionTitle("Popular $pageTitle"),
        _popularShowsList(),
      ],
    );
  }

  Widget _popularShowsList(){
    List<MediaEntity> popularShows;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
      child: SizedBox(
        child: FutureBuilder<List<MediaEntity>>(
          future: _getPopularShows(),
          builder: (BuildContext context, AsyncSnapshot<List<MediaEntity>> snapshot) {
            if (snapshot.hasData){
              popularShows = snapshot.data!;
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  popularShows.length, (index) {
                  MediaEntity current = popularShows[index];
                  return MediaCard(media: current);
                },
                ),
              );
            }
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

}