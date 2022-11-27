part of 'todo_cubit.dart';

class TodoFilterState extends Equatable {
  final Filter filter;

  const TodoFilterState({required this.filter});

  TodoFilterState copyWith({Filter? filter}) {
    return TodoFilterState(filter: filter ?? this.filter);
  }

  @override
  String toString() {
    return 'TodoState{filter: $filter}';
  }

  @override
  List<Object?> get props => [filter];
}
