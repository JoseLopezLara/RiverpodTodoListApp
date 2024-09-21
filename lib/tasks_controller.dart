import 'package:flutter/material.dart';
import 'package:riverpod_change_notifier_provider/tasks.dart';

//TODO: ACTIVIDAD:
/*1. En cada item de la lista de tareas deben de añadir un widget checkbox. Este check box debe de marcar subrallar la tarea como completada y cambiar el valor booleano llando a la función que ya les cree.

  2. Deben de añadir un IncoButton de editar en cada item de la lista. Este botón debe llamar en el onpressed:
    2.1 A la venta emergente y esta debe de tener en el
    text fiel el titula de la tarea para que el usuario unicamnte lo edite y de en guardar.
      2.1.1 En el onpresed de la accion de la ventana emergente deben 
      de llamar a la función que se encargará de actualizar el titulo de la tarea (Usa coppy with y basate en la función que se encarga de cambiar el valor booleano).*/

class TasksController extends ChangeNotifier {
//PASO 1: Mi sección de propiedades (Variables, objetos, repositios, etc)
  List<Task> _tasks = [];

//PASO 2: Tu seccion de getters
  List<Task> get getTasks => _tasks;

//PASO 3: Tu sección de funciones que efectuan la logica de tu frontend
  void addTask(String title) {
    //PASO 3.1 Logica de la función: Notificar cambio realizado
    final newTask = Task(title: title);
    _tasks = [..._tasks, newTask];

    //PASO 3.2: Notificar cambio realizado
    notifyListeners();
  }

  void toggleTaskCompletation(int index) {
    final task = _tasks[index];
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    _tasks = List<Task>.from(_tasks)..[index] = updatedTask;

    notifyListeners();
  }
}
