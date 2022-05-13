import 'package:angime_hub/data/models/artist_model.dart';
import 'package:angime_hub/data/models/media_card_model.dart';

class SearchResult{
  List<Artist> artists = [];
  List<MediaCardEntity> standUps = [];
  List<MediaCardEntity> podcasts = [];

  SearchResult({artists, standUps, podcasts,}){
    if(artists != null){
      this.artists = artists;
    }
    if(standUps != null){
      this.standUps = standUps;
    }
    if(podcasts != null){
      this.podcasts = podcasts;
    }
  }

}