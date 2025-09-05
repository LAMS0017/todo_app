import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la etiqueta "DEBUG"
      title: 'Mi Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Pantalla inicial
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Lista de Tareas"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido a la App To-Do",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Más adelante: navegar a lista de tareas
              },
              child: Text("Ver tareas"),
            ),
            ElevatedButton(
              onPressed: () {
                // Más adelante: navegar a pantalla de añadir tarea
              },
              child: Text("Añadir tarea"),
            ),
          ],
        ),
      ),
    );
  }
}
