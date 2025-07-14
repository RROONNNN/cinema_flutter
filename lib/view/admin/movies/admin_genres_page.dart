import 'package:flutter/material.dart';

class AdminGenresPage extends StatefulWidget {
  const AdminGenresPage({super.key});

  @override
  State<AdminGenresPage> createState() => _AdminGenresPageState();
}

class _AdminGenresPageState extends State<AdminGenresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Genres')));
  }
}
