# 📌 todo_app

Aplicación móvil en Flutter para la **gestión de tareas (To-Do List)**.  
Este proyecto forma parte de la **macroactividad de Gestión de Interfaces**.

---

## 📅 Semana 1 - Entregable
- Planteamiento del problema: necesidad de una aplicación para organizar y gestionar tareas personales de manera simple.  
- Objetivo: desarrollar una aplicación móvil multiplataforma en **Flutter** que permita añadir, listar y eliminar tareas.  
- Herramientas seleccionadas: Flutter, VS Code, GitHub, Justinmind (para wireframes).  

---

## 📅 Semana 2 - Entregable
- Diseño de wireframes iniciales en **Justinmind** con tres pantallas principales:  
  1. Pantalla de inicio.  
  2. Pantalla de lista de tareas.  
  3. Pantalla de añadir tarea.  
- Definición de requisitos mínimos:  
  - Añadir tareas.  
  - Listar tareas pendientes.  
  - Eliminar tareas completadas o no deseadas.  
- Plan de desarrollo por semanas.  

---

## 🚀 Semana 3 - Entregable
Estructura base creada con **MaterialApp** y **Scaffold**.

### 📂 Estructura principal

todo_app/
├─ lib/
│ └─ main.dart
├─ pubspec.yaml
└─ ...

---

## 🚀 Semana 4 - Entregable
Implementación de una **lista de tareas estática** usando `ListView`, con un **AppBar azul** y botón de añadir.

---

## 🚀 Semana 5 - Entregable
Interactividad implementada:  
- **Añadir tareas** mediante un diálogo (`AlertDialog`).  
- **Marcar tareas como completadas** con `CheckboxListTile` (con tachado de texto).  
- **Eliminar tareas** usando botón de papelera o deslizando (`Dismissible`).  

---

## 🚀 Semana 6 - Entregable
Se añadieron **animaciones y feedback visual**:  
- **AnimatedList** para entrada/salida con efectos Fade y Slide.  
- **AnimatedContainer** y `AnimatedDefaultTextStyle` para cambios suaves al marcar tareas.  
- **SnackBar con acción “Deshacer”** al eliminar.  
- **Haptic feedback** (vibración ligera en móviles) al completar o eliminar tareas.  

---

## 🚀 Semana 7 - Entregable
Se implementó la **gestión de estado global con Provider**:  
- Creación de un modelo `TareasProvider` que centraliza la lista de tareas.  
- Métodos globales para añadir, eliminar y marcar tareas.  
- Uso de `notifyListeners()` para actualizar la UI automáticamente.  
- Envolvimiento de la app en `ChangeNotifierProvider` para inyectar el estado global.  
- La UI ahora utiliza `context.watch` y `context.read` en lugar de `setState`, haciendo el código más limpio y escalable.  

---

## 🚀 Semana 8 - Entregable
- Pruebas de usabilidad con 2–3 usuarios (añadir, completar, eliminar, casos inválidos).
- Validaciones: evitar vacíos y duplicados.
- Accesibilidad básica (tooltips, Semantics).
- (Opcional) Persistencia local.
- Build final (APK/Web) y checklist de entrega.

---

## 📅 Plan de desarrollo
- **Semana 1:** Planteamiento del problema, objetivos y herramientas.  
- **Semana 2:** Wireframes iniciales y definición de requisitos.  
- **Semana 3:** Estructura base con `MaterialApp` y `Scaffold`.  
- **Semana 4:** UI estática (lista de tareas y AppBar).  
- **Semana 5:** Interactividad (añadir/ marcar/ eliminar tareas con `setState`, diálogo y `Dismissible`).  
- **Semana 6:** Animaciones y feedback (AnimatedList, Fade/Slide, AnimatedContainer, SnackBar con Deshacer).  
- **Semana 7:** Gestión de estado global (Provider).  
- **Semana 8:** Pruebas de usabilidad, ajustes finales y entrega.  

---

## 🚀 Semana 8 - Entregable
- Pruebas de usabilidad con 3 usuarios:  
  - T1: añadir 2 tareas, marcar 1, eliminar 1.  
  - T2: intentar añadir tarea vacía (bloqueada).  
  - T3: intentar duplicada (bloqueada).  
- Validaciones: evitar vacíos/duplicados.  
- Confirmación antes de eliminar con papelera.  
- Footer con texto: **"by LAMS © 2025"**.  
- APK en release generado e instalado en dispositivo real.

---

## 👨‍💻 Autor
Luis Alfredo Martínez Sarabia
Proyecto académico - Gestión de Interfaces ISTE
