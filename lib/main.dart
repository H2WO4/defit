import 'package:flutter/material.dart';
import 'start_page.dart';

void main() => runApp(const MemeApp());

class MemeApp extends StatelessWidget {
  const MemeApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartPage(),
      );
}
