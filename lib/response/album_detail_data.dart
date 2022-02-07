import 'package:json_annotation/json_annotation.dart';

part 'album_detail_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AlbumDetails {
  @JsonKey(name: 'wrapperType')
  String? wrapperType;

  @JsonKey(name: 'artistType', defaultValue: "")
  String? artistType;

  @JsonKey(name: 'collectionType', defaultValue: "")
  String? collectionType;

  @JsonKey(name: 'collectionId', defaultValue: 0)
  int? collectionId;

  @JsonKey(name: 'collectionName', defaultValue: "")
  String? collectionName;

  @JsonKey(name: 'collectionCensoredName', defaultValue: "")
  String? collectionCensoredName;

  @JsonKey(name: 'artistViewUrl', defaultValue: "")
  String? artistViewUrl;

  @JsonKey(name: 'collectionViewUrl', defaultValue: "")
  String? collectionViewUrl;

  @JsonKey(name: 'artworkUrl60', defaultValue: "")
  String? artworkUrl60;

  @JsonKey(name: 'artworkUrl100', defaultValue: "")
  String? artworkUrl100;

  @JsonKey(name: 'collectionPrice', defaultValue: 0.0)
  double? collectionPrice;

  @JsonKey(name: 'collectionExplicitness', defaultValue: "")
  String? collectionExplicitness;

  @JsonKey(name: 'trackCount', defaultValue: 0)
  int? trackCount;

  @JsonKey(name: 'copyright', defaultValue: "")
  String? copyright;

  @JsonKey(name: 'country', defaultValue: "")
  String? country;

  @JsonKey(name: 'currency', defaultValue: "")
  String? currency;

  @JsonKey(name: 'releaseDate', defaultValue: "")
  String? releaseDate;

  @JsonKey(name: 'artistName', defaultValue: "")
  String? artistName;

  @JsonKey(name: 'artistLinkUrl', defaultValue: "")
  String? artistLinkUrl;

  @JsonKey(name: 'artistId', defaultValue: 0)
  int? artistId;

  @JsonKey(name: 'amgArtistId', defaultValue: 0)
  int? amgArtistId;

  @JsonKey(name: 'primaryGenreName', defaultValue: "")
  String? primaryGenreName;

  @JsonKey(name: 'primaryGenreId', defaultValue: 0)
  int? primaryGenreId;

  AlbumDetails(
      {this.wrapperType,
      this.artistType,
      this.artistName,
      this.artistLinkUrl,
      this.artistId,
      this.amgArtistId,
      this.primaryGenreName,
      this.primaryGenreId,
      this.artistViewUrl,
      this.artworkUrl60,
      this.artworkUrl100,
      this.collectionCensoredName,
      this.collectionExplicitness,
      this.collectionId,
      this.collectionName,
      this.collectionPrice,
      this.collectionType,
      this.collectionViewUrl,
      this.copyright,
      this.country,
      this.currency,
      this.releaseDate,
      this.trackCount});

  factory AlbumDetails.fromJson(Map<String, dynamic> json) {
    return _$AlbumDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AlbumDetailsToJson(this);
}
