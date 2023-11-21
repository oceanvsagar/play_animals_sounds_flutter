import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LearnWithSounds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animal Images'),
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimalGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalGrid extends StatelessWidget {
  final List<String> animalImages = [
    'assets/cat.png',
    'assets/dog.png',
    'assets/elephant.png',
    'assets/lion.png',
    'assets/cow.png',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: animalImages.length,
      itemBuilder: (context, index) {
        return AnimalCard(imagePath: animalImages[index]);
      },
    );
  }
}

class AnimalCard extends StatelessWidget {
  final String imagePath;
  final AudioPlayer audioPlayer = AudioPlayer();

  AnimalCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: GestureDetector(
        onTap: () {
          _playAnimalSound(imagePath);
        },
        child: Column(
          children: [
            SizedBox(
              height: 150.0,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              _getAnimalName(imagePath),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _playAnimalSound(String imagePath) {
    String soundPath = '${_getAnimalName(imagePath)}.mp3';
    audioPlayer.play(AssetSource(soundPath));
    print('Sound played successfully');
  }

  String _getAnimalName(String imagePath) {
    String fileName = imagePath.split('/').last;
    return fileName.split('.').first;
  }
}
