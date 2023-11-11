import 'package:cinemapedia/infrastructure/datasource/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es de solo lectura
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource: ActorMovieDatasource());
});
