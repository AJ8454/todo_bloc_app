part of 'todos_filters_bloc.dart';

abstract class TodosFiltersState extends Equatable {
  const TodosFiltersState();

  @override
  List<Object> get props => [];
}

class TodosFiltersLoading extends TodosFiltersState {}

class TodosFiltersLoaded extends TodosFiltersState {
  final List<Todo> filteredTodos;
  final TodosFilter todosFilter;

  const TodosFiltersLoaded({
    required this.filteredTodos,
    this.todosFilter = TodosFilter.all,
  });

  @override
  List<Object> get props => [filteredTodos, todosFilter];
}
