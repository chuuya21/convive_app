import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final int _currentBottomNavIndex = 0; // Explorar está activo (HomeScreen)

  // Datos de ejemplo para las ofertas de servicio
  final List<Map<String, dynamic>> _ofertasServicio = [
    {
      'nombre': 'Usuario1',
      'tiempo': 'Hace 5 horas',
      'ubicacion': 'casa 202 C',
      'descripcion': 'Enseño crochet para que tu gatito nunca tenga sus patitas frías. Aprender a tejer ropa abrigada para este invierno, enseñar los fines de semana 🧶',
      'categorias': ['Arte & Crochet', 'Mascotas'],
      'imagen': Icons.pets,
      'color': const Color(0xFFFF7B4A), // primary - se reemplazará dinámicamente
    },
    {
      'nombre': 'Usuario2',
      'tiempo': 'Hace dos horas',
      'ubicacion': 'Casa 233 B',
      'descripcion': 'Cuidamos perritos en casa y los entrenamos para que tengan más oportunidades de ser adoptados. Lo recibimos por uno o dos meses 🐾❤️',
      'categorias': ['Mascotas', 'Entrenamiento', 'Temporal'],
      'imagen': Icons.pets,
      'color': const Color(0xFF1ABEFF), // secondary - se reemplazará dinámicamente
    },
    {
      'nombre': 'Usuario3',
      'tiempo': 'Hace 1 día',
      'ubicacion': 'casa 206 D',
      'descripcion': '¿Necesitas ayuda con tu huerta? Puedo darte una mano con jardinería y estructuras hidropónicas. He trabajado en eso y quiero apoyar a alguien del barrio 🌱',
      'categorias': ['Jardineria', 'Ecología', 'Construcción'],
      'imagen': Icons.local_florist,
      'color': const Color(0xFF6B3DF0), // tertiary - se reemplazará dinámicamente
    },
  ];

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Explorar → se queda en HomeScreen
      setState(() {});
    } else if (index == 1) {
// Inicio → EnviarSolicitudScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EnviarSolicitudScreen()),
      );

      
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
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: cs.secondary, // Azul claro del header
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: cs.secondaryContainer,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hola, Julian Gómez',
              style: TextStyle(
                color: Colors.white,
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
                  color: Color.fromARGB(255, 237, 237, 237),
                ),
                const SizedBox(width: 4),
                Text(
                  'Padre Hurtado Sur 1810',
                  style: TextStyle(
                    color: Color.fromARGB(255, 237, 237, 237),
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
                                ? cs.primary
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
                        'Ofrecer servicio',
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

          // Lista de solicitudes u ofertas según el segmento seleccionado
          Expanded(
            child: _selectedSegment == 0
                ? _buildSolicitudesList()
                : _buildOfertasList(),
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

  Widget _buildSolicitudesList() {
    final cs = Theme.of(context).colorScheme;
    
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('solicitudes')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error al cargar solicitudes: ${snapshot.error}'),
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
              child: Text('No hay solicitudes aún'),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data() as Map<String, dynamic>;
            
            // Mapear datos de Firebase
            final tipoAyuda = data['tipoAyuda'] ?? 'otros';
            final titulo = data['titulo'] ?? 'Sin título';
            final detalles = data['detalles'] ?? 'Sin detalles';
            final userEmail = data['userEmail'] ?? 'Usuario desconocido';
            final timestamp = data['timestamp'] as Timestamp?;
            
            // Formatear tiempo relativo
            String tiempoTexto = 'Recién publicado';
            if (timestamp != null) {
              final fecha = timestamp.toDate();
              final ahora = DateTime.now();
              final diferencia = ahora.difference(fecha);
              
              if (diferencia.inDays == 0) {
                if (diferencia.inHours == 0) {
                  tiempoTexto = 'Hace ${diferencia.inMinutes} minutos';
                } else {
                  tiempoTexto = 'Hace ${diferencia.inHours} horas';
                }
              } else if (diferencia.inDays == 1) {
                tiempoTexto = 'Hace 1 día';
              } else {
                tiempoTexto = 'Hace ${diferencia.inDays} días';
              }
            }
            
            // Mapear tipo de ayuda a icono y color
            IconData icono;
            Color color;
            String labelTipo;
            
            switch (tipoAyuda) {
              case 'mascotas':
                icono = Icons.pets;
                color = cs.secondary;
                labelTipo = 'Mascotas';
                break;
              case 'mudanza':
                icono = Icons.local_shipping;
                color = cs.primary;
                labelTipo = 'Mudanza';
                break;
              case 'guardia':
                icono = Icons.shield;
                color = cs.tertiary;
                labelTipo = 'Guardia';
                break;
              default:
                icono = Icons.more_horiz;
                color = cs.tertiary;
                labelTipo = 'Otros';
            }
            
            // Nombre fijo para todas las publicaciones
            final nombreUsuario = 'Julian Gómez';
            
            final item = {
              'id': doc.id,
              'nombre': nombreUsuario,
              'tiempo': tiempoTexto,
              'ubicacion': 'Vecindario',
              'descripcion': detalles,
              'titulo': titulo,
              'categorias': [labelTipo],
              'imagen': icono,
              'color': color,
            };
            
            return _buildCard(item, true);
          },
        );
      },
    );
  }

  Widget _buildOfertasList() {
    final cs = Theme.of(context).colorScheme;
    
    // Actualizar colores de ofertas con el colorScheme
    final ofertasConColores = _ofertasServicio.map((oferta) {
      final colorIndex = _ofertasServicio.indexOf(oferta);
      Color color;
      if (colorIndex == 0) {
        color = cs.primary;
      } else if (colorIndex == 1) {
        color = cs.secondary;
      } else {
        color = cs.tertiary;
      }
      return {...oferta, 'color': color};
    }).toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ofertasConColores.length,
      itemBuilder: (context, index) {
        final item = ofertasConColores[index];
        return _buildCard(item, false);
      },
    );
  }

  Widget _buildCard(Map<String, dynamic> item, bool isSolicitud) {
    final cs = Theme.of(context).colorScheme;
    
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
                    color: cs.tertiaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isSolicitud ? 'Pedir servicio' : 'Ofrecer servicio',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: cs.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Título (si existe)
          if (item.containsKey('titulo') && item['titulo'] != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                item['titulo'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
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
                          color: cs.secondary.withAlpha((0.1 * 255).round()),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: cs.secondary.withAlpha((0.3 * 255).round()),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          categoria,
                          style: TextStyle(
                            fontSize: 12,
                            color: cs.secondary,
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
                  backgroundColor: cs.primary,
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
  }
}