import 'package:flutter/material.dart';

class Anime {
  final String title;
  final String summary;
  final String release;
  final double rating;
  final String imageUrl;

  Anime({
    required this.title,
    required this.summary,
    required this.release,
    required this.rating,
    required this.imageUrl,
  });
}

class AnimeDetailPage extends StatefulWidget {
  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  List<Anime> animeList = [
    Anime(
      title: 'Naruto',
      summary: 'Naruto follows the journey of Naruto Uzumaki, a young ninja who seeks recognition from his peers and dreams of becoming the Hokage, the leader of his village. Along the way, he faces numerous challenges, makes new friends, and discovers the truth about his past and the power within him.',
      release: '2002',
      rating: 4.7,
      imageUrl: 'https://www.crunchyroll.com/imgsrv/display/thumbnail/1200x675/catalog/crunchyroll/e6b2cd29a5ff62f4591d3b299007e24e.jpe',
    ),
    Anime(
      title: 'Dragon Ball Z',
      summary: 'Dragon Ball Z continues the story of Goku, a Saiyan warrior who protects the Earth from various threats. With the help of his friends, Goku battles powerful villains and embarks on epic adventures to defend the planet and the universe from destruction.',
      release: '1989',
      rating: 4.8,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQg6rRJATAks66d5dptyow4hnGh3wd4yCrEQ&usqp=CAU',
    ),
    Anime(
      title: 'One Piece',
      summary: 'One Piece follows Monkey D. Luffy, a young pirate with a stretchy body who sets out on a quest to find the ultimate treasure known as "One Piece" and become the Pirate King. Along his journey, he gathers a diverse crew of pirates and encounters dangerous enemies in the pursuit of his dream.',
      release: '1999',
      rating: 4.9,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX_-zAqLigQEpKzAQY4OaS5YHyWLdyXoXdhw&usqp=CAU',
    ),
    Anime(
      title: 'Bleach',
      summary: 'Bleach centers around Ichigo Kurosaki, a teenager with the ability to see ghosts. After obtaining the powers of a Soul Reaper, Ichigo becomes responsible for protecting the living world from malevolent spirits and guiding the souls of the deceased to the afterlife. As he battles supernatural threats, Ichigo uncovers dark secrets and faces formidable adversaries.',
      release: '2004',
      rating: 4.6,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQtKGt0LUW54jK4rxO5q_tLqpVPARENhw09Q&usqp=CAU',
    ),
    Anime(
      title: 'Solo Leveling',
      summary: 'Solo Leveling is a web novel turned manhwa that follows Sung Jin-Woo, an E-rank hunter who suddenly becomes the weakest link in humanity\'s fight against supernatural beings. However, after a mysterious incident grants him immense power, Sung Jin-Woo embarks on a journey to become the strongest hunter and uncover the secrets of the world.',
      release: '2018',
      rating: 4.5,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6NdXune2kp09mIi-gbhreAkQyarpyez76Tw&usqp=CAU',
    ),
    Anime(
      title: 'Demon Slayer',
      summary: 'Demon Slayer follows Tanjiro Kamado, a young boy who becomes a demon slayer after his family is brutally murdered by demons. Alongside his sister Nezuko, who has turned into a demon herself, Tanjiro joins the Demon Slayer Corps and embarks on a perilous quest to avenge his family and find a cure for his sister\'s condition.',
      release: '2019',
      rating: 4.7,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSByX797-Q8xeIcVxWNq65gk8tpT6J5whT7jg&usqp=CAU',
    ),
  ];
  String title = '';
  String summary = '';
  String release = '';
  String rating = '';
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Detail Page'),
      ),
      body: ListView.builder(
        itemCount: animeList.length,
        itemBuilder: (BuildContext context, int index) {
          final anime = animeList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(anime.title),
              subtitle: Text('Release: ${anime.release}'),
              onTap: () {
                openAnimeDetails(context, anime);
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewAnime(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void openAnimeDetails(BuildContext context, Anime anime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(anime.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(anime.imageUrl),
              const SizedBox(height: 16),
              Text('Summary: ${anime.summary}'),
              Text('Release: ${anime.release}'),
              Text('Rating: ${anime.rating}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void addNewAnime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Add New Anime'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          summary = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Summary',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          release = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Release',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Rating',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          imageUrl = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Anime newAnime = Anime(
                      title: title,
                      summary: summary,
                      release: release,
                      rating: double.parse(rating),
                      imageUrl: imageUrl,
                    );
                    setState(() {
                      animeList.add(newAnime);
                      title = '';
                      summary = '';
                      release = '';
                      rating = '';
                      imageUrl = '';
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AnimeDetailPage(),
  ));
}