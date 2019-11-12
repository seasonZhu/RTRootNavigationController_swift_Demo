//
//  CustomNavigationBarController.swift
//  RTRootNavigationController_swift_Demo
//
//  Created by season on 2019/11/12.
//  Copyright © 2019 season. All rights reserved.
//

import UIKit

class CustomNavigationBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "CustomNavigationBarController"
    }

    override func customNavigationBar() -> AnyClass? {
        return CustomBar.classForCoder()
    }
}

class CustomBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        tintColor = UIColor.purple
        // 这个没有体现出来作用
        barTintColor = UIColor.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let bezierPaht = UIBezierPath(rect: rect)
        bezierPaht.lineWidth = 4
        UIColor.orange.setStroke()
        UIColor.white.setFill()
        bezierPaht.fill()
        bezierPaht.stroke()
    }
}
