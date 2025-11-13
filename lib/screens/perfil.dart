import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:convive_app/screens/enviar_solicitud.dart';
import 'package:convive_app/screens/home.dart';
import 'package:convive_app/screens/conversaciones_vecinos.dart';
// import 'package:convive_app/screens/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen>
    with SingleTickerProviderStateMixin {
  final int _currentBottomNavIndex = 3; // Mi Perfil está activo
  // int _selectedTab = 0; // 0: Información, 1: Comunidad, 2: Actividad
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
      // Inicio → EnviarSolicitudScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EnviarSolicitudScreen()),
      );
    } else if (index == 1) {
      // Explorar → HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
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

  // void _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   if (mounted) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (_) => const LoginScreen()),
  //       (route) => false,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mi perfil',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: colorScheme.onSurface),
            onPressed: () {
              // Acción para configuración
            },
          ),
        ],
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: colorScheme.surface,
        //   statusBarIconBrightness: Brightness.dark,
        // ),
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
                    color: colorScheme.secondary,
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
                            color: colorScheme.secondaryContainer.withAlpha((0.2 * 255).round()),
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
                      backgroundColor: colorScheme.surface,
                      child: CircleAvatar(
                        radius: 47,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: colorScheme.onSurfaceVariant,
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
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Miembro desde junio 2025',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
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
                      icon: Icon(Icons.edit, color: colorScheme.onSecondary, size: 18),
                      label: Text(
                        'Editar perfil',
                        style: TextStyle(
                          color: colorScheme.onSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.secondary,
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
                      icon: Icon(Icons.share, color: colorScheme.onSurfaceVariant, size: 18),
                      label: Text(
                        'Compartir',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: colorScheme.surface,
                        side: BorderSide(color: colorScheme.outline),
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
                color: colorScheme.surface,
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
                          color: colorScheme.onSurface,
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
                            color: colorScheme.secondaryContainer,
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
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          minHeight: 8,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.secondary,
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
              color: colorScheme.surface,
              child: TabBar(
                controller: _tabController,
                indicatorColor: colorScheme.secondaryContainer,
                labelColor: colorScheme.onSurface,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
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
              color: colorScheme.surface,
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
          selectedItemColor: colorScheme.secondaryContainer,
          unselectedItemColor: colorScheme.onSurfaceVariant,
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

  Widget _buildMedalla(BuildContext context, String nombre, bool obtenida) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: obtenida ? colorScheme.secondary : colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.star,
            color: obtenida ? colorScheme.onSecondary : colorScheme.onSurfaceVariant,
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
              color: colorScheme.onSurfaceVariant,
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
    final colorScheme = Theme.of(context).colorScheme;
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
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(context, Icons.location_on, 'Dirección', 'Av. Fernando Castillo Velasco'),
          const SizedBox(height: 16),
          _buildInfoItem(context, Icons.email, 'Email', 'Julian.gomezzz@email.com'),
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
                  color: colorScheme.onSurface,
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
                    color: colorScheme.secondaryContainer,
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
                  color: colorScheme.onSurface,
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
                    color: colorScheme.secondaryContainer,
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
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        'Contenido de Comunidad',
        style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildActividadTab() {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        'Contenido de Actividad',
        style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.surfaceContainerHighest,
          child: Icon(icon, color: colorScheme.onSurfaceVariant, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurface,
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
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
