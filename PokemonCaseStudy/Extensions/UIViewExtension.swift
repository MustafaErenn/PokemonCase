//
//  UILabelExtension.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 10.12.2022.
//

import UIKit

extension UILabel {
    @IBInspectable public var localeKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton {
    @IBInspectable public var localeKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized,for: .normal);
        }
    }
}
