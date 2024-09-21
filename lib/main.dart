// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_change_notifier_provider/tasks_controller.dart';

//PASO 4: Crear provedor
final taskProvider = ChangeNotifierProvider((ref) => TasksController());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ToDoWidget(),
    );
  }
}

//PASO 5: Donde vas a usar tu provedor, debes de convertir el widget a ConsumerWidget
// No olvida añadir el WidgetRef en el contructor
class ToDoWidget extends ConsumerWidget {
  const ToDoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // PASO 6: Crear variable que permite gestionar mi gestor de estado
    final tasksState = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TODO LIST APP'),
      ),
      body: ListView.builder(
          itemCount: tasksState.getTasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                tasksState.getTasks[index].title,
                style: TextStyle(
                  decoration: tasksState.getTasks[index].isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String taskTitle = '';
                return AlertDialog(
                  title: const Text('Agregar nueva tarea'),
                  content: TextField(
                    onChanged: (value) {
                      taskTitle = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Describa la actividad a realizar',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (taskTitle.isNotEmpty) {
                          ref.read(taskProvider).addTask(taskTitle);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Agregar'),
                    )
                  ],
                );
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
