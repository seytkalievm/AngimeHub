import 'package:angime_hub/data/models/search_result_model.dart';
import 'package:angime_hub/data/repository/data_repository.dart';
import 'package:angime_hub/ui/main/content/artist_card.dart';
import 'package:angime_hub/ui/main/content/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../content/icons.dart';
import '../../../data/models/artist_model.dart';
import '../../../data/models/media_card_model.dart';
import '../content/media_card.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  final String query;
  late DataRepository dataRepo;
  late SearchResult result;
  SearchPage({required this.query, Key? key}) : super(key: key);

  Future<SearchResult> getSearchResult() {
    return dataRepo.getSearchResult(query);
  }

  @override
  Widget build(BuildContext context) {
    dataRepo = context.read<DataRepository>();
    return Scaffold(
      appBar: appBar(
          context: context,
          pageTitle: "Search results",
          showProfileButton: false),
      body: FutureBuilder<SearchResult>(
        future: getSearchResult(),
        builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
          if (snapshot.hasData) {
            result = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  result.artists.isNotEmpty
                      ? _artists(result.artists)
                      : _empty(),
                  result.podcasts.isNotEmpty
                      ? _podcasts(result.podcasts)
                      : _empty(),
                  result.standUps.isNotEmpty
                      ? _standUps(result.standUps)
                      : _empty(),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _artists(List<Artist> artists) {
    return Column(
      children: [
        sectionTitle("Artists:"),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            artists.length,
            (index) {
              Artist current = artists[index];
              return ArtistCard(artist: current);
            },
          ),
        ),
      ],
    );
  }

  Widget _podcasts(List<MediaCardEntity> podcasts) {
    return Column(
      children: [
        sectionTitle("Podcasts:"),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            podcasts.length,
            (index) {
              MediaCardEntity current = podcasts[index];
              return MediaCard(
                mediaCardEntity: current,
                icon: MyFlutterApp.saved,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _standUps(List<MediaCardEntity> standUps) {
    return Column(
      children: [
        sectionTitle("StandUps:"),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            standUps.length,
            (index) {
              MediaCardEntity current = standUps[index];
              return MediaCard(
                mediaCardEntity: current,
                icon: MyFlutterApp.saved,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _empty() {
    return const Text(
      "",
    );
  }
}
