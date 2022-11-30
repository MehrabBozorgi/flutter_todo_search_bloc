import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../model/todo_model.dart';

class TodoHeaderWidget extends StatelessWidget {
  const TodoHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.watch<ActiveTodoCountBloc>().state.activeTodoCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Todo',
          style: TextStyle(fontSize: 40),
        ),
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            final int activeCount = state.todos
                .where((Todo todo) => !todo.completed!)
                .toList()
                .length;

            context.read<ActiveTodoCountBloc>().add(
                CalculateActiveTodoCountEvent(activeTodoCount: activeCount));
          },
          child: BlocBuilder<ActiveTodoCountBloc, ActiveTodoCountState>(
            builder: (context, state) {
              return Text(
                '${state.activeTodoCount} item left',
                style: const TextStyle(fontSize: 20, color: Colors.redAccent),
              );
            },
          ),
          // child: Text(
          //   '$count item left',
          //   style: const TextStyle(fontSize: 20, color: Colors.redAccent),
          // ),
        ),
      ],
    );
  }
}
