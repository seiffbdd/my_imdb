import 'package:flutter/material.dart';
import 'package:my_imdb/dbhelper/sqldb.dart';
import 'package:my_imdb/model/movie.dart';

class MovieDetails extends StatefulWidget {
  static const movieDetailsPath = '/movieDetails';
  final String imageUrl;
  final Movie movie;
  const MovieDetails({super.key, required this.movie, required this.imageUrl});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Sqldb sqldb = Sqldb();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              widget.movie.title,
              style: TextStyle(fontSize: screenWidth / 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('${widget.movie.year}'),
          ),
          Image.network(
            widget.imageUrl,
            height: screenHeight / 3.2,
            width: screenWidth,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.imageUrl,
                  width: screenWidth / 3,
                ),
                Container(
                  width: screenWidth / 2,
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.movie.plot,
                    style: TextStyle(fontSize: screenWidth / 20),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: screenWidth,
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.movie.genre.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MaterialButton(
                    color: Colors.grey[800],
                    onPressed: () {},
                    child: Text(widget.movie.genre[i]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: MaterialButton(
              padding: const EdgeInsets.all(8),
              color: Colors.yellow,
              onPressed: () async {
                List<Map> listResponse = await sqldb.readData('''
                  SELECT * FROM favMovies WHERE id = ${widget.movie.id}
                ''');
                if (listResponse.isEmpty) {
                  int insertResponse = await sqldb.insertData('''
                  INSERT INTO favMovies(id, title, year, rating, imageUrl) VALUES
                  ("${widget.movie.id}", "${widget.movie.title}", "${widget.movie.year}",
                  "${widget.movie.rating}", "${widget.imageUrl}")
                ''');
                  if (insertResponse > 0 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${widget.movie.title} added to Watchlist'),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('${widget.movie.title} is already in Watchlist'),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Add to Watchlist',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  Text('${widget.movie.rating}/10')
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.star_outline,
                    color: Colors.blue[900],
                    size: 40,
                  ),
                  const Text('Rate this')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
