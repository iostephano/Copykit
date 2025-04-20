# Copykit – Learn to Draw with Apple Pencil

**Copykit** is an iOS application designed to help beginner users improve their drawing skills with the Apple Pencil. The app allows users to **trace preloaded images**, making it easier to learn and practice strokes with intuitive tools like pencil, eraser, and color picker.

## Key Features

- **Draw over preloaded images**: Import images from your gallery or use photos taken with the camera.
- **Intuitive drawing tools**: Use pencil, eraser, and customize stroke thickness and opacity.
- **Advanced color picker**: Choose from predefined colors or use a custom color selector.
- **Interface optimized for Apple Pencil**: Supports pressure-sensitive strokes.
- **Save and share your drawings**: Export your work and save it to your gallery.

## Installation

Follow these steps to clone and run the project in your development environment:

1. Clone the repository:
    
    ```bash
    git clone https://github.com/your_username/copykit.git
    ```
    
2. Open the project in **Xcode**.
3. Make sure you are using **iOS 14+** and **Swift 5**.
4. Run the app on a simulator or a real device with Apple Pencil.

## Code Structure

```bash
bash
CopiarEditar
📂 Copykit
├── 📂 Controllers
│   ├── HomeViewController.swift      # Main drawing canvas
│   ├── MainTabBarController.swift    # Toolbar with pencil, eraser, and color tools
│   ├── BrushViewController.swift     # Stroke thickness and opacity settings
│   ├── EraserViewController.swift    # Eraser settings
│   ├── ColorsViewController.swift    # Color picker
├── 📂 Models
│   ├── ActiveTool.swift              # Enum for active tools
│   ├── BrushSettings.swift           # Brush configuration
│   ├── EraserSettings.swift          # Eraser configuration
├── 📂 Views
│   ├── ColorCell.swift               # View for color selection
├── AppDelegate.swift                 # App setup
├── SceneDelegate.swift               # App lifecycle management

```

## Technologies Used

- **Swift 5**
- **PencilKit** – For the drawing canvas and Apple Pencil features
- **UIKit** – For user interface and event handling
- **UIImagePickerController** – For importing images from gallery or camera
- **NotificationCenter** – For managing real-time events and updates

## Project Goal

Copykit is designed for **digital drawing beginners**, offering a simple and intuitive tool to learn the technique of **tracing images** using Apple Pencil. Ideal for aspiring artists, art students, or anyone looking to improve their line precision.

## License

This project is licensed under the **MIT License**.
