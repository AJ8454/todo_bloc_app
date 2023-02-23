part of 'todo_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodosState {}

class TodoLoaded extends TodosState {
  final List<Todo> todos;

  const TodoLoaded({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
