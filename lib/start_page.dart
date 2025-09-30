import 'package:flutter/material.dart';
import 'create_page.dart';
import 'saved_page.dart';

// Page d'accueil
class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Générateur de mèmes')),
      body: const Center(child: Text('Choisis une action en bas')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       // Deux boutons flottants : créer et voir la liste
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          // Bouton pour créer un mème
          FloatingActionButton(  
            heroTag: "create",
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const CreatePage()));
            },
          ),
          // Bouton pour voir les mèmes sauvegardés
          FloatingActionButton(
            heroTag: "saved",
            child: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const SavedPage()));
            },
          ),
        ],
      ),
    );
  }
}
