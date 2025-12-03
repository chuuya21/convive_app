import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:convive_app/screens/home.dart';

class EnviarSolicitudScreen extends StatefulWidget {
  const EnviarSolicitudScreen({super.key});

  @override
  State<EnviarSolicitudScreen> createState() => _EnviarSolicitudScreenState();
}

class _EnviarSolicitudScreenState extends State<EnviarSolicitudScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Variables para el formulario de Pedir Servicio
  String? _tipoAyudaSeleccionado;
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _detallesController = TextEditingController();
  // bool _esUrgente = false;

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
  void initState() {
    super.initState();
    // Agregar listeners para actualizar el estado cuando cambien los campos
    _tituloController.addListener(_updateFormState);
    _detallesController.addListener(_updateFormState);
  }

  @override
  void dispose() {
    _tituloController.removeListener(_updateFormState);
    _detallesController.removeListener(_updateFormState);
    _tituloController.dispose();
    _detallesController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _updateFormState() {
    setState(() {});
  }

  bool _isFormValid() {
    return _tipoAyudaSeleccionado != null &&
        _tituloController.text.trim().isNotEmpty &&
        _detallesController.text.trim().isNotEmpty;
  }

  

  void _publicarSolicitud() async {
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

    try {
      // Obtener el usuario actual
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid ?? '';
      final userEmail = user?.email ?? '';

      // Guardar la solicitud en Firestore
      await FirebaseFirestore.instance.collection('solicitudes').add({
        'tipoAyuda': _tipoAyudaSeleccionado,
        'titulo': _tituloController.text.trim(),
        'detalles': _detallesController.text.trim(),
        'userId': userId,
        'userEmail': userEmail,
        'timestamp': FieldValue.serverTimestamp(),
        'estado': 'pendiente', // pendiente, en_proceso, completada
      });

      // Limpiar los campos después de guardar
      setState(() {
        _tipoAyudaSeleccionado = null;
        _tituloController.clear();
        _detallesController.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solicitud publicada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
        
        
        
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al publicar la solicitud: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Solicitar Servicio', style: TextStyle(color: Colors.white)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const EnviarSolicitudScreen()),
                );
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar productos...',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: _buildBody(),
      
      

    );
  }

  Widget _buildBody() {
    final cs = Theme.of(context).colorScheme;
    
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
              color: cs.secondaryContainer, // Azul claro
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cs.secondary,
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
                        '¡Hola Vecino!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Estamos aquí para ayudarte. Cuéntanos qué necesitas y te conectaremos con vecinos dispuestos a echarte una mano.',
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
            '¿Qué tipo de ayuda necesitas? *',
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
                  _updateFormState();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isSelected
                          ? cs.primary // Naranja cuando está seleccionado
                          : cs.primaryContainer, // Naranja claro
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
                            ? cs.primary
                            : cs.primaryContainer,
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
            'Título breve de tu solicitud *',
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
              hintText: 'Ej: Necesito ayuda para pasear mi perro',
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
                borderSide: BorderSide(color: cs.secondary, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Campo: Detalles
          const Text(
            'Cuéntanos más detalles *',
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
              hintText: '¿Qué necesitas exactamente? ¿Cuando lo necesitas? ¿Dónde?',
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
                borderSide: BorderSide(color: cs.secondary, width: 2),
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

          // Toggle: Solicitud urgente (comentado — se movió a ofrecer.dart con lógica Firestore)
          /* 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Solicitud urgente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Switch(
                value: _esUrgente,
                onChanged: (value) {
                  setState(() {
                    _esUrgente = value;
                  });
                },
                activeColor: const Color(0xFF9C27B0), // Morado
              ),
            ],
          ),
          */
          const SizedBox(height: 32),

          // Botón: Publicar Solicitud
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isFormValid() ? _publicarSolicitud : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid() ? cs.primary : Colors.grey[400],
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                disabledForegroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: _isFormValid() ? 2 : 0,
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
