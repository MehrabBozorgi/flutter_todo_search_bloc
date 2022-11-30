part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();
}

class SetSearchTermEvent extends TodoSearchEvent {
  final String newSearchTerms;

  const SetSearchTermEvent({required this.newSearchTerms});

  @override
  List<Object> get props => [newSearchTerms];

  SetSearchTermEvent copyWith({String? newSearchTerms}) {
    return SetSearchTermEvent(
        newSearchTerms: newSearchTerms ?? this.newSearchTerms);
  }
}
