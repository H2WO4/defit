import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

// ----------------------------------------------------
// 1. MODÈLE DE DONNÉES
// ----------------------------------------------------

class Meme {
  final String title;
  final String imageUrl;
  final String topText;
  final String bottomText;
  // Clé pour le rechargement de l'image (bonne pratique avec Image.network)
  final Key imageKey = UniqueKey(); 

  Meme({required this.title, required this.imageUrl, required this.topText, required this.bottomText});
}


// ----------------------------------------------------
// 2. ROOT APP & NAVIGATION
// ----------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Generator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ----------------------------------------------------
// 3. ÉCRAN D'ACCUEIL (HOME PAGE - MODIFIÉ)
// ----------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Meme> _createdMemes = [];

  void _addMeme(Meme newMeme) {
    setState(() {
      _createdMemes.add(newMeme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Mèmes Créés', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: _createdMemes.isEmpty
          ? const Center(
              child: Text(
                'Aucun mème créé pour l\'instant. Cliquez sur "Création" !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _createdMemes.length,
              itemBuilder: (context, index) {
                final meme = _createdMemes[index];
                return ListTile(
                  leading: const Icon(Icons.image, color: Colors.deepOrange),
                  title: Text(meme.title),
                  subtitle: Text('Texte haut: ${meme.topText}'),
                  trailing: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(meme.imageUrl, key: meme.imageKey, fit: BoxFit.cover),
                  ),
                  onTap: () {
                    // MODIFICATION ICI : Navigation vers la page de détail
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MemeDetailPage(meme: meme),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreationPage(
                title: 'Créer un Nouveau Mème',
                onSave: _addMeme,
              ),
            ),
          );
        },
        label: const Text('Création'),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ----------------------------------------------------
// 5. NOUVEL ÉCRAN : DÉTAIL DU MÈME (MEME DETAIL PAGE)
// ----------------------------------------------------

class MemeDetailPage extends StatelessWidget {
  final Meme meme;

  const MemeDetailPage({super.key, required this.meme});

  // Style de texte classique pour les mèmes
  final TextStyle _memeTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 28.0,
    letterSpacing: 1.5,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 3.0,
        color: Colors.black,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meme.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text('Mème final enregistré :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              
              // Conteneur du mème avec le texte superposé
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // Image du mème
                  Image.network(
                    meme.imageUrl,
                    key: meme.imageKey, // Utilisation de la clé
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                          height: 300, child: Center(child: CircularProgressIndicator()));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                            height: 300, child: Center(child: Text('Échec du chargement de l\'image'))),
                  ),
                  
                  // Texte en haut
                  Positioned(
                    top: 10, left: 10, right: 10,
                    child: Text(
                      meme.topText.toUpperCase(),
                      style: _memeTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  // Texte en bas
                  Positioned(
                    bottom: 10, left: 10, right: 10,
                    child: Text(
                      meme.bottomText.toUpperCase(),
                      style: _memeTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              
              // Affichage des informations de texte brut
              ListTile(
                title: const Text('Texte en Haut'),
                subtitle: Text(meme.topText),
              ),
              ListTile(
                title: const Text('Texte en Bas'),
                subtitle: Text(meme.bottomText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 4. ÉCRAN DE CRÉATION (INCHANGÉ DANS SON IMPLÉMENTATION)
// ----------------------------------------------------

// NOTE: Le code pour CreationPage et _CreationPageState reste le même que dans la version précédente,
// car aucune logique n'y a été modifiée, à l'exception du modèle Meme mis à jour.
// Pour ne pas rendre le code trop long, les classes CreationPage et _CreationPageState complètes ne sont pas répétées ici,
// mais doivent être conservées telles quelles (avec le modèle Meme mis à jour).
// ... (Code de CreationPage et _CreationPageState) ...
class CreationPage extends StatefulWidget {
  const CreationPage({super.key, required this.title, required this.onSave});

  final String title;
  final Function(Meme meme) onSave;

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  // ... (tous les champs et méthodes de la page de création) ...
  String _currentMemeUrl = '';
  String _topText = 'MON TEXTE EN HAUT';
  String _bottomText = 'MON TEXTE EN BAS';
  bool _isLoading = true;

  Key _imageKey = UniqueKey();

  final TextEditingController _topTextController = TextEditingController(text: 'MON TEXTE EN HAUT');
  final TextEditingController _bottomTextController = TextEditingController(text: 'MON TEXTE EN BAS');

  static const String imgflipApiUrl = 'https://api.imgflip.com/get_memes';

  @override
  void initState() {
    super.initState();
    _fetchAndGenerateRandomMeme();
    _topTextController.addListener(_updateText);
    _bottomTextController.addListener(_updateText);
  }

  @override
  void dispose() {
    _topTextController.dispose();
    _bottomTextController.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      _topText = _topTextController.text;
      _bottomText = _bottomTextController.text;
    });
  }

  Future<void> _fetchAndGenerateRandomMeme() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(imgflipApiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final memes = data['data']['memes'] as List;

          if (memes.isNotEmpty) {
            final random = Random();
            final randomMeme = memes[random.nextInt(memes.length)];

            setState(() {
              _currentMemeUrl = randomMeme['url'];
              _imageKey = UniqueKey();
              _isLoading = false;
            });
            return;
          }
        }
      }
      throw Exception('Impossible de charger les modèles de mèmes Imgflip.');

    } catch (e) {
      print('Erreur lors de la récupération des mèmes: $e');
      setState(() {
        _isLoading = false;
        _currentMemeUrl = 'https://picsum.photos/600/400';
      });
    }
  }

  void _saveMeme() {
    final newMeme = Meme(
      title: 'Mème créé le ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      imageUrl: _currentMemeUrl,
      topText: _topText,
      bottomText: _bottomText,
    );

    widget.onSave(newMeme);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mème enregistré avec succès !')),
    );
  }


  final TextStyle _memeTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 26.0,
    letterSpacing: 1.5,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 3.0,
        color: Colors.black,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // --- AFFICHEUR DE MÈME ---
            _isLoading || _currentMemeUrl.isEmpty
                ? const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()))
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            _currentMemeUrl,
                            key: _imageKey,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(
                                    height: 300,
                                    child: Center(child: Text('Échec du chargement de l\'image'))),
                          ),
                          Positioned(
                            top: 10, left: 10, right: 10,
                            child: Text(_topText.toUpperCase(), style: _memeTextStyle, textAlign: TextAlign.center),
                          ),
                          Positioned(
                            bottom: 10, left: 10, right: 10,
                            child: Text(_bottomText.toUpperCase(), style: _memeTextStyle, textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),

            // --- CONTRÔLES D'IMAGE ---
            const Divider(height: 30),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchAndGenerateRandomMeme,
              icon: const Icon(Icons.photo_library),
              label: const Text('Choisir une autre image de la galerie (Imgflip)'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),

            // --- CHAMPS DE TEXTE ---
            const SizedBox(height: 20),
            TextField(
              controller: _topTextController,
              decoration: const InputDecoration(labelText: 'Texte en Haut', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bottomTextController,
              decoration: const InputDecoration(labelText: 'Texte en Bas', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            
            // --- BOUTON D'ENREGISTREMENT ---
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveMeme,
              icon: const Icon(Icons.save),
              label: const Text('Enregistrer le Mème', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.green, 
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}