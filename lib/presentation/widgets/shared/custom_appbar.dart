import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build( BuildContext context, WidgetRef ref ) {
    
    final colors = Theme.of( context ).colorScheme;
    final titleStyle = Theme.of( context ).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal:  10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon( Icons.movie_outlined, color: colors.primary ),              
              const SizedBox( width: 5 ),              
              Text( 'Cinemapedia', style: titleStyle ),              
              const Spacer(),              
              IconButton(onPressed: () {
                
                final searchQuery = ref.read( searchQueryProvider );
                final searchMovies = ref.read( searchMoviesProvider );

                showSearch<Movie?>(
                  query: searchQuery,
                  context: context, 
                  delegate: SearchMovieDelegate(
                    initialMovies: searchMovies,
                    searchMovies: ref.read( searchMoviesProvider.notifier ).searchMoviesByQuery
                  )
                ).then( ( movie ) {
                  if ( movie == null ) return;
                  context.push( '/movie/${ movie.id }' );
                });
              }, 

              icon: const Icon( Icons.search )
              )
            ],
          ),
        ),
      )
    );
  }
}