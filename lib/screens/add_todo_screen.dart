import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/todo/todo_bloc.dart';
import 'package:todo_bloc_app/models/todos_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Add To Do")),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodoLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("To Do Added!")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              _inputField("ID", controllerId),
              _inputField("Task", controllerTask),
              _inputField("Description", controllerDescription),
              ElevatedButton(
                onPressed: () {
                  Todo todo = Todo(
                    id: controllerId.value.text,
                    task: controllerTask.value.text,
                    description: controllerDescription.value.text,
                  );
                  context.read<TodosBloc>().add(AddTodos(todo: todo));
                  Navigator.pop(context);
                },
                child: const Text("Add To Do"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _inputField(String field, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field: ",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
