import 'package:flutter/material.dart';
import 'package:my_imdb/model/movie.dart';
import 'package:my_imdb/screens/movie_details.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final Movie movie;
  const CustomCard({super.key, required this.movie, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetails(
                  movie: movie,
                  imageUrl: imageUrl,
                )));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: screenHeight / 5,
        color: Colors.grey[900],
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Image.network(imageUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                  width: screenWidth / 4),
            ),
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
                        color: Colors.white, fontSize: screenWidth / 22),
                  ),
                ),
                const Spacer(),
                Text(
                  '${movie.year}',
                  style:
                      TextStyle(color: Colors.grey, fontSize: screenWidth / 25),
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
                            color: Colors.white, fontSize: screenWidth / 20))
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
  }
}
