import 'package:flutter/material.dart';

import 'template_picker.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<(String, String)> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("My Gallery"),
      ),
      body: Center(
          child: GridView.builder(
        itemCount: images.length,
        itemBuilder: (ctx, idx) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: createMemeImage(images[idx].$1, images[idx].$2),
          );
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_createImage(context)},
        tooltip: 'Create Image',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createImage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute<(String, String)>(
            builder: (context) => const TemplatePickerPage()));

    if (result != null) {
      setState(() {
        images.add(result);
      });
    }
  }
}

Widget createMemeImage(String image, String topText) => Stack(
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            topText,
            style: const TextStyle(
              fontSize: 12,
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
        ),
      ],
    );
