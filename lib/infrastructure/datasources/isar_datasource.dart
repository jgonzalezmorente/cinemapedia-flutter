import 'package:isar/isar.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if ( Isar.instanceNames.isNotEmpty ) {
      return Future.value( Isar.getInstance() );
    }
    final dir = await getApplicationDocumentsDirectory();  
    return Isar.open( 
      [ MovieSchema ],
      inspector: true, 
      directory: dir.path 
    );
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {    
    throw UnimplementedError();
  }
}
