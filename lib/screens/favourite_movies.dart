import 'package:flutter/material.dart';
import 'package:my_imdb/dbhelper/sqldb.dart';

class FavouriteMovies extends StatefulWidget {
  const FavouriteMovies({super.key});

  @override
  State<FavouriteMovies> createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  Sqldb sqldb = Sqldb();
  List<Map> favMovies = [];
  bool loading = true;

  readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM favMovies");
    favMovies.addAll(response);
    favMovies.sort((a, b) => (a['id']).compareTo(b['id']));
    loading = false;

    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourite Movies'),
        ),
        body: loading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: favMovies.length,
                separatorBuilder: (context, i) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 0,
                  );
                },
                itemBuilder: (context, i) {
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Center(
                      child: Text(
                        'Remove from Watchlist',
                        style: TextStyle(
                            color: Colors.red, fontSize: screenWidth / 20),
                      ),
                    ),
                    key: Key('${favMovies[i]['id']}'),
                    onDismissed: (direction) async {
                      int response = await sqldb.deleteData(
                          "DELETE FROM favMovies WHERE id = '${favMovies[i]['id']}'");
                      setState(() {
                        favMovies.removeAt(i);
                      });

                      if (response > 0 && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${favMovies[0]['title']} removed from watchlist'),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: screenHeight / 5,
                      color: Colors.grey[900],
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Image.network(favMovies[i]['imageUrl'],
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
                                    '${favMovies[i]['id']}. ${favMovies[i]['title']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth / 22)),
                              ),
                              const Spacer(),
                              Text(
                                '${favMovies[i]['year']}',
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
                                  Text('${favMovies[i]['rating']}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth / 20)),
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
                }));
  }
}
