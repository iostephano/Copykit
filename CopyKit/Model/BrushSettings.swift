//
//  BrushSettings.swift
//  CopyKit
//
//  Created by Stephano Portella on 5/03/25.
//
import UIKit

class BrushSettings {
    static let shared = BrushSettings()
    var thickness: CGFloat = 20.0
    var opacity: CGFloat = 1.0
    var color: UIColor = .black
    private init() {}
}
