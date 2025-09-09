import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
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
      home: HomeScreen(),
    );
  }
}

class Tarea {
  String texto;
  bool done;
  Tarea(this.texto, {this.done = false});
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _tareas = <Tarea>[
    Tarea("Comprar víveres"),
    Tarea("Estudiar Flutter"),
    Tarea("Hacer ejercicio"),
    Tarea("Leer un libro"),
  ];
  final _ctrl = TextEditingController();

  // ====== Añadir ======
  void _agregarTarea(String texto) {
    final clean = texto.trim();
    if (clean.isEmpty) return;
    final index = _tareas.length;
    setState(() => _tareas.add(Tarea(clean)));
    _listKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 350));
    _ctrl.clear();
    Navigator.of(context).maybePop();
    _snack("Tarea añadida");
  }

  // ====== Eliminar con animación + deshacer ======
  Tarea? _ultimaBorrada;
  int? _ultimoIndex;

  void _eliminarTarea(int index) {
    _ultimaBorrada = _tareas[index];
    _ultimoIndex = index;

    final removed = _tareas.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildAnimatedTile(removed, index, animation, isRemoving: true),
      duration: const Duration(milliseconds: 350),
    );

    HapticFeedback.selectionClick();
    _snack(
      "Eliminada: ${removed.texto}",
      action: SnackBarAction(
        label: "Deshacer",
        onPressed: _deshacerBorrado,
      ),
    );
  }

  void _deshacerBorrado() {
    if (_ultimaBorrada == null || _ultimoIndex == null) return;
    final idx = _ultimoIndex!.clamp(0, _tareas.length);
    setState(() => _tareas.insert(idx, _ultimaBorrada!));
    _listKey.currentState?.insertItem(idx, duration: const Duration(milliseconds: 350));
    _ultimaBorrada = null;
    _ultimoIndex = null;
  }

  // ====== Completar ======
  void _toggleDone(int index, bool? value) {
    setState(() => _tareas[index].done = value ?? false);
    HapticFeedback.lightImpact();
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
          TextButton(onPressed: () { _ctrl.clear(); Navigator.pop(context); }, child: const Text("Cancelar")),
          ElevatedButton(onPressed: () => _agregarTarea(_ctrl.text), child: const Text("Añadir")),
        ],
      ),
    );
  }

  void _snack(String msg, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), action: action, duration: const Duration(seconds: 3)),
    );
  }

  // ====== UI ======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Lista de Tareas"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _dialogoNuevaTarea, tooltip: "Añadir tarea"),
        ],
      ),
      body: _tareas.isEmpty
          ? const Center(child: Text("No hay tareas. ¡Añade la primera!"))
          : AnimatedList(
              key: _listKey,
              initialItemCount: _tareas.length,
              itemBuilder: (context, index, animation) =>
                  _buildAnimatedTile(_tareas[index], index, animation),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _dialogoNuevaTarea,
        child: const Icon(Icons.add),
        tooltip: "Añadir tarea",
      ),
    );
  }

  // Ítem animado (entrada/salida + cambios de estado suaves)
  Widget _buildAnimatedTile(Tarea t, int index, Animation<double> animation, {bool isRemoving = false}) {
    final slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
    final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);

    return SizeTransition(
      sizeFactor: fade,
      child: FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: Dismissible(
            key: ValueKey("${t.texto}-$index-${t.done}"),
            background: Container(
              color: Colors.red, alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _eliminarTarea(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: t.done ? Colors.green.withOpacity(0.10) : Colors.transparent,
              child: CheckboxListTile(
                value: t.done,
                onChanged: (v) => _toggleDone(index, v),
                title: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    decoration: t.done ? TextDecoration.lineThrough : TextDecoration.none,
                    color: t.done ? Colors.grey : Colors.black,
                    fontSize: 16,
                  ),
                  child: Text(t.texto),
                ),
                secondary: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _eliminarTarea(index),
                  tooltip: "Eliminar",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
