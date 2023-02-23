import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/todo/todo_bloc.dart';
import 'package:todo_bloc_app/bloc/todo_filters/todos_filters_bloc.dart';

import 'package:todo_bloc_app/models/todos_filter_model.dart';
import 'package:todo_bloc_app/models/todos_model.dart';
import 'package:todo_bloc_app/screens/add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bloc Pattern: TODO"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            )
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFiltersBloc>(context)
                      .add(const UpdateTodos(todoFilter: TodosFilter.pending));
                  break;
                case 1:
                  BlocProvider.of<TodosFiltersBloc>(context).add(
                      const UpdateTodos(todoFilter: TodosFilter.completed));
                  break;
              }
            },
            tabs: const [
              Tab(icon: Icon(Icons.pending)),
              Tab(icon: Icon(Icons.add_task)),
            ],
          ),
        ),
        body: _todos(),
      ),
    );
  }

  BlocBuilder<TodosBloc, TodosState> _todos() {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodoLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Pending To Dos:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return _todoCard(context, state.todos[index]);
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text("Something went wrong!"));
        }
      },
    );
  }

  Card _todoCard(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                context.read<TodosBloc>().add(UpdateTodos(
                      todo: todo.copyWith(isCompleted: true),
                    ));
              },
              icon: const Icon(Icons.add_task),
            ),
            IconButton(
              onPressed: () {
                context.read<TodosBloc>().add(DeleteTodos(todo: todo));
              },
              icon: const Icon(Icons.cancel),
            )
          ],
        ),
      ),
    );
  }
}
