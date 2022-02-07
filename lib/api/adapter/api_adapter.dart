import 'package:apliee/api/service/retrofit_service.dart';
import 'package:apliee/response/album_response.dart';
import 'package:dio/dio.dart';

class ApiAdapter {
  late RetrofitService _retrofitService;
  final dio = Dio();

  ApiAdapter() {
    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     compact: false,
    //   ),
    // );
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 20000;
    _retrofitService = RetrofitService(dio);
  }

  Future<AlbumResponse> albumDataList() {
    return _retrofitService.fetchAlbum();
  }
}
