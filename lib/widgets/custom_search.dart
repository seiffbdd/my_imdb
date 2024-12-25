import 'package:flutter/material.dart';
import 'package:my_imdb/model/movie.dart';
import 'package:my_imdb/screens/movie_details.dart';

class CustomSearch extends SearchDelegate {
  final Future<List<Movie>> movies;
  CustomSearch({required this.movies});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Movie> results = snapshot.data!
                .where((element) => element.title.toLowerCase().contains(query))
                .toList();
            if (results.isEmpty) {
              return const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return ListView.separated(
                itemCount: results.length,
                separatorBuilder: (context, i) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 0,
                  );
                },
                itemBuilder: (context, i) {
                  Movie movie = results[i];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetails(
                              movie: movie, imageUrl: movie.poster)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: screenHeight / 5,
                      color: Colors.grey[900],
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Image.network(movie.poster)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(
                                flex: 4,
                              ),
                              SizedBox(
                                width: screenWidth / 1.5,
                                child: Text(
                                  '${movie.id}. ${movie.title}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth / 22),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${movie.year}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenWidth / 25),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text('${movie.rating}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth / 20))
                                ],
                              ),
                              const Spacer(
                                flex: 4,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('');
  }
}
