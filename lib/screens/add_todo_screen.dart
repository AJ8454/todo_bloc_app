import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            _inputField("ID", controllerId),
            _inputField("Task", controllerTask),
            _inputField("Description", controllerDescription),
            ElevatedButton(
              onPressed: () {
                var todo = Todo(
                  id: controllerId.value.text,
                  task: controllerTask.value.text,
                  description: controllerDescription.value.text,
                );
              },
              child: const Text("Add To Do"),
            ),
          ],
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
