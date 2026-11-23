import 'package:flutter/material.dart';
import 'package:json_placehlder/model/albums.dart';
import 'package:json_placehlder/model/photos.dart';
import 'package:json_placehlder/service/api_service.dart';

class AlbumWidget extends StatelessWidget {
  final Albums albums;

  const AlbumWidget({super.key, required this.albums});

  // Fungsi untuk menampilkan pop-up AlertDialog berisi foto
  void _showPhotosDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFFE5E8ED)),
          ),
          title: Text(
            albums.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF252A34),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 340,
            child: FutureBuilder<List<Photos>>(
              future: ApiService.fetchPhotosByAlbum(albums.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF526B9A),
                      strokeWidth: 2.5,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Gagal memuat foto: ${snapshot.error}',
                      style: const TextStyle(color: Color(0xFF737B89), fontSize: 13),
                    ),
                  );
                }

                final photos = snapshot.data ?? [];
                if (photos.isEmpty) {
                  return const Center(
                    child: Text(
                      'Tidak ada foto dalam album ini',
                      style: TextStyle(color: Color(0xFF737B89), fontSize: 13),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: photos.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 12,
                    color: Color(0xFFE5E8ED),
                  ),
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              photo.thumbnailUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 50,
                                  height: 50,
                                  color: const Color(0xFFEAF0F8),
                                  child: const Icon(
                                    Icons.image_outlined,
                                    size: 24,
                                    color: Color(0xFF526B9A),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              photo.title,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF252A34),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF526B9A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('Tutup', style: TextStyle(fontSize: 13)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E8ED), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _showPhotosDialog(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Row(
            children: [
              // Icon Box
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0F8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.photo_library_outlined,
                  size: 20,
                  color: Color(0xFF526B9A),
                ),
              ),
              const SizedBox(width: 14),

              // Title and Meta
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8FA),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFE5E8ED)),
                          ),
                          child: Text(
                            'Album #${albums.id}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF526B9A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'User ID: ${albums.userId}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF737B89),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      albums.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF252A34),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Trailing chevron
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: Color(0xFF737B89),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
