import 'package:apliee/response/album_detail_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AlbumResponse {
  @JsonKey(name: 'resultCount')
  int? resultCount;

  @JsonKey(name: 'results')
  List<AlbumDetails>? results;

  AlbumResponse({this.resultCount, this.results});

  factory AlbumResponse.fromJson(Map<String, dynamic> json) {
    return _$AlbumResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}
