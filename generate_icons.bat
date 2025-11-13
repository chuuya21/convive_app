@echo off
echo ========================================
echo Generando iconos del launcher...
echo ========================================
echo.
echo Esto cambiara el icono de la app en la pantalla de inicio del telefono.
echo El splash screen (pantalla de carga) NO se modificara.
echo.
echo Ejecutando: flutter pub get
call flutter pub get
if %errorlevel% neq 0 (
    echo Error al ejecutar flutter pub get
    pause
    exit /b 1
)
echo.
echo Ejecutando: dart run flutter_launcher_icons
call dart run flutter_launcher_icons
if %errorlevel% neq 0 (
    echo Error al generar los iconos
    pause
    exit /b 1
)
echo.
echo ========================================
echo ¡Iconos generados exitosamente!
echo ========================================
echo.
echo Ahora necesitas reconstruir la app para ver los cambios:
echo - Para Android: flutter run
echo - Para iOS: flutter run
echo.
echo Nota: Si ves errores, verifica que la imagen assets/img/launcher_logo.png exista
echo y tenga un formato valido (PNG recomendado, minimo 1024x1024 pixeles).
echo.
pause

