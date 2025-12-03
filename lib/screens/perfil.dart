import 'package:flutter/material.dart';
import 'package:convive_app/screens/home.dart';
import 'package:convive_app/screens/conversaciones_vecinos.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen>
    with SingleTickerProviderStateMixin {
  final int _currentBottomNavIndex = 3;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(() {
    //   setState(() {
    //     _selectedTab = _tabController.index;
    //   });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      setState(() {});
    } else if (index == 2) {
      // Chats → ConversacionesVecinosScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConversacionesVecinosScreen()),
      );
    } else if (index == 3) {
      // Mi Perfil → se queda en PerfilScreen
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Mi perfil',
          style: TextStyle(
            color: cs.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: cs.onSurface),
            onPressed: () {
              // Acción para configuración
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner de perfil con foto superpuesta
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner oscuro con elemento curvo
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cs.secondary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Elemento curvo claro a la izquierda
                      Positioned(
                        left: -50,
                        top: -20,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: cs.secondaryContainer.withAlpha(
                              (0.2 * 255).round(),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Foto de perfil superpuesta
                Positioned(
                  left: 0,
                  right: 0,
                  top: 120,
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: cs.surface,
                      child: CircleAvatar(
                        radius: 47,
                        backgroundColor: cs.surfaceContainerHighest,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            // Nombre y fecha de membresía
            Text(
              'Julian Gómez',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Miembro desde junio 2025',
              style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            // Botones Editar perfil y Compartir
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Acción para editar perfil
                      },
                      icon: Icon(Icons.edit, color: cs.onSecondary, size: 18),
                      label: Text(
                        'Editar perfil',
                        style: TextStyle(
                          color: cs.onSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Acción para compartir
                      },
                      icon: Icon(
                        Icons.share,
                        color: cs.onSurfaceVariant,
                        size: 18,
                      ),
                      label: Text(
                        'Compartir',
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: cs.surface,
                        side: BorderSide(color: cs.outline),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Sección Medallas de honor
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medallas de honor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Acción para ver todos
                        },
                        child: Text(
                          'Ver todos',
                          style: TextStyle(
                            fontSize: 14,
                            color: cs.secondaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Barra de progreso
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Progreso hacia 'Heroe vecinal'",
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          minHeight: 8,
                          backgroundColor: cs.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            cs.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Medallas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMedalla(context, 'Primeros auxilios', true),
                      _buildMedalla(context, 'Pilar Comunitario', true),
                      _buildMedalla(context, 'Héroe Vecinal', false),
                      _buildMedalla(context, 'Mentor Vecinal', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Tabs de navegación
            Container(
              color: cs.surface,
              child: TabBar(
                controller: _tabController,
                indicatorColor: cs.secondaryContainer,
                labelColor: cs.onSurface,
                unselectedLabelColor: cs.onSurfaceVariant,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Información'),
                  Tab(text: 'Comunidad'),
                  Tab(text: 'Actividad'),
                ],
              ),
            ),
            // Contenido de los tabs
            Container(
              color: cs.surface,
              child: SizedBox(
                height: 400,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildInformacionTab(),
                    _buildComunidadTab(),
                    _buildActividadTab(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
          selectedItemColor: cs.secondaryContainer,
          unselectedItemColor: cs.onSurfaceVariant,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
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

  Widget _buildMedalla(BuildContext context, String nombre, bool obtenida) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: obtenida ? cs.secondary : cs.surfaceContainerHighest,
          child: Icon(
            Icons.star,
            color: obtenida ? cs.onSecondary : cs.onSurfaceVariant,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            nombre,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInformacionTab() {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Información personal
          Text(
            'Información personal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            context,
            Icons.location_on,
            'Dirección',
            'Av. Fernando Castillo Velasco',
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            context,
            Icons.email,
            'Email',
            'Julian.gomezzz@gmail.com',
          ),
          const SizedBox(height: 16),
          _buildInfoItem(context, Icons.phone, 'Teléfono', '+569 6123 6795'),
          const SizedBox(height: 32),
          // Habilidades y Servicios
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Habilidades y Servicios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Acción para editar
                },
                child: Text(
                  'Editar',
                  style: TextStyle(
                    fontSize: 14,
                    color: cs.secondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag(context, 'Cuidado de mascotas'),
              _buildTag(context, 'Primeros auxilios'),
              _buildTag(context, 'Jardinería'),
              _buildTag(context, 'Construcción'),
              _buildTag(context, 'Clases de Inglés'),
            ],
          ),
          const SizedBox(height: 32),
          // Intereses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Intereses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Acción para editar
                },
                child: Text(
                  'Editar',
                  style: TextStyle(
                    fontSize: 14,
                    color: cs.secondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag(context, 'Mascotas'),
              _buildTag(context, 'Jardinería'),
              _buildTag(context, 'Lectura'),
              _buildTag(context, 'Eventos Comunitarios'),
              _buildTag(context, 'Sostenibilidad'),
              _buildTag(context, 'Ingles'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComunidadTab() {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        'Contenido de Comunidad',
        style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant),
      ),
    );
  }

  Widget _buildActividadTab() {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        'Contenido de Actividad',
        style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: cs.surfaceContainerHighest,
          child: Icon(icon, color: cs.onSurfaceVariant, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: cs.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
