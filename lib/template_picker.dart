import 'package:flutter/material.dart';
import 'package:meme/meme_creator.dart';

class TemplatePickerPage extends StatelessWidget {
  const TemplatePickerPage({super.key});
  static List<String> images = [
    "images/always_has_been.png",
    "images/cat.png",
    "images/one_does_not.png",
    "images/toy_story.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Meme Creation')),
        body: Center(
          child: GridView.builder(
            itemCount: images.length,
            itemBuilder: (ctx, idx) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                    onTap: () {
                      _createImage(context, images[idx]);
                    },
                    child: Image.asset(images[idx], fit: BoxFit.contain)),
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
            ),
          ),
        ));
  }

  Future<void> _createImage(BuildContext context, String image) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute<(String, String)>(
            builder: (context) => MemeCreatorPage(image: image)));

    if (result != null) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, result);
    }
  }
}
