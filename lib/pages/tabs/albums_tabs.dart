import 'package:flutter/material.dart';
import 'package:json_placehlder/model/albums.dart';
import 'package:json_placehlder/service/api_service.dart';
import 'package:json_placehlder/widget/album_widget.dart';
import 'package:json_placehlder/widget/async_data_view.dart';

class AlbumsTabs extends StatelessWidget {
  const AlbumsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Albums>(
      onFetch: ApiService.fetchAlbums,
      itemBuilder: (context, albums, index) {
        return AlbumWidget(albums: albums);
      },
      title: 'Albums',
    );
  }
}
