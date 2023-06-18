import 'package:flutter/material.dart';
import 'package:anime/authentication/login_page.dart';
import 'package:anime/pages/anime_detail_page.dart';
import 'package:anime/pages/anime_favorites_page.dart';
import 'package:anime/pages/anime_page.dart';
import 'package:anime/pages/anime_video_page.dart';
import 'package:anime/pages/anime_music_page.dart';
import 'package:anime/pages/quiz_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AnimePage(),
    AnimeFavoritesPage(),
    AnimeDetailPage(),
    AnimeMusicPage(),
    AnimeVideoPage(),
    QuizPage(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blue.shade900,

      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.details),
              label: 'Detail',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
