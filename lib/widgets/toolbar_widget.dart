import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black12;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);
    print('toolbar build tetiklendi');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            onCompletedTodoCount == 0
                ? 'Tüm Görevler OK'
                : onCompletedTodoCount.toString() + " görev tamamlandı",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                primary: changeTextColor(TodoListFilter.all)),
            onPressed: (() {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            }),
            child: const Text('All'),
          ),
        ),
        Tooltip(
          message: 'Uncompleted Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                primary: changeTextColor(TodoListFilter.active)),
            onPressed: (() {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            }),
            child: const Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Completed Todos',
          child: TextButton(
            style: TextButton.styleFrom(
                primary: changeTextColor(TodoListFilter.completed)),
            onPressed: (() {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed;
            }),
            child: const Text('Complete'),
          ),
        ),
      ],
    );
  }
}
