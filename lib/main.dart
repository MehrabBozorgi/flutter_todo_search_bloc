import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/screens/todo_screen.dart';

import 'blocs/blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<ActiveTodoCountBloc>(
            create: (context) => ActiveTodoCountBloc(
                initialActiveTodoCount:
                    context.read<TodoListBloc>().state.todos.length)),
        BlocProvider<FilteredTodoBloc>(
            create: (context) => FilteredTodoBloc(
                initialTodos: context.read<TodoListBloc>().state.todos)),
      ],
      child: const MaterialApp(
        home: TodoScreen(),
      ),
    );
  }
}
