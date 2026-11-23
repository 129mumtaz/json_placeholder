import 'package:flutter/material.dart';
import 'package:json_placehlder/model/photos.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photos;

  const PhotoWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E8ED), width: 1),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail proporsional (76x76), tidak terdistorsi
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              photos.thumbnailUrl,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 76,
                  height: 76,
                  color: const Color(0xFFEAF0F8),
                  child: const Icon(
                    Icons.image_outlined,
                    color: Color(0xFF526B9A),
                    size: 28,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 14),

          // Informasi Foto (ID, Album, dan Judul)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF0F8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Photo #${photos.id}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF526B9A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Album #${photos.albumId}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF737B89),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  photos.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF252A34),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  photos.url,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF737B89),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
