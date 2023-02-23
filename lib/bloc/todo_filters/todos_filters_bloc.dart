import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc_app/bloc/todo/todo_bloc.dart';
import 'package:todo_bloc_app/models/todos_filter_model.dart';
import 'package:todo_bloc_app/models/todos_model.dart';

part 'todos_filters_event.dart';
part 'todos_filters_state.dart';

class TodosFiltersBloc extends Bloc<TodosFiltersEvent, TodosFiltersState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosFiltersBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosFiltersLoading()) {
    on<UpdateTodos>(_onUpdateTodos);
    on<UpdateFilter>(_onUpdateFilter);
    _todosSubscription = todosBloc.stream.listen((state) {
      add(const UpdateTodos());
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodosFiltersState> emit) {
    if (state is TodosFiltersLoading) {
      add(const UpdateTodos(todosFilter: TodosFilter.pending));
    }

    if (state is TodosFiltersLoaded) {
      final state = this.state as TodosFiltersLoaded;
      add(UpdateTodos(todosFilter: state.todosFilter));
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosFiltersState> emit) {
    final state = _todosBloc.state;
    if (state is TodoLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.todosFilter) {
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.cancelled:
            return todo.isCancelled!;
          case TodosFilter.pending:
            return !(todo.isCancelled! || todo.isCompleted!);
        }
      }).toList();
      emit(TodosFiltersLoaded(filteredTodos: todos));
    }
  }
}
