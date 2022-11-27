import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit()
      : super(TodoListState(
          todos: [
            Todo(id: '1', desc: 'Clean the room'),
            Todo(id: '2', desc: 'Wash dishes'),
            Todo(id: '3', desc: 'Do Home work'),
          ],
        ));

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed!,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void removeTodo(Todo todo) {
    final newTodos = state.todos.where((Todo t) => t.id != todo.id).toList();
    emit(state.copyWith(todos: newTodos));
  }
}
