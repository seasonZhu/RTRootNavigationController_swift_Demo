//
//  PushAndRemoveController.swift
//  RTRootNavigationController_swift_Demo
//
//  Created by season on 2019/11/8.
//  Copyright © 2019 season. All rights reserved.
//

import UIKit

class PushAndRemoveController: UIViewController {
    
    private lazy var switcher: UISwitch = {
        return UISwitch()
    }()
    
    /// 这个有问题
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        let button = UIButton(type: .custom)
        button.setTitle("Push and this vc will remove", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
        
        switcher.sizeToFit()
        switcher.isOn = true
        switcher.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        view.addSubview(switcher)
        
        let label = UILabel()
        label.text = "Push with Animated?"
        label.textColor = UIColor.black
        label.sizeToFit()
        label.center = CGPoint(x: view.center.x, y: view.center.y + 144)
        view.addSubview(label)
    }
    
    @objc
    func buttonAction(_ button: UIButton) {
        rt.navigationController?.pushViewController(viewController: NormalController(), animated: switcher.isOn, complete: { (_) in
            self.rt.navigationController?.removeViewController(controller: self)
        })
    }
    
    deinit {
        print("销毁了")
    }

}
