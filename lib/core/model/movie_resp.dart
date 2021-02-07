import 'package:json_annotation/json_annotation.dart';
import 'package:start_flutter/core/model/movie_item.dart';

part 'movie_resp.g.dart';

@JsonSerializable()
class MovieResp {
  List<MovieItem> results;

  MovieResp(this.results);

  factory MovieResp.fromJson(Map<String, dynamic> json) => _$MovieRespFromJson(json);
  Map<String, dynamic> toJson() => _$MovieRespToJson(this);
}