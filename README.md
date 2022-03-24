# Angime Hub

## :scroll: Project description
Cross-platform streaming mobile application on Flutter. This app allows users to see stand-up shows and podcasts in one place.
You can download pre-release APK [here](https://github.com/seytkalievm/AngimeHub/releases/download/v1.0.0/AngimeHub.apk).

## :hammer: Building the project

To run app with server you need:
1. Start the server:
   - clone project from [gitlab](https://gitlab.com/DiazzzU/angimehubbackend)
   - to start database ```docker-compose up```
   - run main class ```AngimehubApplication```
2. Run flutter application with ```flutter run```


Building the application without server side:
- to build the authorization pages main.dart file should contain the following lines:
  ```
  import 'package:angime_hub/content/user_bottom.dart';
  import 'package:flutter/material.dart';

  void main() {
    runApp(const UserBottom());
  }

  ```
- to build the application from account page (and see content pages), main.dart should look like:
  ```
  import 'package:angime_hub/auth/authorization.dart';
  import 'package:flutter/material.dart';

  void main() {
    runApp(const Authorization());
  }

  ```

## :iphone: Screens and Features

Fisrt page where the user arrives - Sign in page. Server checks if the user is registered and if the password is correct and returns the answer.

 <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/emptySignIn.jpg" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/errorSignIn.jpg" width="200" height="400" />

There are two possibilities: sign in, if you already have account, or register in the app. During registration first and second names are checked to have only letters, passwords are checked to be same, email is checked to be in apropriate form. Server checks if the user with such email is already registered or not and returns the answer.

 <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/empryRegister.jpg" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/errorsRegister.jpg" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/errorRegister.jpg" width="200" height="400" />

The user profile page:

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/profile.jpg" width="200" height="400" />

If the registration / sign in step was successful user gets to the app.
App is navigated through bootom bar. There are three options: stand-up shows, podcasts and saved shows.
First two screen show popular shows and artist.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/standUp.jpg" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/Podcast.jpg" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/saved.jpg" width="200" height="400" />

Tapping on the show, the user gets into the page demonstrating it. For now video opens from stand-up and podcast pages, audio from saved page. The video / audio page can be closed by swipping down.

Video can be played / paused (by tapping on the center on the video), rewound back or forward on 5 seconds (by double tapping on the corresponding sides of the video), current state of the video can be changed with the use of progress indicator (timeline at the bottom of the video). The user also can restart the video (bottom left) ot change the orientation (bottom right).

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/videoStopped.jpg" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/videoPlayed.jpg" width="200" height="400" />

Audio can be played / paused, restarted. The speed of the audio also can be changed.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/audio.jpg" width="200" height="400" />

Demo of the app:

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/images/readme/demo.gif" width="200" height="400" />


## :tm: Contributors
- [Makshe Seytkaliev](https://github.com/seytkalievm)
- [Dias Usenov](https://github.com/diazzzu)
- [Dana Kabdullina](https://github.com/dannakk)
- [Kamila Khamidullina](https://github.com/Kamila-Khamidullina)
