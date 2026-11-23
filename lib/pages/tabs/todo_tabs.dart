import 'package:flutter/material.dart';
import 'package:json_placehlder/model/todos.dart';
import 'package:json_placehlder/service/api_service.dart';
import 'package:json_placehlder/widget/async_data_view.dart';
import 'package:json_placehlder/widget/todos_widget.dart';

class TodoTabs extends StatelessWidget {
  const TodoTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Todos>(
      onFetch: ApiService.fetchTodos,
      itemBuilder: (context, todos, index) {
        return TodosWidget(todos: todos);
      },
      title: 'Todos',
    );
  }
}

typedef TodoStabs = TodoTabs;
