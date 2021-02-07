// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieItem _$MovieItemFromJson(Map<String, dynamic> json) {
  return MovieItem(
    posterPath: json['poster_path'] as String,
    backDropPath: json['backdrop_path'] as String,
    originalTitle: json['original_title'] as String,
    title: json['title'] as String,
    overview: json['overview'] as String,
    releaseDate: json['release_date'] as String,
  );
}

Map<String, dynamic> _$MovieItemToJson(MovieItem instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backDropPath,
      'original_title': instance.originalTitle,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
    };
