import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/cubit.dart';
import 'package:flutter_todo_cubit/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
            initialActiveTodoCount:
                context.read<TodoListCubit>().state.todos.length,
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<FilteredTodoCubit>(
          create: (context) => FilteredTodoCubit(
            initialTodos:context.read<TodoListCubit>().state.todos,
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
      ],
      child: const MaterialApp(
        home: TodoScreen(),
      ),
    );
  }
}
