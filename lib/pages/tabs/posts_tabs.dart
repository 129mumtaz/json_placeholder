import 'package:flutter/material.dart';
import 'package:json_placehlder/model/posts.dart';
import 'package:json_placehlder/service/api_service.dart';
import 'package:json_placehlder/widget/async_data_view.dart';
import 'package:json_placehlder/widget/post_widget.dart';

class PostsTabs extends StatelessWidget {
  const PostsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Posts>(
      onFetch: ApiService.fetchPosts, 
      itemBuilder: (context, posts, index) {
        return PostWidget(posts: posts);
      },
      title: 'Posts'
      );
  }
}