import 'package:cinema_flutter/view_model/admin/movies/bloc/admin_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../movies/admin_movies_page.dart';
import '../movies/admin_genres_page.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AdminMoviesPage(),
    const AdminGenresPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AdminMoviesBloc())],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Dashboard'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Admin Panel',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Movies'),
                  selected: _selectedIndex == 0,
                  onTap: () {
                    _onItemTapped(0);
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Genres'),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    _onItemTapped(1);
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ],
            ),
          ),
          body: _pages[_selectedIndex],
        ),
      ),
    );
  }
}
