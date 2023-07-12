import 'package:flutter/material.dart';
import '../model/movie.dart';

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
            // Tambahkan widget lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}