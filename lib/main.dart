import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_change_notifier_provider/database/isar_helper.dart';
import 'package:riverpod_change_notifier_provider/database/user_dado.dart';
import 'package:riverpod_change_notifier_provider/models/user.dart';
import '../item.dart';
import '../task_notifier.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarHelper.instance.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi App Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona una opción')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IsarExample()),
                );
              },
              child: const Text('Ir a Pantalla de usuarios'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TaskListScreenApp()),
                );
              },
              child: const Text('Ir a Lista de Tareas'),
            ),
          ],
        ),
      ),
    );
  }
}

class IsarExample extends StatefulWidget {
  const IsarExample({super.key});

  @override
  State<IsarExample> createState() => _IsarExampleState();
}

class _IsarExampleState extends State<IsarExample> {
  final controller = TextEditingController();
  final dado = UserDado();
  //List<User> users = [];

  @override
  void initState() {
    super.initState();
    //dado.getAll().then((value) {
    //  setState(() {
    //    users = value;
    //  });
    //});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isar Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: 'Type the user name'),
                )),
                ElevatedButton(
                    onPressed: () async {
                      User user = User()..name = controller.text;
                      final id = await dado.upset(user);
                      user.id = id;
                      controller.clear();
                      //setState(() {
                      //  users.add(user);
                      //});
                    },
                    child: const Text('Create User'))
              ],
            ),
            StreamBuilder<List<User>>(
                initialData: const [],
                stream: dado.watchUsers(),
                builder: (context, snapshot) {
                  final users = snapshot.data ?? [];
                  return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (ctx, index) {
                        final user = users[index];
                        return ListTile(
                          leading: Text("${user.id}"),
                          title: Text(user.name),
                          trailing: IconButton(
                              onPressed: () {
                                dado.deleteOne(user);
                                //users.removeWhere(
                                 //   (element) => user.id == element.id);
                              },
                              icon: Icon(Icons.delete)),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}

class TaskListScreenApp extends StatelessWidget {
  const TaskListScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('No hay tareas. ¡Agrega una!'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Item(task: task);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context, ref);
        },
        tooltip: 'Agregar tarea',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar nueva tarea'),
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
              child: const Text('Agregar'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ref.read(taskProvider.notifier).addTask(controller.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
