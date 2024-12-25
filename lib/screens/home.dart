import 'package:flutter/material.dart';
import 'package:my_imdb/screens/favourite_movies.dart';
import 'package:my_imdb/screens/top_movies.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [const TopMovies(), const FavouriteMovies()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Top Movies'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Watchlist'),
          ]),
      body: _screens[_selectedIndex],
    );
  }
}
