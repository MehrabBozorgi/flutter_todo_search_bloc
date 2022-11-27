import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/todo_model.dart';

part 'todo_state.dart';

class TodoFilterCubit extends Cubit<TodoFilterState> {
  TodoFilterCubit() : super(const TodoFilterState(filter: Filter.all));

  void changeFilter(Filter newFilter) {
    emit(state.copyWith(filter: newFilter));
  }
}
