import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../task.dart';
import '../task_notifier.dart';


class Item extends ConsumerWidget {
  final Task task;

  const Item({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          ref.read(taskProvider.notifier).toggleTaskCompletion(task);
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          _showEditDialog(context, task, ref);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, Task task, WidgetRef ref) {
    final TextEditingController controller = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar tarea'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Título de la tarea'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                ref.read(taskProvider.notifier).updateTaskTitle(task, controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
