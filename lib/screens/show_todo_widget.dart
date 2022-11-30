import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class ShowTodoWidget extends StatefulWidget {
  const ShowTodoWidget({Key? key}) : super(key: key);

  @override
  State<ShowTodoWidget> createState() => _ShowTodoWidgetState();
}

class _ShowTodoWidgetState extends State<ShowTodoWidget> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodoBloc>().state.filteredTodo;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            context.read<FilteredTodoBloc>().setFilteredTodos(
                  context.read<TodoFilterBloc>().state.filter,
                  state.todos,
                  context.read<TodoSearchBloc>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoFilterBloc, TodoFilterState>(
          listener: (context, state) {
            context.read<FilteredTodoBloc>().setFilteredTodos(
                  state.filter,
                  context.read<TodoListBloc>().state.todos,
                  context.read<TodoSearchBloc>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoSearchBloc, TodoSearchState>(
          listener: (context, state) {
            context.read<FilteredTodoBloc>().setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              context.read<TodoListBloc>().state.todos,
              state.searchTerm,
            );
          },
        ),
      ],
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: todos[index].completed,
                  onChanged: (bool? checked) {
                    context
                        .read<TodoListBloc>()
                        .add(ToggleTodoEvent(id: todos[index].id!));
                    // print(todos[index].id.runtimeType);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      todos[index].desc,
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<TodoListBloc>()
                            .add(RemoveTodoEvent(todo: todos[index]));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            bool error = false;
                            textEditingController.text = todos[index].desc;
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text('Edit Todo'),
                                  content: TextField(
                                    controller: textEditingController,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        errorText: error == true
                                            ? 'value can not be empty'
                                            : null),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('back'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          error =
                                              textEditingController.text.isEmpty
                                                  ? true
                                                  : false;
                                          if (!error) {
                                            context.read<TodoListBloc>().add(
                                                  EditTodoEvent(
                                                    id: todos[index].id!,
                                                    todoDesc:
                                                        textEditingController
                                                            .text,
                                                  ),
                                                );
                                            Navigator.pop(context);
                                          }
                                        });
                                      },
                                      child: const Text('edit'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          itemCount: todos.length,
        ),
      ),
    );
  }
}
