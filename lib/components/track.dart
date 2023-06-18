import 'package:flutter/material.dart';

class Track {
  String title;

  String album;
  String genre;
  Image? artwork = null;
  String? file;
  bool isPlaying = false;
  bool hasStarted = false;

  Track(this.title, this.album, this.genre);

  void setArtworkByFile(String artworkFile) {
    artwork = Image.asset(artworkFile);
  }

  void setFile(String filepath) {
    file = filepath;
  }

  void play() {
    hasStarted = true;
    isPlaying = true;
  }

  void pause() {
    isPlaying = false;
  }

  void stop() {
    hasStarted = false;
    isPlaying = false;
  }
}
