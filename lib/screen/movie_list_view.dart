import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      home: const MovieListView(),
    );
  }
}

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  final String iconBase = 'https://image.tmdb.org/t/p/w500/';
  final String defaultImage = 'https://example.com/default-image.jpg';

  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=e66c2abd448ab52364d0f7fa56e6da11'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final movieList = data['results'] as List<dynamic>;
      setState(() {
        movies = movieList.map((movie) => Movie.fromJson(movie)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Film'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, position) {
          ImageProvider<Object> image;

          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath!);
          } else {
            image = NetworkImage(defaultImage);
          }

          return Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(movie: movies[position]),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies[position].title),
              subtitle: Text(
                'Released: ' +
                    movies[position].releaseDate +
                    ' - Vote: ' +
                    movies[position].voteAverage.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Movie {
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String? posterPath;

  Movie({
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] as String,
      releaseDate: json['release_date'] as String,
      voteAverage: json['vote_average'].toDouble(),
      posterPath: json['poster_path'] as String?,
    );
  }
}

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${movie.title}'),
            Text('Release Date: ${movie.releaseDate}'),
            Text('Vote Average: ${movie.voteAverage}'),
          ],
        ),
      ),
    );
  }
}
