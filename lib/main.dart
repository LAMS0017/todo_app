import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: HomeScreen(),
    );
  }
}

// -------- MODELO SIMPLE --------
class Tarea {
  String texto;
  bool done;
  Tarea(this.texto, {this.done = false});
}

// -------- PANTALLA CON ESTADO --------
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Tarea> _tareas = [
    Tarea("Comprar víveres"),
    Tarea("Estudiar Flutter"),
    Tarea("Hacer ejercicio"),
    Tarea("Leer un libro"),
  ];

  final TextEditingController _ctrl = TextEditingController();

  void _agregarTarea(String texto) {
    if (texto.trim().isEmpty) return;
    setState(() {
      _tareas.add(Tarea(texto.trim()));
    });
    _ctrl.clear();
    Navigator.of(context).pop();
    _mostrarSnack("Tarea añadida");
  }

  void _eliminarTarea(int index) {
    final borrada = _tareas[index].texto;
    setState(() {
      _tareas.removeAt(index);
    });
    _mostrarSnack("Eliminada: $borrada");
  }

  void _toggleDone(int index, bool? value) {
    setState(() {
      _tareas[index].done = value ?? false;
    });
  }

  void _mostrarSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _dialogoNuevaTarea() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Nueva tarea"),
        content: TextField(
          controller: _ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Escribe la tarea"),
          onSubmitted: _agregarTarea,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _ctrl.clear();
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => _agregarTarea(_ctrl.text),
            child: const Text("Añadir"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Lista de Tareas"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _dialogoNuevaTarea, // abrir diálogo
            tooltip: "Añadir tarea",
          ),
        ],
      ),
      body: _tareas.isEmpty
          ? const Center(child: Text("No hay tareas. ¡Añade la primera!"))
          : ListView.builder(
              itemCount: _tareas.length,
              itemBuilder: (context, index) {
                final t = _tareas[index];
                return Dismissible(
                  key: ValueKey("${t.texto}-$index"),
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _eliminarTarea(index),
                  child: CheckboxListTile(
                    value: t.done,
                    onChanged: (v) => _toggleDone(index, v),
                    title: Text(
                      t.texto,
                      style: TextStyle(
                        decoration:
                            t.done ? TextDecoration.lineThrough : null,
                        color: t.done ? Colors.grey : null,
                      ),
                    ),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _eliminarTarea(index),
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
