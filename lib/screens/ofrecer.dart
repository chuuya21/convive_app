import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:convive_app/screens/splashscreen.dart';
import 'package:convive_app/screens/conversaciones_vecinos.dart';
import 'package:convive_app/screens/login.dart';
// import 'package:convive_app/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0; // Home (HomeScreen)
  
  // Variables para el formulario de Pedir Servicio
  String? _tipoAyudaSeleccionado;
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _detallesController = TextEditingController();

  final List<Map<String, dynamic>> _tiposAyuda = [
    {
      'icon': Icons.pets,
      'label': 'Mascotas',
      'value': 'mascotas',
    },
    {
      'icon': Icons.local_shipping,
      'label': 'Mudanza',
      'value': 'mudanza',
    },
    {
      'icon': Icons.shield,
      'label': 'Guardia',
      'value': 'guardia',
    },
    {
      'icon': Icons.more_horiz,
      'label': 'Otros...',
      'value': 'otros',
    },
  ];
  
  @override
  void dispose() {
    _tituloController.dispose();
    _detallesController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == 0) {
      // Inicio → se queda en HomeScreen
      setState(() => _currentIndex = index);
    } else if (index == 1) {
      // Explorar → ProductsScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConversacionesVecinosScreen()),
      );
    } else if (index == 2) {
      // Chats → ConversacionesVecinosScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConversacionesVecinosScreen()),
      );
    } else if (index == 3) {
      // Mi Perfil → por ahora se queda
      setState(() => _currentIndex = index);
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  void _publicarSolicitud() {
    if (_tipoAyudaSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un tipo de ayuda'),
        ),
      );
      return;
    }

    if (_tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa un título'),
        ),
      );
      return;
    }

    if (_detallesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa los detalles'),
        ),
      );
      return;
    }

    // Aquí puedes agregar la lógica para publicar la solicitud en Firestore
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Solicitud publicada exitosamente'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Theme.of(context).colorScheme.primary,
  title: const Text(
    'Ofrecer Servicio',
    style: TextStyle(color: Colors.white),
  ),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout, color: Colors.white),
      onPressed: _signOut,
    ),
  ],
),

      backgroundColor: Colors.grey[50],
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _publicarSolicitud,
        child: const Icon(Icons.check),
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
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
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

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tarjeta de mensaje introductorio
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Azul claro
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A90E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '¡Comparte tus habilidades!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ayuda a tus vecinos ofreciendo tus servicios y habiludades. Juntos hacemos una comunidad más fuerte.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sección: Tipo de ayuda
          const Text(
            '¿Qué tipo de servicio ofreces? *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: _tiposAyuda.length,
            itemBuilder: (context, index) {
              final tipo = _tiposAyuda[index];
              final isSelected = _tipoAyudaSeleccionado == tipo['value'];

              return InkWell(
                onTap: () {
                  setState(() {
                    _tipoAyudaSeleccionado = tipo['value'];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFFF9800) // Naranja cuando está seleccionado
                          : const Color(0xFFFFB74D), // Naranja claro
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tipo['icon'] as IconData,
                        size: 40,
                        color: isSelected
                            ? const Color(0xFFFF9800)
                            : const Color(0xFFFFB74D),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tipo['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Campo: Título breve
          const Text(
            'Título de tu servicio*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(
              hintText: 'Ej: Hola vecinos! ofrezco paseos de perro...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Campo: Detalles
          const Text(
            'Describe tu servicio *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _detallesController,
            maxLines: 5,
            maxLength: 500,
            onChanged: (value) {
              setState(() {}); // Actualizar el contador
            },
            decoration: InputDecoration(
              hintText: 'Me ofrezco para pasear perros en el vecindario.',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 2),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Se específico pero breve',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '${_detallesController.text.length}/500',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sección: Tipo de ayuda
          const Text(
            '¿Qué tipo de servicio ofreces? *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: _tiposAyuda.length,
            itemBuilder: (context, index) {
              final tipo = _tiposAyuda[index];
              final isSelected = _tipoAyudaSeleccionado == tipo['value'];

              return InkWell(
                onTap: () {
                  setState(() {
                    _tipoAyudaSeleccionado = tipo['value'];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFFF9800) // Naranja cuando está seleccionado
                          : const Color(0xFFFFB74D), // Naranja claro
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tipo['icon'] as IconData,
                        size: 40,
                        color: isSelected
                            ? const Color(0xFFFF9800)
                            : const Color(0xFFFFB74D),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tipo['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Botón: Publicar Solicitud
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _publicarSolicitud,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800), // Naranja
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Publicar Solicitud',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Pantalla "Otros" aún no implementada')),
    );
  }
}