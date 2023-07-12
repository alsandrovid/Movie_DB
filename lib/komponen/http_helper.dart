import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlKey = 'api_key=71a252ee08c6a92032307eefffbb0bee';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<List<Movie>> getUpcoming() async {
    final Uri upcoming = Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);

    try {
      http.Response result = await http.get(upcoming);
      if (result.statusCode == HttpStatus.ok) {
        final jsonResponseBody = json.decode(result.body);
        final movieObjects = jsonResponseBody['results'];
        List<Movie> movies =
        movieObjects.map<Movie>((json) => Movie.fromJson(json)).toList();
        return movies;
      } else {
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}

class Movie {
  final int id;
  final String title;

  var releaseDate;

  Movie({required this.id, required this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
    );
  }
}


