//
//  NavigationExtension.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/16/22.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
