import 'package:flutter/material.dart';
import 'meme.dart';

// Page qui affiche les mèmes sauvegardés
class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mèmes créés')),
      body: savedMemes.isEmpty
          ? const Center(child: Text('Aucun mème sauvegardé'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: savedMemes.length,
              itemBuilder: (_, i) {
                final m = savedMemes[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(m.asset, fit: BoxFit.cover),
                        _memeText(m.top, Alignment.topCenter),
                        _memeText(m.bottom, Alignment.bottomCenter),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Style du texte du mème
  Widget _memeText(String t, Alignment a) => Align(
        alignment: a,
        child: Text(
          t.toUpperCase(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(offset: Offset(-1, -1), color: Colors.black),
              Shadow(offset: Offset(1, -1), color: Colors.black),
              Shadow(offset: Offset(1, 1), color: Colors.black),
              Shadow(offset: Offset(-1, 1), color: Colors.black),
            ],
          ),
        ),
      );
}
