import 'package:flutter/material.dart';
import 'package:json_placehlder/model/photos.dart';
import 'package:json_placehlder/service/api_service.dart';
import 'package:json_placehlder/widget/async_data_view.dart';
import 'package:json_placehlder/widget/photo_widget.dart';

class PhotosTabs extends StatelessWidget {
  const PhotosTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Photos>(
      onFetch: ApiService.fetchPhotos,
      itemBuilder: (context, photos, index) {
        return PhotoWidget(photos: photos);
      },
      title: 'Photos',
    );
  }
}
