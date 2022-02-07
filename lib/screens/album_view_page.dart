import 'package:apliee/screens/controller/album_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({Key? key}) : super(key: key);

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlbumController());
    return Scaffold(
      body: Obx(() {
        return ListView.builder(
            itemCount: controller.albumList.length,
            itemBuilder: (BuildContext context, int index) {
              var album = controller.albumList[index];
              return GestureDetector(
                onTap: () {},
                child: ListTile(
                    leading: Image.network(album.artistViewUrl!),
                    title: Text(album.artistName!)),
              );
            });
      }),
    );
  }
}
