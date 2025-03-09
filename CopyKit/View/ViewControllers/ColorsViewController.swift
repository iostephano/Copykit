//
//  ColorsViewController.swift
//  CopyKit
//
//  Created by Stephano Portella on 5/03/25.
//
import UIKit

class ColorsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    // Arreglo de colores fijos
    let fixedColors: [UIColor] = [
        .black, .darkGray, .gray, .lightGray,
        .red, .orange, .yellow, .green,
        .blue, .purple, .brown, .cyan,
        .magenta
    ]
    
    // Total de ítems: colores fijos + 1 para la opción personalizada
    var totalItems: Int {
        return fixedColors.count + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemSize: CGFloat = 40
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as! ColorCell
        
        // Si es un color fijo, se configura normalmente; de lo contrario, se muestra la opción personalizada
        if indexPath.item < fixedColors.count {
            cell.configure(with: fixedColors[indexPath.item])
        } else {
            cell.configureAsCustom()
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < fixedColors.count {
            // Se selecciona un color fijo
            let selectedColor = fixedColors[indexPath.item]
            BrushSettings.shared.color = selectedColor
            NotificationCenter.default.post(name: NSNotification.Name("BrushSettingsChanged"), object: nil)
            
            // Actualizar el ícono de la pestaña "Color" con el nuevo color
            if let tabBar = tabBarController?.tabBar, let colorsTab = tabBar.items?[3] {
                let newColorIcon = UIImage(systemName: "circle.fill")?
                    .withTintColor(selectedColor, renderingMode: .alwaysOriginal)
                colorsTab.image = newColorIcon
                colorsTab.selectedImage = newColorIcon
            }
            
            // Regresar automáticamente a la pestaña Home (canvas)
            tabBarController?.selectedIndex = 0
        } else {
            // Se abre el selector de color personalizado
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            present(colorPicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UIColorPickerViewControllerDelegate

extension ColorsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        BrushSettings.shared.color = selectedColor
        NotificationCenter.default.post(name: NSNotification.Name("BrushSettingsChanged"), object: nil)
        
        // Actualizar el ícono de la pestaña "Color" con el nuevo color
        if let tabBar = tabBarController?.tabBar, let colorsTab = tabBar.items?[3] {
            let newColorIcon = UIImage(systemName: "circle.fill")?
                .withTintColor(selectedColor, renderingMode: .alwaysOriginal)
            colorsTab.image = newColorIcon
            colorsTab.selectedImage = newColorIcon
        }
        
        // Cerrar el picker y regresar automáticamente a Home
        viewController.dismiss(animated: true) { [weak self] in
            self?.tabBarController?.selectedIndex = 0
        }
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        // Opcional: aquí puedes actualizar el color en tiempo real si lo deseas.
    }
}
