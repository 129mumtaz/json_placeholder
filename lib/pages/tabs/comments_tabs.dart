import 'package:flutter/material.dart';
import 'package:json_placehlder/model/comments.dart';
import 'package:json_placehlder/service/api_service.dart';
import 'package:json_placehlder/widget/async_data_view.dart';
import 'package:json_placehlder/widget/comment_widget.dart';

class CommentsTabs extends StatelessWidget {
  const CommentsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Comments>(
      onFetch: ApiService.fetchComments,
      itemBuilder: (context, comments, index) {
        return CommentWidget(comments: comments);
      },
      title: 'Comments',
    );
  }
}