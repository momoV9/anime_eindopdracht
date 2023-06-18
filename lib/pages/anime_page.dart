import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimePage extends StatelessWidget {
  final List<String> animeImages = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
    'image4.jpg',
    'image5.jpg',
    'image6.jpg',
    'image7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN6OH_TGZ_af8nu2gcYbY1c1en7y501Yi9Mg&usqp=CAU',
    'https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/9b22fdc9b3c0a5e0c6373adba8b7ac61.jpe',
    // Add more image URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.purple.shade200],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Anime Page!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Anime is a form of entertainment that originated in Japan and has gained immense popularity worldwide. It encompasses a wide range of genres, including action, romance, fantasy, and more. Explore a collection of amazing anime images below. Tap on an image to view it in detail.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: CarouselSlider.builder(
                itemCount: animeImages.length,
                itemBuilder: (context, index, realIndex) {
                  final imagePath = animeImages[index];
                  if (imagePath.startsWith('http')) {
                    return GestureDetector(
                      onTap: () {
                        _openImage(context, imagePath);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: imagePath,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        _openImage(context, imagePath);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/$imagePath',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                },
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Dialog(
            child: Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: _isNetworkImage(imagePath)
                  ? CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
                  : Image.asset(
                'assets/images/$imagePath',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
  bool _isNetworkImage(String imagePath) {
    return imagePath.startsWith('http') || imagePath.startsWith('https');
  }

}
