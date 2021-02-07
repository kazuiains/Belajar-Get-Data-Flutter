// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResp _$MovieRespFromJson(Map<String, dynamic> json) {
  return MovieResp(
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : MovieItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieRespToJson(MovieResp instance) => <String, dynamic>{
      'results': instance.results,
    };
