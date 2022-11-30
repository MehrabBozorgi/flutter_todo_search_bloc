import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit/screens/search_and_filter_todo_widget.dart';
import 'package:flutter_todo_cubit/screens/show_todo_widget.dart';
import 'package:flutter_todo_cubit/screens/todo_header_widget.dart';

import 'create_todo_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children:   [
                const TodoHeaderWidget(),
                const CreateTodoWidget(),
                const SizedBox(height: 20),
                SearchAndFilterTodoWidget(),
                const SizedBox(height: 10),
                const ShowTodoWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
