import 'package:flutter/material.dart';
import 'meme.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mèmes créés')),
      body: savedMemes.isEmpty
          ? const Center(child: Text('Aucun mème'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: savedMemes.length,
              itemBuilder: (_, i) {
                final m = savedMemes[i];
                return AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(m.asset, fit: BoxFit.cover),
                      _memeText(m.top, Alignment.topCenter),
                      _memeText(m.bottom, Alignment.bottomCenter),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _memeText(String t, Alignment a) => Align(
        alignment: a,
        child: Text(
          t.toUpperCase(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
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
