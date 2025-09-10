import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String texto;
  final bool done;
  const TaskDetailScreen({super.key, required this.texto, required this.done});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalles de tarea")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tarea:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(texto, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text("Estado:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              done ? "✅ Completada" : "⏳ Pendiente",
              style: TextStyle(fontSize: 18, color: done ? Colors.green : Colors.orange),
            ),
          ],
        ),
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
