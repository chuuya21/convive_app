import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  final List<File> _imagenesSeleccionadas = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool _subiendoImagenes = false;
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

  Future<void> _seleccionarImagenes() async {
    if (!mounted) return;
    
    try {
      List<XFile> imagenes = [];
      
      // Intentar usar pickMultiImage
      try {
        imagenes = await _imagePicker.pickMultiImage();
      } catch (e) {
        // Si pickMultiImage no está disponible, usar pickImage
        final XFile? imagen = await _imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (imagen != null) {
          imagenes = [imagen];
        }
      }
      
      if (imagenes.isNotEmpty && mounted) {
        setState(() {
          _imagenesSeleccionadas.addAll(imagenes.map((xFile) => File(xFile.path)).toList());
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar imágenes: $e')),
        );
      }
    }
  }

  Future<List<String>> _subirImagenes() async {
    if (_imagenesSeleccionadas.isEmpty) {
      return [];
    }

    if (!mounted) return [];

    setState(() {
      _subiendoImagenes = true;
    });

    final List<String> urls = [];
    
    try {
      final storage = FirebaseStorage.instance;
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid ?? 'anonymous';

      for (int i = 0; i < _imagenesSeleccionadas.length; i++) {
        final imagen = _imagenesSeleccionadas[i];
        
        // Verificar que el archivo existe
        if (!await imagen.exists()) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('El archivo de imagen ${i + 1} no existe')),
            );
          }
          continue;
        }

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final nombreArchivo = 'solicitudes/$userId/${timestamp}_$i.jpg';
        
        try {
          final ref = storage.ref(nombreArchivo);
          
          // Subir el archivo con metadata
          final uploadTask = ref.putFile(
            imagen,
            SettableMetadata(
              contentType: 'image/jpeg',
              customMetadata: {
                'uploadedBy': userId,
                'uploadedAt': DateTime.now().toIso8601String(),
              },
            ),
          );

          // Esperar a que termine la subida
          final snapshot = await uploadTask;
          
          // Verificar que la subida fue exitosa
          if (snapshot.state == TaskState.success) {
            // Usar la referencia del snapshot para obtener la URL
            final url = await snapshot.ref.getDownloadURL();
            urls.add(url);
          } else {
            throw Exception('Error al subir la imagen: ${snapshot.state}');
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al subir imagen ${i + 1}: $e')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error general al subir imágenes: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _subiendoImagenes = false;
        });
      }
    }

    return urls;
  }

  void _eliminarImagen(int index) {
    if (!mounted) return;
    setState(() {
      _imagenesSeleccionadas.removeAt(index);
    });
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
      // Subir imágenes primero si hay alguna
      final List<String> urlsImagenes = await _subirImagenes();

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
        'imagenes': urlsImagenes,
        'timestamp': FieldValue.serverTimestamp(),
        'estado': 'pendiente', // pendiente, en_proceso, completada
      });

      // Limpiar los campos después de guardar
      setState(() {
        _tipoAyudaSeleccionado = null;
        _tituloController.clear();
        _detallesController.clear();
        _imagenesSeleccionadas.clear();
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
        backgroundColor: cs.secondary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Solicitar Servicio', style: TextStyle(color: Colors.white)),
        
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
          
          const SizedBox(height: 8),
          // Botón para seleccionar imágenes
          OutlinedButton.icon(
            onPressed: _subiendoImagenes ? null : _seleccionarImagenes,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Agregar imagen'),
            style: OutlinedButton.styleFrom(
              foregroundColor: cs.secondary,
              side: BorderSide(color: cs.secondary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          // Mostrar imágenes seleccionadas
          if (_imagenesSeleccionadas.isNotEmpty)
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imagenesSeleccionadas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(_imagenesSeleccionadas[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.close, size: 16, color: Colors.white),
                              onPressed: () => _eliminarImagen(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 24),
          
          const SizedBox(height: 24),

          const SizedBox(height: 32),

          // Botón: Publicar Solicitud
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: (_isFormValid() && !_subiendoImagenes) ? _publicarSolicitud : null,
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
              child: _subiendoImagenes
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Subiendo imágenes...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Row(
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
