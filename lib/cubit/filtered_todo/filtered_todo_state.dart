part of 'filtered_todo_cubit.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodo;

  const FilteredTodoState({required this.filteredTodo});

  FilteredTodoState copyWith({List<Todo>? filteredTodo}) {
    return FilteredTodoState(filteredTodo: filteredTodo ?? this.filteredTodo);
  }

  @override
  String toString() {
    return 'FilteredTodoState{filteredTodo: $filteredTodo}';
  }

  @override
  List<Object> get props => [filteredTodo];
}
