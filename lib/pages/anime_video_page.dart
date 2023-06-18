import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnimeVideoPage extends StatefulWidget {
  const AnimeVideoPage({Key? key}) : super(key: key);

  @override
  _AnimeVideoPageState createState() => _AnimeVideoPageState();
}

class _AnimeVideoPageState extends State<AnimeVideoPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  final StreamController<bool> _videoPlaybackStreamController =
  StreamController<bool>.broadcast();

  Stream<bool>? _videoPlaybackStream;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();

    _iconAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeInOut,
    );

    _iconAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _iconAnimationController.dispose();
    _videoPlaybackStreamController.close();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/trailer.mp4');
    await _videoPlayerController.initialize();
    _videoPlayerController.addListener(_videoPlayerListener);

    _videoPlaybackStream = _videoPlaybackStreamController.stream;
    setState(() {});
  }

  void _videoPlayerListener() {
    final isPlaying = _videoPlayerController.value.isPlaying;
    if (_isVideoPlaying != isPlaying) {
      _isVideoPlaying = isPlaying;
      _videoPlaybackStreamController.add(_isVideoPlaying);
    }
  }

  void _toggleVideoPlayback() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _iconAnimationController.reverse();
    } else {
      _videoPlayerController.play();
      _iconAnimationController.forward();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Video Page'),
      ),
      body: _videoPlayerController != null &&
          _videoPlayerController.value.isInitialized
          ? Column(
        children: [
          Card(
            elevation: 4,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(_videoPlayerController),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: StreamBuilder(
                      stream: Stream.periodic(
                          const Duration(milliseconds: 500)),
                      builder: (context, snapshot) {
                        final currentPosition =
                            _videoPlayerController.value.position;
                        final totalDuration =
                            _videoPlayerController.value.duration;
                        return Text(
                          _formatDuration(currentPosition) +
                              ' / ' +
                              _formatDuration(totalDuration),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Anime Title',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Episode 1',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Here is a standoff between the final fight between naruto uzumaki and sasuke uchiha',

              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder<bool>(
            stream: _videoPlaybackStream,
            initialData: false,
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return GestureDetector(
                onTap: _toggleVideoPlayback,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: AnimatedIcon(
                      icon: isPlaying
                          ? AnimatedIcons.pause_play
                          : AnimatedIcons.play_pause,
                      progress: _iconAnimation,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      )
          : Container(),
    );
  }
}
