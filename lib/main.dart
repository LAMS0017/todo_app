import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tareas_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TareasProvider(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _ctrl = TextEditingController();

  // —— UI helpers ——
  void _dialogoNuevaTarea() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Nueva tarea"),
        content: TextField(
          controller: _ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Escribe la tarea"),
          onSubmitted: (txt) => _agregar(txt),
        ),
        actions: [
          TextButton(
            onPressed: () { _ctrl.clear(); Navigator.pop(context); },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => _agregar(_ctrl.text),
            child: const Text("Añadir"),
          ),
        ],
      ),
    );
  }

  void _agregar(String txt) {
    context.read<TareasProvider>().agregar(txt);
    _ctrl.clear();
    Navigator.maybePop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Tarea añadida")));
  }

  void _eliminar(int index) {
    final p = context.read<TareasProvider>();
    final borrada = p.tareas[index].texto;
    p.eliminar(index);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Eliminada: $borrada")));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios del provider
    final tareas = context.watch<TareasProvider>().tareas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Lista de Tareas"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _dialogoNuevaTarea,
            tooltip: "Añadir tarea",
          ),
        ],
      ),
      body: tareas.isEmpty
          ? const Center(child: Text("No hay tareas. ¡Añade la primera!"))
          : ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final t = tareas[index];
                return Dismissible(
                  key: ValueKey("${t.texto}-$index-${t.done}"),
                  background: Container(
                    color: Colors.red, alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _eliminar(index),
                  child: CheckboxListTile(
                    value: t.done,
                    onChanged: (v) => context.read<TareasProvider>().toggle(index, v ?? false),
                    title: Text(
                      t.texto,
                      style: TextStyle(
                        decoration: t.done ? TextDecoration.lineThrough : null,
                        color: t.done ? Colors.grey : null,
                      ),
                    ),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _eliminar(index),
                      tooltip: "Eliminar",
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _dialogoNuevaTarea,
        child: const Icon(Icons.add),
        tooltip: "Añadir tarea",
      ),
    );
  }
}