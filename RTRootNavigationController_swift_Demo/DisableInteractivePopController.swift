//
//  DisableInteractivePopController.swift
//  RTRootNavigationController_swift_Demo
//
//  Created by season on 2019/11/8.
//  Copyright © 2019 season. All rights reserved.
//

import UIKit

class DisableInteractivePopController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DisableInteractivePopController"
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true;
        rt.disableInteractivePop = true
        navigationController?.delegate = self
    }
    
    override func customBackItemWithTarget(target: Any, action: Selector) -> UIBarButtonItem? {
        let button = UIButton(type: .custom)
        button.setImage(UIImage (named: "back"), for: .normal)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
}

extension DisableInteractivePopController: UINavigationControllerDelegate {}
