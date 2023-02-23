part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {
  final List<Todo> todos;
  const LoadTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class AddTodos extends TodoEvent {
  final Todo todo;
  const AddTodos({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodos extends TodoEvent {
  final Todo todo;
  const UpdateTodos({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodos extends TodoEvent {
  final Todo todo;
  const DeleteTodos({required this.todo});

  @override
  List<Object> get props => [todo];
}
