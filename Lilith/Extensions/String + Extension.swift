//
//  String + Extension.swift
//  Lilith
//
//  Created by GE-Developer
//

import Foundation

extension String {
    func asAttributedString() -> AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            return AttributedString(self)
        }
    }
}
