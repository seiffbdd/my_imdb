class Movie {
  int id;
  String title;
  int year;
  List<String> genre;
  double rating;
  String director;
  List<String> actors;
  String plot;
  String poster;
  String trailer;
  int runtime;
  String awards;
  String country;
  String language;
  String boxOffice;
  String production;
  String website;

  Movie(
      {required this.id,
      required this.title,
      required this.year,
      required this.genre,
      required this.rating,
      required this.director,
      required this.actors,
      required this.plot,
      required this.poster,
      required this.trailer,
      required this.runtime,
      required this.awards,
      required this.country,
      required this.language,
      required this.boxOffice,
      required this.production,
      required this.website});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      year: json['year'] ?? 0,
      genre: List<String>.from(json['genre'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      director: json['director'] ?? 'Unknown',
      actors: List<String>.from(json['actors'] ?? []),
      plot: json['plot'] ?? 'No plot available',
      poster: json['poster'] ?? '',
      trailer: json['trailer'] ?? '',
      runtime: json['runtime'] ?? 0,
      awards: json['awards'] ?? 'No awards',
      country: json['country'] ?? 'Unknown',
      language: json['language'] ?? 'Unknown',
      boxOffice: json['boxOffice'] ?? 'Unknown',
      production: json['production'] ?? 'Unknown',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['year'] = year;
    data['genre'] = genre;
    data['rating'] = rating;
    data['director'] = director;
    data['actors'] = actors;
    data['plot'] = plot;
    data['poster'] = poster;
    data['trailer'] = trailer;
    data['runtime'] = runtime;
    data['awards'] = awards;
    data['country'] = country;
    data['language'] = language;
    data['boxOffice'] = boxOffice;
    data['production'] = production;
    data['website'] = website;
    return data;
  }
}
