//
//  CustomShareNavigationController.swift
//  URLSharing
//
//  Created by Panagiotis Kanellidis on 8/7/20.
//  Copyright © 2020 Panagiotis Kanellidis. All rights reserved.
//

import Foundation
import SwiftUI

@objc(CustomShareNavigationController)
class CustomShareNavigationController: UINavigationController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.setViewControllers([CustomShareViewController()], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
