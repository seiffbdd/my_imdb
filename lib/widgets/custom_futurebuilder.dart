import 'package:flutter/material.dart';
import 'package:my_imdb/model/movie.dart';
import 'package:my_imdb/widgets/custom_listview.dart';

class CustomFuturebuilder extends StatelessWidget {
  final Future<List<Movie>> future;

  const CustomFuturebuilder({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomListview(snapshot: snapshot);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
