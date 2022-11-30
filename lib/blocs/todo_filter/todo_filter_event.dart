part of 'todo_filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();
}

class ChangeFilterEvent extends TodoFilterEvent {
  final Filter newFilter;

  const ChangeFilterEvent({required this.newFilter});

  @override
  String toString() {
    return 'ChangeFilterEvent{newFilter: $newFilter}';
  }

  @override
  List<Object> get props => [newFilter];

  ChangeFilterEvent copyWith({Filter? newFilter}) {
    return ChangeFilterEvent(newFilter: newFilter ?? this.newFilter);
  }
}
