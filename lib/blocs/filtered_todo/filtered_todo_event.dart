part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoEvent extends Equatable {
  const FilteredTodoEvent();
}

class CalculateFilteredTodoEvent extends FilteredTodoEvent {
  final List<Todo> filteredTodo;

  const CalculateFilteredTodoEvent({required this.filteredTodo});

  CalculateFilteredTodoEvent copyWith({List<Todo>? filteredTodo}) {
    return CalculateFilteredTodoEvent(
        filteredTodo: filteredTodo ?? this.filteredTodo);
  }

  @override
  List<Object> get props => [filteredTodo];
}
