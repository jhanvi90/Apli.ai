// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_detail_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDetails _$AlbumDetailsFromJson(Map<String, dynamic> json) => AlbumDetails(
      wrapperType: json['wrapperType'] as String?,
      artistType: json['artistType'] as String? ?? '',
      artistName: json['artistName'] as String? ?? '',
      artistLinkUrl: json['artistLinkUrl'] as String? ?? '',
      artistId: json['artistId'] as int? ?? 0,
      amgArtistId: json['amgArtistId'] as int? ?? 0,
      primaryGenreName: json['primaryGenreName'] as String? ?? '',
      primaryGenreId: json['primaryGenreId'] as int? ?? 0,
      artistViewUrl: json['artistViewUrl'] as String? ?? '',
      artworkUrl60: json['artworkUrl60'] as String? ?? '',
      artworkUrl100: json['artworkUrl100'] as String? ?? '',
      collectionCensoredName: json['collectionCensoredName'] as String? ?? '',
      collectionExplicitness: json['collectionExplicitness'] as String? ?? '',
      collectionId: json['collectionId'] as int? ?? 0,
      collectionName: json['collectionName'] as String? ?? '',
      collectionPrice: (json['collectionPrice'] as num?)?.toDouble() ?? 0.0,
      collectionType: json['collectionType'] as String? ?? '',
      collectionViewUrl: json['collectionViewUrl'] as String? ?? '',
      copyright: json['copyright'] as String? ?? '',
      country: json['country'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      releaseDate: json['releaseDate'] as String? ?? '',
      trackCount: json['trackCount'] as int? ?? 0,
    );

Map<String, dynamic> _$AlbumDetailsToJson(AlbumDetails instance) =>
    <String, dynamic>{
      'wrapperType': instance.wrapperType,
      'artistType': instance.artistType,
      'collectionType': instance.collectionType,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'collectionCensoredName': instance.collectionCensoredName,
      'artistViewUrl': instance.artistViewUrl,
      'collectionViewUrl': instance.collectionViewUrl,
      'artworkUrl60': instance.artworkUrl60,
      'artworkUrl100': instance.artworkUrl100,
      'collectionPrice': instance.collectionPrice,
      'collectionExplicitness': instance.collectionExplicitness,
      'trackCount': instance.trackCount,
      'copyright': instance.copyright,
      'country': instance.country,
      'currency': instance.currency,
      'releaseDate': instance.releaseDate,
      'artistName': instance.artistName,
      'artistLinkUrl': instance.artistLinkUrl,
      'artistId': instance.artistId,
      'amgArtistId': instance.amgArtistId,
      'primaryGenreName': instance.primaryGenreName,
      'primaryGenreId': instance.primaryGenreId,
    };
