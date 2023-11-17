import 'package:cinemapedia/infrastructure/datasource/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
