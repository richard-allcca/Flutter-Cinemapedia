import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

// NOTE - Este provider se mantiene escuchando a todos los providers para mostrar el loader

final initialLoadingProvider = Provider<bool>((ref) {

      // Full list of videos
      final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;

      // Full list of videos populates
      final step2 = ref.watch(populateMoviesProvider).isEmpty;

      // Full list of videos top rated
      final step3 = ref.watch(topRatedMoviesProvider).isEmpty;

      // Full list of videos upcoming
      final step4 = ref.watch(upcomingMoviesProvider).isEmpty;

      // Si alguno aun esta vacío
      if (
        step1 || step2 || step3 || step4
      ) {
        return true;
      }

      return false;
    });
