import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../task.dart';


class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  // Función para cambiar el valor booleano (completar tarea)
  void toggleTaskCompletion(Task task) {
    state = state.map((t) {
      return t == task ? task.copyWith(isCompleted: !task.isCompleted) : t;
    }).toList();
  }

  // Función para actualizar el título de la tarea
  void updateTaskTitle(Task task, String newTitle) {
    state = state.map((t) {
      return t == task ? task.copyWith(title: newTitle) : t;
    }).toList();
  }

  // Función para agregar una nueva tarea
  void addTask(String title) {
    state = [...state, Task(title: title)];
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
