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
        brightness: Brightness.light, // 👈 Forzamos tema claro
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> tareas = [
    "Comprar víveres",
    "Estudiar Flutter",
    "Hacer ejercicio",
    "Leer un libro"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Lista de Tareas"),
        backgroundColor: Colors.blue,     // 👈 Azul siempre
        foregroundColor: Colors.white,    // 👈 Texto e íconos blancos
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Aquí se añadirá funcionalidad en la Semana 5
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.check_box_outline_blank),
            title: Text(tareas[index]),
            trailing: Icon(Icons.delete),
            onTap: () {
              // Aquí se añadirá funcionalidad en la Semana 5
            },
          );
        },
      ),
    );
  }
}
