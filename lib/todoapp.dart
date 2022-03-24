import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/all_providers.dart';
import 'package:to_do_list/widgets/title_widget.dart';
import 'package:to_do_list/widgets/todo_list_item_widget.dart';
import 'package:to_do_list/widgets/toolbar_widget.dart';
import 'package:uuid/uuid.dart';

import 'models/todo_model.dart';

class TodoApp extends ConsumerWidget {
  final List<TodoModel> allTodos = [
    TodoModel(id: const Uuid().v4(), description: "Spora git"),
    TodoModel(id: const Uuid().v4(), description: "Alışveriş yap"),
    TodoModel(id: const Uuid().v4(), description: "Cimboma Sapla"),
  ];
  TodoApp({Key? key}) : super(key: key);
  final newTodoController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration:
                const InputDecoration(labelText: 'Neler Yapacaksın Bugün'),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                key: ValueKey(allTodos[i].id),
                child: ProviderScope(
                  overrides: [
                    currentTodoProvider.overrideWithValue(allTodos[i])
                  ],
                  child: const TodoListItemWidget(),
                )),
        ],
      ),
    );
  }
}
