import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_cubit/cubit/todo_filter/todo_cubit.dart';

import '../../model/todo_model.dart';
import '../todo_list/todo_list_cubit.dart';
import '../todo_search/todo_search_cubit.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  late StreamSubscription todoFilterSubscription;
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoListSubscription;

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;

  final List<Todo> initialTodos;

  FilteredTodoCubit({
    required this.initialTodos,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilteredTodoState(filteredTodo: initialTodos)) {
    todoFilterSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });
    todoSearchSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> filterTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        filterTodos = todoListCubit.state.todos
            .where((Todo todo) => !todo.completed!)
            .toList();
        break;

      case Filter.completed:
        filterTodos = todoListCubit.state.todos
            .where((Todo todo) => todo.completed!)
            .toList();
        break;

      case Filter.all:
      default:
        filterTodos = todoListCubit.state.todos;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      filterTodos = filterTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }
    emit(state.copyWith(filteredTodo: filterTodos));
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    return super.close();
  }
}
