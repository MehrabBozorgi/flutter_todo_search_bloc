import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/active_todo_count/active_todo_count_cubit.dart';

class TodoHeaderWidget extends StatelessWidget {
  const TodoHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.watch<ActiveTodoCountCubit>().state.activeTodoCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Todo',
          style: TextStyle(fontSize: 40),
        ),
        // BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
        //   builder: (context, state) {
        //     return Text(
        //       '${state.activeTodoCount} item left',
        //       style: TextStyle(fontSize: 20, color: Colors.redAccent),
        //     );
        //   },
        // ),
        Text(
          '$count item left',
          style: const TextStyle(fontSize: 20, color: Colors.redAccent),
        ),
      ],
    );
  }
}
