part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({required this.todos});

  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'TodoListState{todos: $todos}';
  }
}
