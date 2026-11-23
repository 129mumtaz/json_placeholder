import 'package:flutter/material.dart';
import 'package:json_placehlder/model/comments.dart';

class CommentWidget extends StatelessWidget {
  final Comments comments;

  const CommentWidget({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E8ED), width: 1),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Inisial, Nama, Email, dan Badge Post ID
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFEAF0F8),
                child: Text(
                  comments.name.isNotEmpty
                      ? comments.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF526B9A),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comments.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF252A34),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      comments.email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF737B89),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0F8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Post #${comments.postId}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF526B9A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Garis pemisah tipis
          const Divider(height: 1, color: Color(0xFFE5E8ED)),
          const SizedBox(height: 12),

          // Isi komentar dengan alignment kiri (tidak di tengah)
          Text(
            comments.body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF252A34),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
