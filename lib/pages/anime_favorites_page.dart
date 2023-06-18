import 'package:flutter/material.dart';
import 'data/feedback_database.dart';
import 'models/feedback_entry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Feedback App',
      theme: ThemeData(
        colorScheme: ThemeData.light().colorScheme.copyWith(
          secondary: Colors.orange, 
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AnimeFavoritesPage(),
    );
  }
}

class Anime {
  final String title;
  final String summary;

  Anime({required this.title, required this.summary});
}

class AnimeFavoritesPage extends StatelessWidget {
  final List<Anime> animeList = [
    Anime(
      title: 'Naruto',
      summary: 'A young ninja strives to become the strongest ninja in his village.',
    ),
    Anime(
      title: 'One Piece',
      summary: 'A pirate sets out on a journey to find the ultimate treasure and become the Pirate King.',
    ),
    Anime(
      title: 'Bleach',
      summary: 'A high school student gains the powers of a Soul Reaper and battles evil spirits.',
    ),
    Anime(
      title: 'Blue Lock',
      summary: 'A talented soccer player joins a specialized training program to become the world\'s best striker.',
    ),
    Anime(
      title: 'Demon Slayer',
      summary: 'A young boy becomes a demon slayer and seeks revenge for his family.',
    ),
    Anime(
      title: 'One Punch Man',
      summary: 'A superhero with unbeatable strength seeks a worthy opponent.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary, // Use the accent color as the app bar background
        title: const Text('Anime Favorites Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: animeList.length,
          itemBuilder: (context, index) {
            final anime = animeList[index];
            return Card(
              child: ExpansionTile(
                title: Text(anime.title),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(anime.summary),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _openAnimeDetails(context, anime.title, context);
                    },
                    child: const Text('Leave Feedback'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary, // Use the accent color as the button background
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedbackListPage()),
          );
        },
        child: const Icon(Icons.list),
      ),
    );
  }

  void _openAnimeDetails(BuildContext context, String animeTitle, BuildContext favoritePageContext) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimeDetailsPage(animeTitle: animeTitle, favoritePageContext: favoritePageContext),
      ),
    );
  }
}

class AnimeDetailsPage extends StatefulWidget {
  final String animeTitle;
  final BuildContext favoritePageContext;

  const AnimeDetailsPage({required this.animeTitle, required this.favoritePageContext, Key? key}) : super(key: key);

  @override
  _AnimeDetailsPageState createState() => _AnimeDetailsPageState();
}

class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  double rating = 0;
  String feedback = '';

  void _submitFeedback(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final entry = FeedbackEntry(
      id: DateTime.now().millisecondsSinceEpoch,
      rating: rating,
      feedback: feedback,
    );

    await FeedbackDatabase.instance.createFeedbackEntry(entry);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rating: $rating'),
            const SizedBox(height: 10),
            Text('Feedback: $feedback'),
          ],
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );

    Navigator.pop(widget.favoritePageContext);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary, // Use the accent color as the app bar background
        title: const Text('Anime Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.animeTitle}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Rating: $rating',
              style: const TextStyle(fontSize: 16),
            ),
            Slider(
              value: rating,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Feedback:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  feedback = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Write your feedback...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _submitFeedback(context);
              },
              child: const Text('Submit Feedback'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary, // Use the accent color as the button background
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackListPage extends StatelessWidget {
  const FeedbackListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary, // Use the accent color as the app bar background
        title: const Text('Feedback List'),
      ),
      body: FutureBuilder<List<FeedbackEntry>>(
        future: FeedbackDatabase.instance.getAllFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final feedbacks = snapshot.data!;
            return ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = feedbacks[index];
                return ListTile(
                  title: Text('Rating: ${feedback.rating}'),
                  subtitle: Text('Feedback: ${feedback.feedback}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
