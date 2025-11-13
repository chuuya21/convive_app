#!/bin/bash
echo "========================================"
echo "Generando iconos del launcher..."
echo "========================================"
echo ""
echo "Esto cambiará el icono de la app en la pantalla de inicio del teléfono."
echo "El splash screen (pantalla de carga) NO se modificará."
echo ""
echo "Ejecutando: flutter pub get"
flutter pub get
if [ $? -ne 0 ]; then
    echo "Error al ejecutar flutter pub get"
    exit 1
fi
echo ""
echo "Ejecutando: dart run flutter_launcher_icons"
dart run flutter_launcher_icons
if [ $? -ne 0 ]; then
    echo "Error al generar los iconos"
    exit 1
fi
echo ""
echo "========================================"
echo "¡Iconos generados exitosamente!"
echo "========================================"
echo ""
echo "Ahora necesitas reconstruir la app para ver los cambios:"
echo "- Para Android: flutter run"
echo "- Para iOS: flutter run"
echo ""
echo "Nota: Si ves errores, verifica que la imagen assets/img/launcher_logo.png exista"
echo "y tenga un formato válido (PNG recomendado, mínimo 1024x1024 píxeles)."

