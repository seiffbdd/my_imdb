import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_imdb/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:my_imdb/widgets/custom_futurebuilder.dart';
import 'package:my_imdb/widgets/custom_search.dart';

class TopMovies extends StatefulWidget {
  const TopMovies({super.key});

  @override
  State<TopMovies> createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  Future<List<Movie>> getData() async {
    String uri = 'https://freetestapi.com/api/v1/movies';
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<Movie> allMovies = [];

      for (var item in responseBody) {
        Movie movie = Movie.fromJson(item);
        allMovies.add(movie);
      }

      return allMovies;
    } else {
      throw Exception('Error while getting the data');
    }
  }

  late Future<List<Movie>> movies;

  @override
  void initState() {
    movies = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top 20 movies'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearch(movies: movies));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: CustomFuturebuilder(future: movies));
  }
}
