import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/blocs/blocs.dart';

class CreateTodoWidget extends StatefulWidget {
  const CreateTodoWidget({Key? key}) : super(key: key);

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();
}

class _CreateTodoWidgetState extends State<CreateTodoWidget> {
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoController,
      decoration: const InputDecoration(
        label: Text('what to do?'),
      ),
      onSubmitted: (String? todoDesc) {
        if (String != null && todoDesc!.trim().isNotEmpty) {
          context.read<TodoListBloc>().add(
                AddTodoEvent(todoDesc: newTodoController.text),
              );
          newTodoController.clear();
        }
      },
    );
  }
}
