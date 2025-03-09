# ✏️ Copykit – Aprende a Dibujar con Apple Pencil

**Copykit** es una aplicación para iOS diseñada para ayudar a los usuarios principiantes a mejorar sus habilidades de dibujo con el Apple Pencil. La app permite **calcar imágenes** precargadas, facilitando el aprendizaje y la práctica del trazo con herramientas intuitivas como lápiz, borrador y selector de colores.

## 🎨 Características principales

✅ **Dibuja sobre imágenes precargadas**: Importa imágenes desde tu galería o usa fotos tomadas con la cámara.

✅ **Herramientas de dibujo intuitivas**: Usa lápiz, borrador y personaliza el grosor y opacidad del trazo.

✅ **Selector de colores avanzado**: Escoge entre colores predefinidos o usa un selector de color personalizado.

✅ **Interfaz optimizada para Apple Pencil**: Compatible con trazos sensibles a la presión.

✅ **Guarda y comparte tus dibujos**: Exporta tu trabajo y guárdalo en tu galería.

## 📥 Instalación

Sigue estos pasos para clonar y ejecutar el proyecto en tu entorno de desarrollo:

1. Clona el repositorio:
    
    ```bash
    git clone <https://github.com/tu_usuario/copykit.git>
    
    ```
    
2. Abre el proyecto en **Xcode**.
3. Asegúrate de usar **iOS 14+** y **Swift 5**.
4. Ejecuta la aplicación en un simulador o en un dispositivo real con Apple Pencil.

## 📂 Estructura del código

```bash
📂 Copykit
├── 📂 Controllers
│   ├── HomeViewController.swift      # Lienzo principal para dibujar
│   ├── MainTabBarController.swift    # Barra de herramientas con lápiz, borrador y colores
│   ├── BrushViewController.swift     # Configuración del grosor y opacidad del trazo
│   ├── EraserViewController.swift    # Configuración del borrador
│   ├── ColorsViewController.swift    # Selector de colores
├── 📂 Models
│   ├── ActiveTool.swift              # Enum de herramientas activas
│   ├── BrushSettings.swift           # Configuración del pincel
│   ├── EraserSettings.swift          # Configuración del borrador
├── 📂 Views
│   ├── ColorCell.swift               # Vista para la selección de colores
├── AppDelegate.swift                  # Configuración de la app
├── SceneDelegate.swift                # Gestión del ciclo de vida de la app
```

## ⚙️ Tecnologías utilizadas

- 🛠 **Swift 5**
- 🖌 **PencilKit** – Para el lienzo de dibujo y herramientas avanzadas de Apple Pencil
- 🎨 **UIKit** – Para la interfaz de usuario y control de eventos
- 📷 **UIImagePickerController** – Para cargar imágenes desde la galería o cámara
- 🔔 **NotificationCenter** – Para gestionar eventos y actualizaciones en tiempo real

## 🎯 Objetivo del proyecto

Copykit está diseñado para **principiantes en el dibujo digital**, ofreciendo una herramienta sencilla e intuitiva para aprender la técnica de **calcar imágenes** usando Apple Pencil. Ideal para artistas en formación, estudiantes de arte o cualquier persona que quiera mejorar su precisión en el trazo.

## 📜 Licencia

Este proyecto está bajo la licencia **MIT**.
