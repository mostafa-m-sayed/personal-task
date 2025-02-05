//
//  AppIconItem.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import Foundation
struct AppIconItem: Hashable {
    let id: UUID = UUID()
    let imageName: String
    let imageTitle: String
    var selected: Bool = false
}
