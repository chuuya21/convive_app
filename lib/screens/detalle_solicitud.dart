import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:convive_app/screens/enviar_mensaje.dart';

class DetalleSolicitudScreen extends StatefulWidget {
  const DetalleSolicitudScreen({super.key});

  @override
  State<DetalleSolicitudScreen> createState() => _DetalleSolicitudScreenState();
}

class _DetalleSolicitudScreenState extends State<DetalleSolicitudScreen> {


  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: cs.secondary, // Azul claro del header
      appBar: AppBar(
        backgroundColor: cs.secondary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: cs.secondaryContainer,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalles de la Solicitud',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Acción para menú de opciones
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Contenido principal
          Positioned.fill(
            top: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Perfil del usuario
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: cs.primary,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Usuario1',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Hace 5 horas | casa 202 C',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Descripción
                    const Text(
                      'Enseño crochet para que tu gatito nunca tenga sus patitas frías. Aprender a tejer ropa abrigada para este invierno, enseñar los fines de semana 🧶',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Imagen placeholder
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.pets,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Categorías
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
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
                            'Arte & Crochet',
                            style: TextStyle(
                              fontSize: 14,
                              color: cs.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
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
                            'Mascotas',
                            style: TextStyle(
                              fontSize: 14,
                              color: cs.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Botón "Aceptar Servicio"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Acción para aceptar servicio
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: const Text(
                          'Aceptar Servicio',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Botón "Dejar un mensaje"
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EnviarMensajeScreen(
                                nombreDestinatario: 'Usuario Ejemplo',
                                estadoDestinatario: 'En línea',
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.chat_bubble_outline, color: cs.primary),
                        label: Text(
                          'Dejar un mensaje',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: cs.primary,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: cs.primary,
                          side: BorderSide(color: cs.primary, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
