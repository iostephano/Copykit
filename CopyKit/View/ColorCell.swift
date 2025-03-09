//
//  ColorCell.swift
//  CopyKit
//
//  Created by Stephano Portella on 5/03/25.
//
import UIKit

class ColorCell: UICollectionViewCell {
    static let reuseIdentifier = "ColorCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = frame.size.width / 2
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with color: UIColor) {
        // Elimina subviews previos (por si la célula se reutiliza)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.backgroundColor = color
    }
    
    func configureAsCustom() {
        // Elimina subviews anteriores y configura la célula para mostrar un ícono de "Add"
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.backgroundColor = .lightGray
        let plusLabel = UILabel(frame: contentView.bounds)
        plusLabel.text = "+"
        plusLabel.textAlignment = .center
        plusLabel.font = UIFont.systemFont(ofSize: 24)
        plusLabel.textColor = .white
        contentView.addSubview(plusLabel)
    }
}

