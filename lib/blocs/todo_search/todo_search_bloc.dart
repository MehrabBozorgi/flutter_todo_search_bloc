import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(const TodoSearchState(searchTerm: '')) {
    on<SetSearchTermEvent>(
      (event, emit) {
        emit(state.copyWith(searchTerm: event.newSearchTerms));
      },
      transformer: debounce(
        const Duration(milliseconds: 2000),
      ),
    );
  }

  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(
      Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }
}
