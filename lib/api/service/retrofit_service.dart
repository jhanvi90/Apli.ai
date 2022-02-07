import 'package:apliee/api/adapter/endpoints.dart';
import 'package:apliee/response/album_response.dart';
import 'package:apliee/utlis/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_service.g.dart';

@RestApi(baseUrl: baseUrl) // dev
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String baseUrl}) = _RetrofitService;

  @FormUrlEncoded()
  @GET(epAlbumList)
  Future<AlbumResponse> fetchAlbum();
}
