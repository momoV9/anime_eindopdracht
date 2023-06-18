import 'package:flutter/material.dart';
import '../components/player.dart';

void main() {
  runApp(AnimeMusicPage());
}

class AnimeMusicPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Music Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Anime Songs",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Player(),
      ),
    );
  }
}
