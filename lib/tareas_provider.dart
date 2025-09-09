import 'package:flutter/material.dart';

class Tarea {
  String texto;
  bool done;
  Tarea(this.texto, {this.done = false});
}

class TareasProvider extends ChangeNotifier {
  final List<Tarea> _tareas = [
    Tarea("Comprar víveres"),
    Tarea("Estudiar Flutter"),
    Tarea("Hacer ejercicio"),
    Tarea("Leer un libro"),
  ];

  // Exponemos una vista de solo lectura
  List<Tarea> get tareas => List.unmodifiable(_tareas);

  void agregar(String texto) {
    final t = texto.trim();
    if (t.isEmpty) return;
    _tareas.add(Tarea(t));
    notifyListeners(); // avisa a la UI
  }

  void eliminar(int index) {
    if (index < 0 || index >= _tareas.length) return;
    _tareas.removeAt(index);
    notifyListeners();
  }

  void toggle(int index, bool value) {
    if (index < 0 || index >= _tareas.length) return;
    _tareas[index].done = value;
    notifyListeners();
  }
}
