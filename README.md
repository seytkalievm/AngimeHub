# Angime Hub

## :scroll: Project description
Cross-platform streaming mobile application on Flutter. This app allows users to see stand-up shows and podcasts in one place.
You can download pre-release APK [here](https://github.com/seytkalievm/AngimeHub/releases/download/v1.0.0/AngimeHub.apk).

## :hammer: Building the project

To run app with server you need:
1. Run flutter application with ```flutter run```


## :iphone: Screens and Features

Fisrt page where the user arrives - Sign in page. Server checks if the user is registered and if the password is correct and returns the answer.
There are two possibilities: sign in, if you already have account, or register in the app. During registration first and second names are checked to have only letters, passwords are checked to be same, email is checked to be in apropriate form. Server checks if the user with such email is already registered or not and returns the answer.

 <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/login.png" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/register.png" width="200" height="400" />

If the registration / sign in step was successful user gets to the app.
The user profile page:

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/profile.png" width="200" height="400" />

App is navigated through bootom bar. There are three options: stand-up shows, podcasts and saved shows.
First two screen show popular shows and artist.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/standups.png" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/podcasts.png" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/saved.png" width="200" height="400" />

Tapping on the show, the user gets into the page demonstrating it. For now video opens from stand-up and podcast pages, audio from saved page. The video / audio page can be closed by swipping down.

Video can be played / paused (by tapping on the center on the video), rewound back or forward on 5 seconds (by double tapping on the corresponding sides of the video), current state of the video can be changed with the use of progress indicator (timeline at the bottom of the video). The user also can restart the video (bottom left) ot change the orientation (bottom right).
Audio can be played / paused, restarted. The speed of the audio also can be changed.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/video.png" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/audio.png" width="200" height="400" />

Simple user can become an artist to be able to upload his recordings.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/become_artist.png" width="200" height="400" />

Uploading recording.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/upload.png" width="200" height="400" /> <img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/apload2.png" width="200" height="400" />

After that the artist can see his recordings on his page.

<img src="https://github.com/seytkalievm/AngimeHub/blob/master/assets/screens/myrecordings.png" width="200" height="400" />


## :tm: Contributors
- [Makshe Seytkaliev](https://github.com/seytkalievm)
- [Dias Usenov](https://github.com/diazzzu)
- [Dana Kabdullina](https://github.com/dannakk)
- [Kamila Khamidullina](https://github.com/Kamila-Khamidullina)
