import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
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
      debugShowCheckedModeBanner: false, // quita el banner de debug
      title: 'Mi Lista de Tareas',       // nombre de la app (visible al abrir)
      theme: ThemeData(
        primarySwatch: Colors.blue,      // paleta de colores
      ),
      home: const HomeScreen(),          // pantalla principal
    );
  }
}
