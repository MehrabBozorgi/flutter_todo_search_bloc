import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/todo_model.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  TodoFilterBloc() : super(const TodoFilterState(filter: Filter.all)) {
    on<ChangeFilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.newFilter));
    });
  }
}
