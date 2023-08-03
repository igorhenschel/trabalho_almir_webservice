import 'package:flutter/material.dart';
import 'movie.dart';
import 'api_service.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes populares'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    width: 50,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro na procura de filmes'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
