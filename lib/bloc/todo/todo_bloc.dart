import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc_app/models/todos_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  TodosBloc() : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodos>(_onAddTodos);
    on<UpdateTodos>(_onUpdateTodos);
    on<DeleteTodos>(_onDeleteTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  void _onAddTodos(AddTodos event, Emitter<TodosState> emit) {}

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosState> emit) {}

  void _onDeleteTodos(DeleteTodos event, Emitter<TodosState> emit) {}
}
