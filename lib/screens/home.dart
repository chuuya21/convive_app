import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:convive_app/screens/enviar_solicitud.dart';
// import 'package:convive_app/screens/products.dart';
import 'package:convive_app/screens/conversaciones_vecinos.dart';
import 'package:convive_app/screens/detalle_solicitud.dart';
import 'package:convive_app/screens/perfil.dart';
import 'package:convive_app/screens/ofrecer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedSegment = 0; // 0 = Pedir servicio, 1 = Ofrecer servicio
  final int _currentBottomNavIndex = 1; // Explorar está activo (HomeScreen)

  // Datos de ejemplo para las solicitudes de servicio (Pedir servicio)
  final List<Map<String, dynamic>> _solicitudesServicio = [
    {
      'nombre': 'Helga suarez',
      'tiempo': 'Hace 5 horas',
      'ubicacion': 'casa 202 C',
      'descripcion': 'Quiero aprender a hacer crochet para mi gato calvo que esta pasandola muy mal este invierno. Si alguién tuviese el tiempo entre findes de semana seria perfecto para mi.',
      'categorias': ['Arte & Crochet', 'Mascotas'],
      'imagen': Icons.pets,
      'color': Colors.purple,
    },
    {
      'nombre': 'Usuario2',
      'tiempo': 'Hace dos horas',
      'ubicacion': 'Casa 233 B',
      'descripcion': 'Encontre este perrito afuera del condominio. Es un perrito sin entrenamiento de aprox 3 años. Necesito conseguirle una casa temporal aunque sea por 1 mes.',
      'categorias': ['Mascotas', 'Adopción', 'Ayuda Temporal'],
      'imagen': Icons.pets,
      'color': Colors.blue,
    },
    {
      'nombre': 'Miguel ángel Soto',
      'tiempo': 'Hace 1 día',
      'ubicacion': 'casa 206 D',
      'descripcion': 'Estoy Tratando de hacer una huerta hidropónica pero no logró que crezcan mis lechugas, alguién me podría ayudar que sepa en jardineria y construcción.',
      'categorias': ['Jardineria', 'Ecología', 'Construcción'],
      'imagen': Icons.local_florist,
      'color': Colors.green,
    },
  ];

  // Datos de ejemplo para las ofertas de servicio
  final List<Map<String, dynamic>> _ofertasServicio = [
    {
      'nombre': 'Usuario1',
      'tiempo': 'Hace 5 horas',
      'ubicacion': 'casa 202 C',
      'descripcion': 'Enseño crochet para que tu gatito nunca tenga sus patitas frías. Aprender a tejer ropa abrigada para este invierno, enseñar los fines de semana 🧶',
      'categorias': ['Arte & Crochet', 'Mascotas'],
      'imagen': Icons.pets,
      'color': Colors.orange,
    },
    {
      'nombre': 'Usuario2',
      'tiempo': 'Hace dos horas',
      'ubicacion': 'Casa 233 B',
      'descripcion': 'Cuidamos perritos en casa y los entrenamos para que tengan más oportunidades de ser adoptados. Lo recibimos por uno o dos meses 🐾❤️',
      'categorias': ['Mascotas', 'Entrenamiento', 'Temporal'],
      'imagen': Icons.pets,
      'color': Colors.green,
    },
    {
      'nombre': 'Usuario3',
      'tiempo': 'Hace 1 día',
      'ubicacion': 'casa 206 D',
      'descripcion': '¿Necesitas ayuda con tu huerta? Puedo darte una mano con jardinería y estructuras hidropónicas. He trabajado en eso y quiero apoyar a alguien del barrio 🌱',
      'categorias': ['Jardineria', 'Ecología', 'Construcción'],
      'imagen': Icons.local_florist,
      'color': Colors.brown,
    },
  ];

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Inicio → EnviarSolicitudScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EnviarSolicitudScreen()),
      );
    } else if (index == 1) {
      // Explorar → se queda en HomeScreen
      setState(() {});
    } else if (index == 2) {
      // Chats → ConversacionesVecinosScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConversacionesVecinosScreen()),
      );
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF81CFFF), // Azul claro del header
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF81CFFF),
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hola, Julian123',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.black87,
                ),
                const SizedBox(width: 4),
                Text(
                  'Padre Hurtado Sur 1810',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {
              // Acción para menú de opciones
            },
          ),
        ],
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
                        'Pedir servicio',
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
                        'Ofrecer servicio',
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

          // Lista de solicitudes u ofertas según el segmento seleccionado
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _selectedSegment == 0 
                  ? _solicitudesServicio.length 
                  : _ofertasServicio.length,
              itemBuilder: (context, index) {
                final item = _selectedSegment == 0 
                    ? _solicitudesServicio[index]
                    : _ofertasServicio[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header del card con perfil
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: item['color'] as Color,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['nombre'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${item['tiempo']} | ${item['ubicacion']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Badge según el tipo
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _selectedSegment == 0 
                                    ? 'Pedir servicio'
                                    : 'Ofrecer servicio',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Descripción
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          item['descripcion'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Imagen placeholder
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Icon(
                          item['imagen'] as IconData,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Categorías
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (item['categorias'] as List<String>)
                              .map((categoria) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2196F3).withAlpha((0.1 * 255).round()),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFF2196F3).withAlpha((0.3 * 255).round()),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      categoria,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF2196F3),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Acciones (like, comentario, compartir)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite_border,
                                  color: Colors.grey),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline,
                                  color: Colors.grey),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, color: Colors.grey),
                              onPressed: () {},
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),

                      // Botón "Ver detalles"
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DetalleSolicitudScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Ver detalles',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedSegment == 0) {
            // Pedir servicio → EnviarSolicitudScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EnviarSolicitudScreen()),
            );
          } else {
            // Ofrecer servicio → OfrecerScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OfrecerScreen()),
            );
          }
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