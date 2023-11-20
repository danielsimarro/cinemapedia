import 'package:cinemapedia/domain/entities/video.dart';
import '../models/moviedb_video.dart';

class VideoMapper {
  static Video movieDTtoEntity(Result videodb) => Video(
      id: videodb.id,
      name: videodb.name,
      youtubeKey: videodb.key,
      publishedAt: videodb.publishedAt);
}
