//
//  NavigationbarHiddenController.swift
//  RTRootNavigationController_swift_Demo
//
//  Created by season on 2019/11/8.
//  Copyright © 2019 season. All rights reserved.
//

import UIKit

class NavigationbarHiddenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        let button1 = UIButton(type: .custom)
        button1.setTitle("Push", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.sizeToFit()
        button1.addTarget(self, action: #selector(button1Action(_:)), for: .touchUpInside)
        button1.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        view.addSubview(button1)
        
        let button2 = UIButton(type: .custom)
        button2.setTitle("Pop", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.sizeToFit()
        button2.addTarget(self, action: #selector(button2Action(_:)), for: .touchUpInside)
        button2.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        view.addSubview(button2)
    }
    
    @objc
    func button1Action(_ button: UIButton) {
        navigationController?.pushViewController(DisableInteractivePopController(), animated: true)
    }
    
    @objc
    func button2Action(_ button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}
