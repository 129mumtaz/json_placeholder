import 'package:flutter/material.dart';
import 'package:json_placehlder/model/posts.dart';

class PostWidget extends StatelessWidget {
  final Posts posts;

  const PostWidget({super.key, required this.posts});

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
          // Baris Informasi Sekunder (ID Post & User ID)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0F8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '#${posts.id}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF526B9A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Author ID: ${posts.userId}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF737B89),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Judul Post
          Text(
            posts.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF252A34),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8),

          // Isi / Body Post
          Text(
            posts.body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF737B89),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
