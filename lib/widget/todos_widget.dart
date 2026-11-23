import 'package:flutter/material.dart';
import 'package:json_placehlder/model/todos.dart';

class TodosWidget extends StatefulWidget {
  final Todos todos;

  const TodosWidget({super.key, required this.todos});

  @override
  State<TodosWidget> createState() => _TodosWidgetState();
}

class _TodosWidgetState extends State<TodosWidget> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.todos.completed;
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
        onTap: () {
          setState(() {
            _isCompleted = !_isCompleted;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox yang berfungsi interaktif
              Transform.scale(
                scale: 0.95,
                child: Checkbox(
                  value: _isCompleted,
                  activeColor: const Color(0xFF526B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: const BorderSide(color: Color(0xFF737B89), width: 1.5),
                  onChanged: (bool? value) {
                    setState(() {
                      _isCompleted = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),

              // Detail Todo (ID, Badge Status, Judul)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
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
                              '#${widget.todos.id}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF526B9A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _isCompleted
                                  ? const Color(0xFFEAF0F8)
                                  : const Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _isCompleted
                                    ? const Color(0xFF526B9A)
                                    : const Color(0xFFE5E8ED),
                              ),
                            ),
                            child: Text(
                              _isCompleted ? 'Selesai' : 'Belum Selesai',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _isCompleted
                                    ? const Color(0xFF526B9A)
                                    : const Color(0xFF737B89),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.todos.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _isCompleted
                              ? const Color(0xFF737B89)
                              : const Color(0xFF252A34),
                          decoration: _isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
