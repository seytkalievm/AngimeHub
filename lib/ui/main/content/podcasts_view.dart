import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/artist_model.dart';
import '../../../data/models/media_model.dart';
import '../../../data/repository/data_repository.dart';
import '../../../styles.dart';


class PodcastsPage extends StatelessWidget{
  PodcastsPage({Key? key}) : super(key: key);

  late DataRepository dataRepo;

  Future<List<Artist>> _getPopularArtists(){
    return dataRepo.getPopularPodcastArtists();
  }

  Future<List<MediaEntity>> _getPopularShows(){
    return dataRepo.getPopularPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return Scaffold(
        appBar: appBar(context: context, pageTitle: "Podcasts", showProfileButton: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              searchField("Artists or Shows"),
              _popularArtists(),
              _popularShows(),
            ],
          ),
        ),

    );
  }

  Widget _popularArtists(){
    return Column(
      children: [
        sectionTitle("Popular Artists"),
        artistsList(artistsFuture: _getPopularArtists()),
      ],
    );
  }

  Widget _popularShows(){
    return Column(
      children: [
        sectionTitle("Popular Podcasts"),
        showsList(showsFuture: _getPopularShows())
      ],
    );
  }

}