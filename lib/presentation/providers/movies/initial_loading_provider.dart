import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>( ( ref ) {

  final movieProviders = [
    ref.watch( nowPlayingMoviesProvider ),
    // ref.watch( popularMoviesProvider ),
    ref.watch( topRatedMoviesProvider ),
    ref.watch( upcomingMoviesProvider ),
  ];

  return movieProviders.any( (provider) => provider.isEmpty );

});