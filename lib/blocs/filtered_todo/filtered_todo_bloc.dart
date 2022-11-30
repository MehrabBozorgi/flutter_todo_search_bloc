import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/todo_model.dart';

part 'filtered_todo_event.dart';
part 'filtered_todo_state.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  final List<Todo> initialTodos;

  FilteredTodoBloc({required this.initialTodos})
      : super(FilteredTodoState(filteredTodo: initialTodos)) {
    on<CalculateFilteredTodoEvent>((event, emit) {
      emit(state.copyWith(filteredTodo: event.filteredTodo));
    });
  }

  void setFilteredTodos(Filter filter, List<Todo> todos, String searchTerm) {
    List<Todo> filterTodos;

    switch (filter) {
      case Filter.active:
        filterTodos = todos.where((Todo todo) => !todo.completed!).toList();
        break;

      case Filter.completed:
        filterTodos = todos.where((Todo todo) => todo.completed!).toList();
        break;

      case Filter.all:
      default:
        filterTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filterTodos = filterTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }
    emit(state.copyWith(filteredTodo: filterTodos));
  }
}
