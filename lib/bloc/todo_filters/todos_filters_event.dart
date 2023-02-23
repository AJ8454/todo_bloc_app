part of 'todos_filters_bloc.dart';

abstract class TodosFiltersEvent extends Equatable {
  const TodosFiltersEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TodosFiltersEvent {
  const UpdateFilter();

  @override
  List<Object> get props => [];
}

class UpdateTodos extends TodosFiltersEvent {
  final TodosFilter todosFilter;
  const UpdateTodos({this.todosFilter = TodosFilter.all});

  @override
  List<Object> get props => [todosFilter];
}
