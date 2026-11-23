import 'package:flutter/material.dart';
import 'package:json_placehlder/model/users.dart';
import 'package:json_placehlder/service/api_service.dart';
import 'package:json_placehlder/widget/user_widget.dart';

class UsersTabs extends StatefulWidget {
  const UsersTabs({super.key});

  @override
  State<UsersTabs> createState() => _UsersTabsState();
}

class _UsersTabsState extends State<UsersTabs> {
  // Palet warna yang ditentukan
  static const Color primaryColor = Color(0xFF526B9A);
  static const Color backgroundColor = Color(0xFFF7F8FA);
  static const Color textMainColor = Color(0xFF252A34);
  static const Color textSecondaryColor = Color(0xFF737B89);
  static const Color borderColor = Color(0xFFE5E8ED);

  // Variabel untuk menyimpan data asli dan data hasil filter
  List<Users> _allUsers = [];
  List<Users> _filteredUsers = [];

  // Variabel status loading dan pesan error
  bool _isLoading = true;
  String? _errorMessage;

  // Controller untuk membaca input di Search Bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Fungsi untuk mengambil data user dari API
  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await ApiService.fetchUsers();
      setState(() {
        _allUsers = data;
        _filteredUsers = data;
        _isLoading = false;
      });
      _filterUsers(_searchController.text);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  // Fungsi untuk memfilter data berdasarkan nama dari Search Bar
  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = _allUsers;
      } else {
        _filteredUsers = _allUsers.where((user) {
          final nameLower = user.name.toLowerCase();
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          // 1. Search Bar dengan Container Responsif
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterUsers,
                  style: const TextStyle(fontSize: 14, color: textMainColor),
                  decoration: InputDecoration(
                    hintText: 'Cari nama user...',
                    hintStyle: const TextStyle(fontSize: 13, color: textSecondaryColor),
                    filled: true,
                    fillColor: backgroundColor,
                    prefixIcon: const Icon(Icons.search, size: 20, color: primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18, color: textSecondaryColor),
                            onPressed: () {
                              _searchController.clear();
                              _filterUsers('');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: primaryColor, width: 1.5),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Daftar User Responsif
          Expanded(
            child: _isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 2.5,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Memuat data user...',
                          style: TextStyle(fontSize: 13, color: textSecondaryColor),
                        ),
                      ],
                    ),
                  )
                : _errorMessage != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: primaryColor,
                                size: 40,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Gagal memuat data user',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: textMainColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$_errorMessage',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: textSecondaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _loadUsers,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  'Coba Lagi',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _filteredUsers.isEmpty
                        ? const Center(
                            child: Text(
                              'User tidak ditemukan',
                              style: TextStyle(fontSize: 14, color: textSecondaryColor),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadUsers,
                            color: primaryColor,
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 860),
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  itemCount: _filteredUsers.length,
                                  itemBuilder: (context, index) {
                                    return UserWidget(users: _filteredUsers[index]);
                                  },
                                ),
                              ),
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
