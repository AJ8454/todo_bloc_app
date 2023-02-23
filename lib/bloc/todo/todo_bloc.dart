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

  void _onAddTodos(AddTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = state.todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();
      emit(TodoLoaded(todos: todos));
    }
  }

  void _onDeleteTodos(DeleteTodos event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos =
          state.todos.where((todo) => todo.id != event.todo.id).toList();
      emit(TodoLoaded(todos: todos));
    }
  }
}
