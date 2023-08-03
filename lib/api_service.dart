import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class ApiService {
  static const String _apiKey =
      'c8b1591923e173212d1ee9790aab7d2f'; // Coloque sua chave de API aqui

  static Future<List<Movie>> fetchPopularMovies() async {
    final url = 'https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }
}
