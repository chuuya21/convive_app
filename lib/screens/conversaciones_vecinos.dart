import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_application_1/screens/home.dart';
// import 'package:flutter_application_1/screens/products.dart';

// import 'package:convive_app/screens/splashscreen.dart'; // comentado: no usado aquí
import 'package:convive_app/screens/ofrecer.dart';
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
  int _selectedSegment = 1; // 0 = Comunidades, 1 = Vecinos
  final TextEditingController _searchController = TextEditingController();
  int _currentBottomNavIndex = 2; // Chats está activo

  // Datos de ejemplo para contactos frecuentes
  final List<Map<String, dynamic>> _contactosFrecuentes = [
    {
      'nombre': 'Contacto1',
      'avatar': Icons.person,
      'mensajesNoLeidos': 2,
      'color': Colors.blue,
    },
    {
      'nombre': 'Contacto2',
      'avatar': Icons.person,
      'mensajesNoLeidos': 6,
      'color': Colors.green,
    },
    {
      'nombre': 'Contacto3',
      'avatar': Icons.person,
      'mensajesNoLeidos': 5,
      'color': Colors.orange,
    },
  ];

  // Datos de ejemplo para conversaciones
  final List<Map<String, dynamic>> _conversaciones = [
    {
      'nombre': 'Contacto1',
      'ultimoMensaje': 'Salgamos a trotar mañana! Hace...',
      'hora': '10:06 AM',
      'estado': 'online', // online, away, offline
      'mensajesNoLeidos': 2,
      'avatar': Icons.person,
      'color': Colors.blue,
    },
    {
      'nombre': 'Contacto2',
      'ultimoMensaje': 'Has visto a mi gatito? Lo perdi el sá...',
      'hora': '10:06 AM',
      'estado': 'away',
      'mensajesNoLeidos': 6,
      'avatar': Icons.person,
      'color': Colors.green,
    },
    {
      'nombre': 'Contacto3',
      'ultimoMensaje': 'Me prestas tu aspiradora por favor?',
      'hora': '10:06 AM',
      'estado': 'offline',
      'mensajesNoLeidos': 0,
      'avatar': Icons.person,
      'color': Colors.orange,
    },
    {
      'nombre': 'Contacto4',
      'ultimoMensaje': 'Cuidado vecino hay un joven sospe...',
      'hora': '10:06 AM',
      'estado': 'online',
      'mensajesNoLeidos': 1,
      'avatar': Icons.person,
      'color': Colors.purple,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'online':
        return Colors.green;
      case 'away':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Inicio → HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (index == 1) {
      // Explorar → ProductsScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConversacionesVecinosScreen()), //estp hay que cambiarlo dps
      );
    } else if (index == 2) {
      // Chats → se queda en ConversacionesVecinosScreen
      setState(() => _currentBottomNavIndex = index);
    } else if (index == 3) {
      // Mi Perfil → por ahora se queda
      setState(() => _currentBottomNavIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Azul claro de fondo
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3), // Azul del header
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF2196F3),
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
                                ? Colors.orange
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
                              ? Colors.orange
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
                                ? Colors.orange
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
                              ? Colors.orange
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _contactosFrecuentes.length + 1, // +1 para el botón "Añadir"
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Botón "Añadir"
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2196F3),
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
                  );
                }

                final contacto = _contactosFrecuentes[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: contacto['color'] as Color,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              contacto['avatar'] as IconData,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          if (contacto['mensajesNoLeidos'] > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2196F3),
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Text(
                                  '${contacto['mensajesNoLeidos']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contacto['nombre'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Lista de conversaciones
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: _conversaciones.length,
                itemBuilder: (context, index) {
                  final conversacion = _conversaciones[index];
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
                          Stack(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: conversacion['color'] as Color,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  conversacion['avatar'] as IconData,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              // Indicador de estado
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: _getEstadoColor(
                                      conversacion['estado'] as String,
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                        conversacion['nombre'] as String,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      conversacion['hora'] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        conversacion['ultimoMensaje'] as String,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    if (conversacion['mensajesNoLeidos'] > 0)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF2196F3),
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 20,
                                          minHeight: 20,
                                        ),
                                        child: Text(
                                          '${conversacion['mensajesNoLeidos']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para crear nueva conversación
        },
        backgroundColor: const Color(0xFF2196F3),
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
          selectedItemColor: const Color(0xFF2196F3),
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