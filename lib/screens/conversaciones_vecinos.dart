import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_1/screens/home.dart';
// import 'package:flutter_application_1/screens/products.dart';

// import 'package:convive_app/screens/splashscreen.dart'; // comentado: no usado aquí
// import 'package:convive_app/screens/ofrecer.dart';
import 'package:convive_app/screens/home.dart';
import 'package:convive_app/screens/perfil.dart';
import 'package:convive_app/screens/enviar_solicitud.dart';
// import 'package:convive_app/screens/enviar_solicitud.dart';
// import 'package:convive_app/screens/products.dart';
// import 'package:convive_app/screens/login.dart';
// import 'package:convive_app/theme/theme.dart'; // comentado: no usado aquí

class ConversacionesVecinosScreen extends StatefulWidget {
  const ConversacionesVecinosScreen({super.key});

  

  @override
  State<ConversacionesVecinosScreen> createState() =>
      _ConversacionesVecinosScreenState();
}

class _ConversacionesVecinosScreenState
    extends State<ConversacionesVecinosScreen> {

  void _addContact(BuildContext context) async {
    final cs = Theme.of(context).colorScheme;
    final nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        final dialogCs = Theme.of(dialogContext).colorScheme;
        return Dialog(
          backgroundColor: dialogCs.surface,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Agregar contacto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: dialogCs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: dialogCs.onSurfaceVariant),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: dialogCs.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: dialogCs.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: dialogCs.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: TextStyle(color: dialogCs.onSurface),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: dialogCs.onSurfaceVariant),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dialogCs.primary,
                          foregroundColor: dialogCs.onPrimary,
                        ),
                        onPressed: () async {
                          final name = nameController.text.trim();
                          if (name.isNotEmpty) {
                            await FirebaseFirestore.instance
                                .collection('vecinos')
                                .add({
                                  'name': name,
                                  'timestamp': FieldValue.serverTimestamp(),
                                });
                          }
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _editContact(BuildContext context, String contactId, String currentName) async {
    final cs = Theme.of(context).colorScheme;
    final nameController = TextEditingController(text: currentName);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        final dialogCs = Theme.of(dialogContext).colorScheme;
        return Dialog(
          backgroundColor: dialogCs.surface,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Editar contacto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: dialogCs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: dialogCs.onSurfaceVariant),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: dialogCs.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: dialogCs.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: dialogCs.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: TextStyle(color: dialogCs.onSurface),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: dialogCs.onSurfaceVariant),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dialogCs.primary,
                          foregroundColor: dialogCs.onPrimary,
                        ),
                        onPressed: () async {
                          final name = nameController.text.trim();
                          if (name.isNotEmpty && name != currentName) {
                            await FirebaseFirestore.instance
                                .collection('vecinos')
                                .doc(contactId)
                                .update({
                                  'name': name,
                                  'timestamp': FieldValue.serverTimestamp(),
                                });
                          }
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteContact(BuildContext context, String contactId, String contactName) async {
    final cs = Theme.of(context).colorScheme;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final dialogCs = Theme.of(context).colorScheme;
        return AlertDialog(
          title: Text(
            'Eliminar contacto',
            style: TextStyle(color: dialogCs.onSurface),
          ),
          content: Text(
            '¿Estás seguro de que deseas eliminar a $contactName?',
            style: TextStyle(color: dialogCs.onSurfaceVariant),
          ),
          backgroundColor: dialogCs.surface,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Cancelar',
                style: TextStyle(color: dialogCs.onSurfaceVariant),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await FirebaseFirestore.instance
          .collection('vecinos')
          .doc(contactId)
          .delete();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$contactName eliminado'),
            backgroundColor: cs.secondary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }


  int _selectedSegment = 1; // 0 = Comunidades, 1 = Vecinos
  final TextEditingController _searchController = TextEditingController();
  int _currentBottomNavIndex = 2; // Chats está activo

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Explorar → HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
      
    } else if (index == 1) {
      // Inicio → EnviarSolicitudScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EnviarSolicitudScreen()),
      );
    } else if (index == 2) {
      // Chats → se queda en ConversacionesVecinosScreen
      setState(() => _currentBottomNavIndex = index);
      
    } else if (index == 3) {
      // Mi Perfil → PerfilScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PerfilScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: cs.secondaryContainer, // Azul claro de fondo
      appBar: AppBar(
        backgroundColor: cs.secondary, // Azul del header
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Conversaciones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white, size: 20),
              onPressed: () {
                // Acción para editar/componer
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: cs.secondary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Column(
        children: [
          // Control segmentado
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSegment = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedSegment == 0
                                ? cs.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Comunidades',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedSegment == 0
                              ? cs.primary
                              : Colors.grey,
                          fontWeight: _selectedSegment == 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSegment = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedSegment == 1
                                ? cs.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Vecinos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedSegment == 1
                              ? cs.primary
                              : Colors.grey,
                          fontWeight: _selectedSegment == 1
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Barra de búsqueda
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar Vecinos...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Lista horizontal de contactos frecuentes
          Container(
            height: 100,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('vecinos')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                final cs = Theme.of(context).colorScheme;
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Error al cargar contactos',
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: docs.length + 1, // +1 para el botón "Añadir"
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Botón "Añadir"
                      return GestureDetector(
                        onTap: () => _addContact(context),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: cs.secondary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Añadir',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final doc = docs[index - 1];
                    final data = doc.data() as Map<String, dynamic>;
                    final name = data['name'] ?? 'Sin nombre';
                    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

                    // Colores para los avatares usando el tema
                    final colors = [
                      cs.secondary,
                      cs.primary,
                      cs.tertiary,
                      cs.secondaryContainer,
                      cs.primaryContainer,
                      cs.tertiaryContainer,
                    ];
                    final color = colors[index % colors.length];

                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                initial,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 60,
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Lista de conversaciones
          Expanded(
            child: Container(
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('vecinos')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  final cs = Theme.of(context).colorScheme;
                  if (snapshot.hasError) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Error al cargar contactos'),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final docs = snapshot.data!.docs;

                  if (docs.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No hay contactos aún'),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final name = data['name'] ?? 'Sin nombre';
                      final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
                      final timestamp = data['timestamp'] as Timestamp?;
                      
                      // Formatear la fecha/hora
                      String horaTexto = '';
                      if (timestamp != null) {
                        final fecha = timestamp.toDate();
                        final ahora = DateTime.now();
                        final diferencia = ahora.difference(fecha);
                        
                        if (diferencia.inDays == 0) {
                          // Hoy: mostrar hora
                          horaTexto = '${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
                        } else if (diferencia.inDays == 1) {
                          horaTexto = 'Ayer';
                        } else if (diferencia.inDays < 7) {
                          horaTexto = '${diferencia.inDays}d';
                        } else {
                          horaTexto = '${fecha.day}/${fecha.month}';
                        }
                      }

                      // Colores para los avatares usando el tema
                      final colors = [
                        cs.secondary,
                        cs.primary,
                        cs.tertiary,
                        cs.secondaryContainer,
                        cs.primaryContainer,
                        cs.tertiaryContainer,
                        cs.secondary,
                        cs.primary,
                      ];
                      final color = colors[index % colors.length];

                      return InkWell(
                        onTap: () {
                          // Navegar a la conversación individual
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    initial,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Contenido
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (horaTexto.isNotEmpty)
                                              Text(
                                                horaTexto,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            PopupMenuButton<String>(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Colors.grey[600],
                                                size: 20,
                                              ),
                                              onSelected: (value) {
                                                if (value == 'edit') {
                                                  _editContact(context, doc.id, name);
                                                } else if (value == 'delete') {
                                                  _deleteContact(context, doc.id, name);
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 'edit',
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.edit, size: 20, color: cs.secondary),
                                                      const SizedBox(width: 8),
                                                      const Text('Editar'),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.delete, size: 20, color: Colors.red),
                                                      const SizedBox(width: 8),
                                                      const Text('Eliminar'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Toca para iniciar conversación',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContact(context),
        backgroundColor: cs.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.3 * 255).round()),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTap: _onBottomNavTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: cs.secondary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Mi Perfil',
            ),
          ],
        ),
      ),
    );
  }
}