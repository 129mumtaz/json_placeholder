import 'package:flutter/material.dart';

class AsyncDataView<T> extends StatefulWidget {
  final Future<List<T>> Function() onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String title;

  const AsyncDataView({
    super.key,
    required this.onFetch,
    required this.itemBuilder,
    required this.title,
  });

  @override
  State<AsyncDataView<T>> createState() => _AsyncDataViewState<T>();
}

class _AsyncDataViewState<T> extends State<AsyncDataView<T>> {
  late Future<List<T>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = widget.onFetch();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        // 1. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    color: Color(0xFF526B9A),
                    strokeWidth: 2.5,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Memuat ${widget.title}...',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF737B89),
                  ),
                ),
              ],
            ),
          );
        }

        // 2. Error State
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Color(0xFF526B9A),
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Gagal memuat ${widget.title}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF252A34),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF737B89),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleRefresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF526B9A),
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
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // 3. Empty State
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada data ${widget.title}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF737B89),
              ),
            ),
          );
        }

        // 4. Success State with Pull-to-Refresh & Responsive Layout
        return Container(
          color: const Color(0xFFF7F8FA),
          child: RefreshIndicator(
            color: const Color(0xFF526B9A),
            onRefresh: _handleRefresh,
            child: Column(
              children: [
                // Info Sub-Header Bar
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E8ED), width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 860),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF526B9A),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Total: ${items.length} ${widget.title}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xFF252A34),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Tarik ke bawah untuk refresh',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF737B89),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Responsive List View
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 860),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return widget.itemBuilder(context, items[index], index);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
