[![Flutter](https://img.shields.io/badge/Flutter-3.22+-blue?logo=flutter)](https://flutter.dev) [![Dart](https://img.shields.io/badge/Dart-3.4+-blue?logo=dart)](https://dart.dev) ![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-blue) ![License](https://img.shields.io/badge/license-MIT-green) ![Version](https://img.shields.io/badge/version-1.0.0-blue)


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

## Isla
La última pestaña usa [fortnite-api.com](https://fortnite-api.com), que es gratuita y no pide llave.

- **Mapa:** isla actual, con zoom, y los puntos de interés.
- **Modos:** modos de juego que traen imagen. Las playlists internas de prueba no se muestran. Esta lista solo se descarga al abrir la sección.
- **Novedades:** cosméticos del último parche (Battle Royale, pistas, instrumentos, vehículos y LEGO).
- **Creador:** busca un código de Support-a-Creator. La petición se hace al pulsar buscar. Si el código no existe, la app lo dice en español.

## Arquitectura
Cada feature vive en `lib/features/<feature>` y se parte en tres capas:

| Capa | Responsabilidad |
| --- | --- |
| `data` | Llama al HTTP y traduce el JSON. |
| `domain` | Entidades, repositorio y caso de uso. El repositorio devuelve `Result`, no lanza excepciones de Dio. |
| `presentation` | Bloc y pantallas. La UI solo conoce `Failure`. |

`lib/core` concentra el cliente HTTP, el `.env`, el catálogo de errores y los widgets compartidos. `lib/app` registra las dependencias, el tema y las rutas. Si la API manda un enum desconocido, una fecha inválida o un campo vacío, la pantalla muestra un estado vacío o un reintento en lugar de cerrarse.

## Variables de entorno
Copia estos valores en `.env` en la raíz del proyecto. El token de fortniteapi.io es obligatorio para armas, noticias, tienda y jugadores. La URL pública no lleva token.

```sh
API_LIMITED_URL          = 'https://fortniteapi.io/v1'
API_LIMITED_URL_V2       = 'https://fortniteapi.io/v2'
ACCESS_TOKEN_LIMITED_API = 'TU-API-KEY'
PUBLIC_API_URL           = 'https://fortnite-api.com'
```

| Variable | Servicio |
| --- | --- |
| `API_LIMITED_URL` | Noticias (`/news`), armas (`/loot/list`) y jugadores (`/lookup`, `/stats`). |
| `API_LIMITED_URL_V2` | Tienda (`/shop`). |
| `ACCESS_TOKEN_LIMITED_API` | Header `Authorization` de fortniteapi.io. |
| `PUBLIC_API_URL` | Mapa (`/v1/map`), modos (`/v1/playlists`), novedades (`/v2/cosmetics/new`) y códigos de creador (`/v2/creatorcode`). |






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
| API key de fortniteapi.io (armas, noticias, tienda y jugadores) | https://fortniteapi.io |
| fortnite-api.com (mapa, modos, novedades y códigos; no pide llave) | https://fortnite-api.com |
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
- **fortniteapi.io** ([armas, noticias, tienda y jugadores](https://fortniteapi.io))
- **fortnite-api.com** ([mapa, modos, novedades y códigos de creador](https://fortnite-api.com))

Por favor, incluye un enlace a este repositorio en cualquier derivado o trabajo basado en este código.


