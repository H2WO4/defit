import 'package:flutter/material.dart';
import 'meme.dart';
import 'saved_page.dart';

// Page pour créer un nouveau mème
class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // Liste des images disponibles (doivent être dans img/)
  static const gallery = [
    'img/a7mwmr.jpg',
    'img/a7mwq2.jpg',
    'img/a7mwqx.jpg',
  ];

  String selected = gallery.first; // image choisie par défaut
  final topCtrl = TextEditingController(text: 'TOP TEXT');     // texte haut
  final bottomCtrl = TextEditingController(text: 'BOTTOM TEXT'); // texte bas

  // Quand on appuie sur sauvegarder
  void save() {
    savedMemes.add(Meme(selected, topCtrl.text, bottomCtrl.text));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SavedPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Création d\'un mème')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Menu déroulant pour choisir l'image
            DropdownButton<String>(
              value: selected,
              isExpanded: true,
              items: gallery.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => selected = v!),
            ),
            const SizedBox(height: 8),
            // Aperçu du mème
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
            // Champs texte pour écrire
            TextField(controller: topCtrl, decoration: const InputDecoration(labelText: 'Texte haut'), onChanged: (_) => setState(() {})),
            const SizedBox(height: 8),
            TextField(controller: bottomCtrl, decoration: const InputDecoration(labelText: 'Texte bas'), onChanged: (_) => setState(() {})),
            const SizedBox(height: 8),
            // Bouton sauvegarder
            FilledButton(onPressed: save, child: const Text('Sauvegarder')),
          ],
        ),
      ),
    );
  }

  // Style du texte de mème
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
