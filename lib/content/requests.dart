import '../data/models/artist_model.dart';
import '../data/models/media_model.dart';

List popularArtistsList() {
  List artists = [];
  artists.add({
    "name": "Alex",
    "photo":
        "https://yandex-images.clstorage.net/md100D363/fbcebapGsIDE/Rqtcv-XkNE-maOiXv7v92FMnZMLL_9RL0JeUVZ0_-gYZhQEE7S8KZxifq6VKbBbRZr87AofnpdbrJZSPovTBkGYKqF-R8VU6klxfgj-_WRymYsSn-j4RO7TGYSXcO36WbAPEwOwrz2Jd2Uslam3kI8SO3HEwgeIBidIwmtcRgZT37okcB3Al3fcKThWduPip8Ed3gjqL9TsScCc13Ap6hLt20zW9ia-DrXrOAz5ptPAFzn_BgxAzMzrCs_oG8vGV0G6KnzQVNa6XCt9m7lmKWzNFJFO66rUpocOVVp7IWiQ7xcGlLijtsa4q7iMdmfSwF55vUnFjkiBoMoIZlrMgtPJP2Xx3BpYepMrfVA0a-KnSZ7Zh-yukyINDJUcf25nGmCWiBmxqjkDPeT5S7GtE4gQsLOKC0lIiuSGymNVAgbXijcnPlMelTYfqXpctKduLcDc2oApKtDihkCbl3_o4xcrEgBSNONxBrcr-oF0Yt7N0_o7wkwHCI7hSwmlk0ZL2IC3pTHek9A6VeO0nfNqZa7H3phAKCUbYo0OmxGxIeIT4dfDHnrkuMz9bzpBtK5XAFe-M49LiodM5sXO7pwMAh1FMK0739sVM1gmcxjy7WpuTt9WCGBhmiUGS9TeOmelV2abh5U6anCBfKx7iX_inQEftb_NC8pKhW7HSSfaj8UZAfqqc5ZdUDhZbDCQN20m58pU30_nb5PvBA9WE_wqI1unHw_TdOx5wzKrcQM951XK2D_6gMDGQoqohw2qHcIOX0V3YbUWWRF6HKn_WzQvYSaNVtiAY2wQKIROGB194CyY5hXFXTLlNgM_rLbLOG4RyBEw8M_CRUEGro6NJhPLh9OAuqe0H5RfOx9sON81I6LtRxrcAGDv026LgdRVcCrtk2GawFk6annOMCy-jbkqHIxS-XyOgokBS6xPjWUbRkzcgrCjP5qQHrQeLjhUMqYq58mVFsrpJlDuxcaZ0w"
  });
  artists.add({
    "name": "Ivan",
    "photo":
        "https://mysplash.ru/uploads/afisha/xp/js/2955acf04ed77b035c7c586c5d5787dc-600x600.jpg"
  });
  artists.add({
    "name": "Evgen",
    "photo":
        "https://musclub.ru/preview/107300aa5d88698549393d48ec3371be/c/600x600/data/catalog/e/6/b/e6b96f1612c58f4f374a7410876e94e1.jpeg"
  });
  artists.add({
    "name": "Yulia",
    "photo":
        "https://st18.styapokupayu.ru/images/blog_posts/covers/000/237/693_large.jpg?1552995110"
  });
  artists.add({
    "name": "Arthur",
    "photo":
        "https://uchastniki.com/wp-content/uploads/2019/07/Artur-CHaparyan3-e1562058520246.jpg"
  });
  artists.add({
    "name": "Ivan",
    "photo":
        "https://yt3.ggpht.com/a/AATXAJz4qQxGaCskk-L9mFLrBFvXl13-n08rLU7MM65-=s900-c-k-c0xffffffff-no-rj-mo"
  });
  return artists;
}

List popularShowsList() {
  List shows = [];
  shows.add({
    "name": "About trips",
    "artist": "Sergey",
    "duration": "22min",
    "photo":
        "https://www.2do2go.ru/uploads/1c6d6afcf3f45972a2f4bd02f8fcce84.jpg"
  });
  shows.add({
    "name": "Adult",
    "artist": "Irina",
    "duration": "38min",
    "photo": "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg"
  });
  shows.add({
    "name": "Clean",
    "artist": "Slava",
    "duration": "59min",
    "photo":
        "https://phonoteka.org/uploads/posts/2021-04/1618575494_30-phonoteka_org-p-stendap-fon-36.jpg"
  });
  shows.add({
    "name": "Adult",
    "artist": "Max",
    "duration": "38min",
    "photo": "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg"
  });
  shows.add({
    "name": "Clean",
    "artist": "Slava",
    "duration": "59min",
    "photo": "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg"
  });
  return shows;
}

Artist a1 = Artist(
  id: 1,
  firstName: "Surlan",
  secondName: "Naburov",
  profilePic: "https://www.topnews.ru/wp-content/uploads/2022/04/Sabyrov.jpeg",
);
Artist a2 = Artist(
  id: 2,
  firstName: "Mambi",
  secondName: "Tasaev",
  profilePic:
      "https://i.pinimg.com/736x/2e/77/68/2e77683dbbdff0d7c32055f32652fb7e.jpg",
);
Artist a3 = Artist(
  id: 3,
  firstName: "Hevin",
  secondName: "Kart",
  profilePic:
      "https://media.newyorker.com/photos/5cb7a0e992dcf02ddc8613c2/master/pass/DSF-KevinHartSpecial.jpg",
);
Artist a4 = Artist(
  id: 4,
  firstName: "Couis",
  secondName: "L.K",
  profilePic:
      'https://static01.nyt.com/images/2019/11/05/arts/04louis-ck/04louis-ck-superJumbo.jpg',
);
Artist a5 = Artist(
  id: 5,
  firstName: "Ris",
  secondName: "Chrock",
  profilePic: 'https://i.ytimg.com/vi/hvAu7L0Ii2M/maxresdefault.jpg',
);
Artist a6 = Artist(
  id: 6,
  firstName: "Ceorge",
  secondName: "Garlin",
  profilePic:
      'https://upload.wikimedia.org/wikipedia/commons/2/2e/Jesus_is_coming.._Look_Busy_%28George_Carlin%29.jpg',
);
Artist a7 = Artist(
  id: 7,
  firstName: "Chave",
  secondName: "Dapelle",
  profilePic:
      "https://static.onecms.io/wp-content/uploads/sites/9/2017/06/fwx-dave-chappelle.jpg",
);

MediaEntity show1 = MediaEntity(
  id: 1,
  url: "https://www.2do2go.ru/uploads/1c6d6afcf3f45972a2f4bd02f8fcce84.jpg",
  preview: "https://www.2do2go.ru/uploads/1c6d6afcf3f45972a2f4bd02f8fcce84.jpg",
  mediaName: "About trips",
  artist: a1,
  views: 820,
  duration: 22,
  type: 0,
);

MediaEntity show2 = MediaEntity(
  id: 2,
  url: "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg",
  preview: "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg",
  mediaName: "Adult",
  artist: a2,
  views: 230,
  duration: 38,
  type: 0,
);

MediaEntity show3 = MediaEntity(
  id: 3,
  url:
      "https://phonoteka.org/uploads/posts/2021-04/1618575494_30-phonoteka_org-p-stendap-fon-36.jpg",
  preview:
      "https://phonoteka.org/uploads/posts/2021-04/1618575494_30-phonoteka_org-p-stendap-fon-36.jpg",
  mediaName: "Clean",
  artist: a3,
  views: 120,
  duration: 59,
  type: 0,
);

MediaEntity show4 = MediaEntity(
  id: 4,
  url: "https://storage.yandexcloud.net/angimehub/asdasd.mp3",
  preview: "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg",
  mediaName: "Principles",
  artist: a4,
  views: 240,
  duration: 43,
  type: 1,
);

MediaEntity show5 = MediaEntity(
  id: 5,
  url: "https://storage.yandexcloud.net/angimehub/asdasd.mp3",
  preview: "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg",
  mediaName: "Adult",
  artist: a5,
  views: 235,
  duration: 54,
  type: 1,
);

MediaEntity show6 = MediaEntity(
  id: 6,
  url: "https://storage.yandexcloud.net/angimehub/asdasd.mp3",
  preview: "https://www.teatr-benefis.ru/wp-content/uploads/2021/08/1-2.jpg",
  mediaName: "Kuji",
  artist: a6,
  views: 132,
  duration: 67,
  type: 1,
);

List<Artist> getStandUpArtists() {
  return [a1, a2, a3, a4];
}

List<Artist> getPodcastArtists() {
  return [a7, a6, a5, a4];
}

List<MediaEntity> getStandUps() {
  return [show1, show2, show3];
}

List<MediaEntity> getPodcasts() {
  return [show4, show5, show6];
}
