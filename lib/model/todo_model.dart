import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter {
  all,
  active,
  completed,
}

Uuid uuid = const Uuid();

class Todo extends Equatable {
  String? id;
  final String desc;
  bool? completed;

  Todo({
    this.id,
    required this.desc,
    this.completed = false,
  }) {
    id = id ?? uuid.v4();
  }

  @override
  List<Object> get props => [id!, desc, completed!];

  @override
  String toString() {
    return 'Todo{id: $id, desc: $desc, completed: $completed}';
  }

  Todo copyWith({
    String? id,
    String? desc,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      completed: completed ?? this.completed,
    );
  }
}
