[![Flutter](https://img.shields.io/badge/Flutter-v3.22-blue?logo=flutter)](https://flutter.dev) [![Dart](https://img.shields.io/badge/Dart-v2.13-blue?logo=dart)](https://dart.dev) ![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-blue) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen) [![Coverage](https://img.shields.io/badge/☂%20Coverage-96.1%25-yellowgreen)](#) ![License](https://img.shields.io/badge/license-MIT-green) ![Version](https://img.shields.io/badge/version-1.0.0-blue) ![Contributors](https://img.shields.io/badge/contributors-2-orange) ![Last Commit](https://img.shields.io/badge/last%20commit-August%202024-yellowgreen)


# Fortnite App - Flutter

![N|Solid](https://i.pinimg.com/564x/00/31/86/0031863213e6e3539a2cba5fbcf52a0b.jpg)

# ¡Que contiene esta app?
## Secciones de armas y Noticias.
- Explora una completa base de datos de todas las armas disponibles en Fortnite. Consulta sus estadísticas detalladas, incluyendo daño, velocidad de disparo y rango, para tomar las mejores decisiones durante el juego.
- Mantente al día con las últimas novedades de Fortnite. Recibe actualizaciones instantáneas sobre eventos, parches, cambios en el mapa y anuncios especiales directamente desde Epic Games.

![armas_home](https://github.com/user-attachments/assets/55e2fd26-e6fd-47bf-a473-04374cae3a64)  ![noticias](https://github.com/user-attachments/assets/e57bc7e4-b2fe-4dd8-95cc-5e1313e7fa36)  

## Tiendas de objetos y Estadisticas de Usuarios.
- Accede a la tienda de Fortnite para descubrir las últimas ofertas. Explora categorías como Ala Delta, envoltorios, gestos, lotes de objetos, música, picos, kits de Lego y skins, y mantente informado sobre los artículos destacados y próximos lanzamientos.
- Consulta las estadísticas detalladas de los jugadores en función de su modo de juego favorito. Compara tu rendimiento en solitario, dúo o escuadra, y mantente informado sobre tu progreso y mejoras.

![tienda](https://github.com/user-attachments/assets/0efb7ff6-2840-436c-b307-9a310233d00c) ![perfiles](https://github.com/user-attachments/assets/18e0c658-98e0-4f22-a8b2-ee3904c2b9c4)






## Requisitos
Para poder ejecutar el proyecto es necesario tener instalados ciertos requisitos:

| Requisito | Documentación |
| ------ | ------ |
| Dart `*` | https://dart.dev|
| Flutter`*` | https://docs.flutter.dev |
| Android Studio`*` | https://developer.android.com/studio?hl=es-419 |
| Chrome (develop for the web) | https://www.google.com/intl/es-419/chrome |
| Android toolchain - develop for Android devices | Misma documentación de android studio |
| Android SDK`*` | Misma documentación de android studio |
| Visual Studio`*` | https://visualstudio.microsoft.com/es |
| VS Code | https://code.visualstudio.com |
---


## Instalación

Fortinte Flutter App requiere minimo [Flutter 3.22.1 • channel stable •](https://github.com/flutter/flutter.git) o superior para ser ejecutado.
- Descargar el repositorio y extraer.
- Ubicarse en la carpeta principal.
- Instalar las dependencias.
```sh
flutter pub get
```
---

## Pruebas y Cobertura

### Pruebas Unitarias y de widgets
Este proyecto incluye un conjunto de pruebas unitarias para garantizar que las funciones y componentes se comporten según lo esperado.

#### Ejecución de Pruebas
Para ejecutar las pruebas unitarias, utiliza el siguiente comando:

```sh
flutter test
```
Ejecutará todas las pruebas definidas en la carpeta test del proyecto.
#### Cobertura de Código
El proyecto utiliza lcov para medir la cobertura de código. lcov genera un informe visual que muestra qué partes del código han sido cubiertas por las pruebas.

#### Pre - Requisitos
| Requisito | Documentación |
| ------ | ------ |
| Lcov (Observar los graficos)`*` |https://wiki.documentfoundation.org/Development/Lcov|
#### Lcov
Lcov es una herramienta utilizada para generar informes de cobertura de código en proyectos de software, incluido Flutter. La cobertura de código mide qué partes de tu código han sido ejecutadas durante las pruebas, ayudándote a identificar qué áreas no han sido probadas.

#### Instalar Lcov(Windows)

Utilizará el administrador de paquetes MS Windows Chocolatey para instalar el puerto de Windows de lcov. En su powershell *(ejecutada con permisos de administrador)* escribirá esto para instalarlo:
```sh
choco install lcov
```
Eso instalará dos cosas, la distribución perl de fresa y el conjunto de scripts perl lcov. Luego configure su variable GENTHML donde está el script perl genthml de lcov, que normalmente es esta ubicación:
```sh
C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml
```

#### Generación del Informe de Cobertura
Para generar el informe de cobertura, sigue estos pasos:

- Ejecuta las pruebas con el seguimiento de cobertura habilitado:
```sh
1) flutter test --coverage
```
- Genera un informe HTML de la cobertura:
```sh
2) genhtml coverage/lcov.info -o coverage/html
o tambien
2) perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage\html coverage\lcov.info
```

Estos pasos debieron crear una carpeta llamada COVERAGE dentro del proyecto, Abre el informe en tu navegador:
`CARPETA:  coverage/html/index.html`

Este proceso generará un informe detallado en formato HTML que podrás visualizar en tu navegador.
`Genera un informe HTML de la cobertura: EJEMPLO`

![N|Solid](https://cdn.hashnode.com/res/hashnode/image/upload/v1635788512156/rEc7Xofdp.png?auto=compress,format&format=webp)
---
## Dependencias utilizadas
Lista de dependencias utilizadas en el proyecto.
| Dependencia | Documentación |
| ------ | ------ |
| curved_navigation_bar: ^1.0.6 | https://pub.dev/packages/curved_navigation_bar|
| chips_choice: ^3.0.1: | https://pub.dev/packages/chips_choice/install|
| dio: ^5.6.0: | https://pub.dev/packages/dio/install|
| bloc: ^8.1.4: | https://pub.dev/packages/bloc|
| flutter_bloc: ^8.1.6: | https://pub.dev/packages/flutter_bloc/install|
| flutter_dotenv: ^5.1.0: | https://pub.dev/packages/flutter_dotenv|
| meta: ^1.12.0  | https://pub.dev/packages/meta|
| equatable: ^2.0.5 | https://pub.dev/packages/equatable|
| animate_do: ^3.3.4 | https://pub.dev/packages/animate_do|
---

## Licencia y Uso

Este proyecto está disponible públicamente bajo los términos de la licencia [MIT](LICENSE). Esto significa que eres libre de utilizar, modificar y distribuir el código en este repositorio para cualquier propósito, siempre y cuando se otorguen los créditos correspondientes a los autores.

**Créditos**: Si utilizas este proyecto en tu propio trabajo, debes mencionar a los autores originales:

- **Manuel Castro Barinas** ([@manuelcastrobarinas](https://github.com/manuelcastrobarinas))
- **ImShepo** ([@ImShepo](https://github.com/ImShepo))

Por favor, incluye un enlace a este repositorio en cualquier derivado o trabajo basado en este código.


