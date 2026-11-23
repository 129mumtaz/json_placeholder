import 'package:flutter/material.dart';
import 'package:json_placehlder/model/users.dart';

class UserWidget extends StatelessWidget {
  final Users users;

  const UserWidget({super.key, required this.users});

  // Palet warna yang ditentukan
  static const Color primaryColor = Color(0xFF526B9A);
  static const Color accentColor = Color(0xFF526B9A);
  static const Color softBlueColor = Color(0xFFEAF0F8);
  static const Color backgroundColor = Color(0xFFF7F8FA);
  static const Color textMainColor = Color(0xFF252A34);
  static const Color textSecondaryColor = Color(0xFF737B89);
  static const Color borderColor = Color(0xFFE5E8ED);

  // Fungsi sederhana untuk mengambil inisial nama (contoh: "Leanne Graham" -> "LG")
  String _getInitials(String name) {
    List<String> words = name.trim().split(' ');
    if (words.length > 2 &&
        (words[0].toLowerCase() == 'mrs.' || words[0].toLowerCase() == 'mr.')) {
      return '${words[1][0]}${words[2][0]}'.toUpperCase();
    }
    if (words.length > 1) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty && words[0].isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'U';
  }

  // Widget pembantu untuk membuat baris info (Email, Telepon, Website)
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required IconData trailingIcon,
    bool isLink = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isLink ? primaryColor : textMainColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(trailingIcon, size: 16, color: textSecondaryColor),
        ],
      ),
    );
  }

  // Widget pembantu untuk menampilkan alamat lengkap
  Widget _buildAddressTile(Address address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on_outlined, size: 18, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ALAMAT KANTOR',
                  style: TextStyle(
                    fontSize: 10,
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${address.suite}, ${address.street}, ${address.city}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: textMainColor,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: softBlueColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Kode Pos: ${address.zipcode}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: softBlueColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Geo: ${address.geo.lat}, ${address.geo.lng}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Avatar Inisial, Nama, Username, ID, Bookmark
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: primaryColor,
                child: Text(
                  _getInitials(users.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            users.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: textMainColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 16,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          '@${users.username}',
                          style: const TextStyle(
                            color: textSecondaryColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: softBlueColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'ID: #${users.id.toString().padLeft(3, '0')}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_outline, color: primaryColor, size: 20),
            ],
          ),
          const SizedBox(height: 12),

          // 2. Bagian Perusahaan (Company)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: softBlueColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              users.company.name.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: primaryColor,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 3. Bagian Informasi Kontak & Alamat
          _buildInfoTile(
            icon: Icons.email_outlined,
            title: 'SUREL PERUSAHAAN',
            value: users.email,
            trailingIcon: Icons.copy_outlined,
          ),
          _buildInfoTile(
            icon: Icons.phone_outlined,
            title: 'TELEPON KERJA',
            value: users.phone,
            trailingIcon: Icons.chevron_right,
          ),
          _buildInfoTile(
            icon: Icons.language_outlined,
            title: 'SITUS WEB',
            value: users.website,
            trailingIcon: Icons.open_in_new,
            isLink: true,
          ),
          _buildAddressTile(users.address),
          const SizedBox(height: 8),

          // 4. Kotak Sederhana Pengganti Peta / Lokasi
          Container(
            height: 72,
            width: double.infinity,
            decoration: BoxDecoration(
              color: softBlueColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 28,
                    color: primaryColor,
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 13,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${users.address.city} District',
                        style: const TextStyle(
                          color: textMainColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  right: 10,
                  bottom: 8,
                  child: Text(
                    'Buka Peta ↗',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 5. Dua Tombol: Hubungi & Lihat Profil
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, size: 16),
                  label: const Text('Hubungi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_outline, size: 16),
                  label: const Text('Lihat Profil'),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: textMainColor,
                    side: const BorderSide(color: borderColor),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
