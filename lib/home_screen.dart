import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tareas_provider.dart';
import 'add_task_screen.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _confirmarEliminar(BuildContext context, int index, String texto) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmar eliminación"),
        content: Text("¿Quieres eliminar la tarea \"$texto\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TareasProvider>().eliminar(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Eliminada: $texto')),
              );
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tareas = context.watch<TareasProvider>().tareas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Lista de Tareas"),
        backgroundColor: Colors.blue,
      ),
      body: tareas.isEmpty
          ? const Center(child: Text("No hay tareas. ¡Añade la primera!"))
          : ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final t = tareas[index];
                return ListTile(
                  leading: Checkbox(
                    value: t.done,
                    onChanged: (v) =>
                        context.read<TareasProvider>().toggle(index, v ?? false),
                  ),
                  title: Text(
                    t.texto,
                    style: TextStyle(
                      decoration: t.done ? TextDecoration.lineThrough : null,
                      color: t.done ? Colors.grey : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Eliminar',
                    onPressed: () => _confirmarEliminar(context, index, t.texto),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskDetailScreen(
                          texto: t.texto,
                          done: t.done,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: "Añadir tarea",
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey[200],
        child: const Text(
          "by LAMS © 2025",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
