import 'package:flutter/material.dart';
import 'create_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Générateur de mèmes')),
      body: const Center(child: Text('Appuie sur + pour créer un mème')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePage()));
        },
      ),
    );
  }
}
