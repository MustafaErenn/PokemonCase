//
//  StringExtensions.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 10.12.2022.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
