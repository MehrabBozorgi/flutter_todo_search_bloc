import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc()
      : super(TodoListState(todos: [
          Todo(id: '1', desc: 'Clean the room'),
          Todo(id: '2', desc: 'Wash dishes'),
          Todo(id: '3', desc: 'Do Home work'),
        ])) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<RemoveTodoEvent>(_removeTodo);
    on<ToggleTodoEvent>(_toggleTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = Todo(desc: event.todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: event.todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: todo.desc,
          completed: !todo.completed!,
        );
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos =
        state.todos.where((Todo t) => t.id != event.todo.id).toList();
    emit(state.copyWith(todos: newTodos));
  }
}
