import 'dart:developer';

import 'package:apliee/api/adapter/api_adapter.dart';
import 'package:apliee/response/album_detail_data.dart';
import 'package:apliee/response/album_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  final apiAdapter = ApiAdapter();
  var isLoading = false.obs;
  var albumList = <AlbumDetails>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAlbum();
  }

  Future<void> getAlbum() async {
    AlbumResponse response = await _getAlbum();
    for (var item in response.results!) {
      // this will add results data to observable list
      albumList.assign(item);
    }
    //log("Data${response.resultCount}");
  }

  Future<AlbumResponse> _getAlbum() async {
    var response = AlbumResponse();
    try {
      response = await apiAdapter.albumDataList();
    } on DioError catch (e) {
      log(e.message);
    }
    return response;
  }
}
