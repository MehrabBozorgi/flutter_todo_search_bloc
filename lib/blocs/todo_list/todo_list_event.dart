part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();
}

class AddTodoEvent extends TodoListEvent {
  final String todoDesc;

  const AddTodoEvent({required this.todoDesc});

  @override
  List<Object> get props => [todoDesc];

  AddTodoEvent copyWith({String? todoDesc}) {
    return AddTodoEvent(todoDesc: todoDesc ?? this.todoDesc);
  }
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String todoDesc;

  const EditTodoEvent({required this.id, required this.todoDesc});

  @override
  List<Object> get props => [id, todoDesc];

  EditTodoEvent copyWith({String? id, String? todoDesc}) {
    return EditTodoEvent(
      id: id ?? this.id,
      todoDesc: todoDesc ?? this.todoDesc,
    );
  }
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;

  const ToggleTodoEvent({required this.id});

  ToggleTodoEvent copyWith({String? id}) {
    return ToggleTodoEvent(id: id ?? this.id);
  }

  @override
  List<Object> get props => [id];
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;

  const RemoveTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];

  RemoveTodoEvent copyWith({Todo? todo}) {
    return RemoveTodoEvent(todo: todo ?? this.todo);
  }
}
