import 'package:cinemapedia/infrastructure/models/movidedb/moviedb_videos.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environments.dart';
import 'package:cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:cinemapedia/infrastructure/models/movidedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/movidedb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/mappers/mappers.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

class MoviedbDatasource extends MoviesDataSource {
  
  final dio = Dio( BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Envirionments.theMovieDbKey,
        'language': 'es-ES'
      }
    )
  );

  List<Movie> _jsonToMovies( Map<String, dynamic> json ) {    
    final movieDbResponse = MovieDbResponse.fromJson( json );
    final List<Movie> movies = movieDbResponse.results
      .map(
        MovieMapper.movieDBToEntity 
      ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get( '/movie/now_playing', queryParameters: { 'page': page } );
    return _jsonToMovies( response.data );
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get( '/movie/popular', queryParameters: { 'page': page } );
    return _jsonToMovies( response.data );
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get( '/movie/top_rated', queryParameters: { 'page': page } );
    return _jsonToMovies( response.data );
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get( '/movie/upcoming', queryParameters: { 'page': page } );
    return _jsonToMovies( response.data );
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get( '/movie/$id' );
    if ( response.statusCode != 200 ) throw Exception( 'Movie with id: $id not found' );
    final movieDetails = MovieDetails.fromJson( response.data );
    final Movie movie = MovieMapper.movieDetailsToEntity( movieDetails );
    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async {
    if ( query.isEmpty ) return [];
    final response = await dio.get( '/search/movie', queryParameters: { 'query': query } );    
    return _jsonToMovies( response.data );
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get( '/movie/$movieId/similar' );
    return _jsonToMovies( response.data );
  }

  @override
  Future<List<Video>> getYoutubbeVideosById(int movieId) async {
    final response = await dio.get( '/movie/$movieId/videos' );
    final moviedbVideosResponse = MoviedbVideosResponse.fromJson( response.data );
    final videos = <Video>[];

    for( final moviedbVideo in moviedbVideosResponse.results ) {
      if ( moviedbVideo.site == 'YouTube' ) {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add( video );
      }
    }

    return videos;

  }

}