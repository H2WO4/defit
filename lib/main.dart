import 'package:flutter/material.dart';

void main() => runApp(const MemeApp());

class MemeApp extends StatelessWidget {
  const MemeApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MemeMakerPage(),
      );
}

class Meme {
  final String asset;
  final String top;
  final String bottom;
  Meme(this.asset, this.top, this.bottom);
}

class MemeMakerPage extends StatefulWidget {
  const MemeMakerPage({super.key});
  @override
  State<MemeMakerPage> createState() => _MemeMakerPageState();
}

class _MemeMakerPageState extends State<MemeMakerPage> {
  // mets ici les fichiers de ton dossier img/
  static const gallery = [
    'img/a7mwmr.jpg',
    'img/a7mwq2.jpg',
    'img/a7mwqx.jpg',
  ];

  String selected = gallery.first;
  final topCtrl = TextEditingController(text: 'TOP TEXT');
  final bottomCtrl = TextEditingController(text: 'BOTTOM TEXT');
  final List<Meme> memes = [];

  @override
  void dispose() {
    topCtrl.dispose();
    bottomCtrl.dispose();
    super.dispose();
  }

  void addMeme() {
    memes.add(Meme(selected, topCtrl.text, bottomCtrl.text));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Générateur de Memes')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // choix image locale
            DropdownButton<String>(
              value: selected,
              isExpanded: true,
              items: gallery
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() => selected = v!),
            ),
            const SizedBox(height: 8),
            // aperçu
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(selected, fit: BoxFit.cover),
                  _memeText(topCtrl.text, Alignment.topCenter),
                  _memeText(bottomCtrl.text, Alignment.bottomCenter),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: topCtrl,
              decoration: const InputDecoration(labelText: 'Texte haut'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: bottomCtrl,
              decoration: const InputDecoration(labelText: 'Texte bas'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            FilledButton(onPressed: addMeme, child: const Text('Ajouter à la liste')),
            const SizedBox(height: 8),
            // liste des mèmes créés
            Expanded(
              child: memes.isEmpty
                  ? const Center(child: Text('Aucun mème'))
                  : ListView.builder(
                      itemCount: memes.length,
                      itemBuilder: (_, i) {
                        final m = memes[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _memeText(String t, Alignment a) => Align(
        alignment: a,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            t.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(offset: Offset(-1.2, -1.2), color: Colors.black),
                Shadow(offset: Offset(1.2, -1.2), color: Colors.black),
                Shadow(offset: Offset(1.2, 1.2), color: Colors.black),
                Shadow(offset: Offset(-1.2, 1.2), color: Colors.black),
              ],
            ),
          ),
        ),
      );
}
