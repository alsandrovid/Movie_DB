import 'package:flutter/material.dart';
import 'package:moviedb/screen/movie_list.dart';

import 'movie_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MovieDB',
      home: MovieListView(),
    );
  }
}
