//
//  HomeViewController.swift
//  CopyKit
//
//  Created by Stephano Portella on 5/03/25.
//
import UIKit
import PencilKit

class HomeViewController: UIViewController, PKCanvasViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var canvasView: PKCanvasView!
    var backgroundImageView: UIImageView!
    var topBar: UIView!
    var plusButton: UIButton!
    
    var activeTool: ActiveTool = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupBackgroundAndCanvas()
        setupTopBar()
        setupCanvasTapGesture()
        
        updateTool()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTool),
                                               name: NSNotification.Name("BrushSettingsChanged"),
                                               object: nil)
    }
    
    func setupBackgroundAndCanvas() {
        backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(named: "preloadedImage")
        view.addSubview(backgroundImageView)
        
        canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.delegate = self
        canvasView.backgroundColor = .clear
        canvasView.drawingPolicy = .anyInput
        view.addSubview(canvasView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTopBar() {
        topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .clear  
        view.addSubview(topBar)
        
        let newDesignButton = UIButton(type: .system)
        newDesignButton.setTitle("New", for: .normal)
        newDesignButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        newDesignButton.translatesAutoresizingMaskIntoConstraints = false
        newDesignButton.addTarget(self, action: #selector(newDesign), for: .touchUpInside)
        topBar.addSubview(newDesignButton)
        
        plusButton = UIButton(type: .system)
        plusButton.setTitle("Add", for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        topBar.addSubview(plusButton)
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteDrawing), for: .touchUpInside)
        topBar.addSubview(deleteButton)
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveDrawing), for: .touchUpInside)
        topBar.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 44),
            
            saveButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -16),
            saveButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -16),
            plusButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            newDesignButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -16),
            newDesignButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor),
            
            newDesignButton.leadingAnchor.constraint(greaterThanOrEqualTo: topBar.leadingAnchor, constant: 16)
        ])
    }
    
    func setupCanvasTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(canvasTapped))
        canvasView.addGestureRecognizer(tapGesture)
    }
    
    @objc func canvasTapped() {
        setActiveTool(.none)
    }
    
    @objc func loadImage() {
        let alert = UIAlertController(title: "Upload Image",
                                      message: "Select the source",
                                      preferredStyle: .actionSheet)
        if let popover = alert.popoverPresentationController {
            popover.sourceView = plusButton
            popover.sourceRect = plusButton.bounds
            popover.permittedArrowDirections = [.up, .down]
        }
        alert.addAction(UIAlertAction(title: "Galery", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func openPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            present(picker, animated: true)
        } else {
            let alert = UIAlertController(title: "Camera not available",
                                          message: "The camera could not be accessed",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage,
           let tintedImage = applyTemplateEffect(to: image) {
            backgroundImageView.image = tintedImage
        }
        picker.dismiss(animated: true)
    }
    
    @objc func saveDrawing() {
        let drawingImage = canvasView.drawing.image(from: canvasView.bounds,
                                                    scale: UIScreen.main.scale)
        UIImageWriteToSavedPhotosAlbum(drawingImage, self,
                                       #selector(image(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }
    
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: Error?,
                     contextInfo: UnsafeRawPointer) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "The drawing has been saved." : "Error saving drawing."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc func deleteDrawing() {
        canvasView.drawing = PKDrawing()
    }
    
    
    @objc func newDesign() {
        backgroundImageView.image = nil
        canvasView.drawing = PKDrawing()
    }
    
    @objc func updateTool() {
        if activeTool == .eraser {
            canvasView.tool = PKEraserTool(.vector)
        } else {
            canvasView.tool = PKInkingTool(.pen,
                                           color: BrushSettings.shared.color.withAlphaComponent(BrushSettings.shared.opacity),
                                           width: BrushSettings.shared.thickness)
        }
    }
    
    func setActiveTool(_ tool: ActiveTool) {
        activeTool = tool
        updateTool()
    }
    
    func applyTemplateEffect(to image: UIImage) -> UIImage? {
        let rect = CGRect(origin: .zero, size: image.size)
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: rect)
        
        UIColor(white: 1.0, alpha: 0.3).setFill()
        UIRectFillUsingBlendMode(rect, .sourceAtop)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
}
