import 'package:flutter/material.dart';

class MemeCreatorPage extends StatefulWidget {
  const MemeCreatorPage({super.key, required this.image});
  final String image;

  @override
  State<StatefulWidget> createState() => _MemeCreatorPageState();
}

class _MemeCreatorPageState extends State<MemeCreatorPage> {
  final topTextController = TextEditingController();

  @override
  void dispose() {
    topTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Meme Creator"),
      ),
      body: Center(
          child: Column(children: [
        createMemeImage(widget.image, topTextController.text),
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 250,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Top Text"),
                  controller: topTextController,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context, (widget.image, topTextController.text));
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        )
      ])),
    );
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
        ),
      ],
    );
