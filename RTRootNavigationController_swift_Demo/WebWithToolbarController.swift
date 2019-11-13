//
//  WebWithToolbarController.swift
//  RTRootNavigationController_swift_Demo
//
//  Created by season on 2019/11/13.
//  Copyright © 2019 season. All rights reserved.
//

import UIKit
import WebKit

class WebWithToolbarController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 88))
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    private lazy var indicateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Site provided by:\n"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: MarqueeLabel = {
        let label = MarqueeLabel(frame: CGRect(x: 0, y: 0, width: 260, height: 24))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.type = .continuous
        label.speed = .rate(50)
        label.animationCurve = .easeInOut
        label.animationDelay = 2
        label.fadeLength = 5
        label.trailingBuffer = 20
        label.leadingBuffer = 0
        return label
    }()
    
    private lazy var hiddenToolbarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("H", for: .normal)
        button.addTarget(self, action: #selector(hiddenToobarAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinnerView = UIActivityIndicatorView(style: .medium)
        return spinnerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barTintColor = UIColor.systemPink
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.isTranslucent = false
        
        for gestureRecognizer in webView.gestureRecognizers ?? [] where gestureRecognizer is UIScreenEdgePanGestureRecognizer {
            rt.navigationController?.interactivePopGestureRecognizer?.require(toFail: gestureRecognizer)
            // 如果你使用的是系统的UINavigationController 直接如下使用
            //navigationController?.interactivePopGestureRecognizer?.require(toFail: gestureRecognizer)
        }
        
        view.addSubview(webView)
        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.delegate = self
        webView.scrollView.contentInset = .zero
        webView.insertSubview(indicateLabel, belowSubview: webView.scrollView)
        webView.addConstraints([
            NSLayoutConstraint(item: indicateLabel, attribute: .top, relatedBy: .equal, toItem: webView, attribute: .top, multiplier: 1.0, constant: 16),
            NSLayoutConstraint(item: indicateLabel, attribute: .centerX, relatedBy: .equal, toItem: webView, attribute: .centerX, multiplier: 1.0, constant: 0)
        ])
        
        navigationItem.rightBarButtonItems = [/*UIBarButtonItem(customView: hiddenToolbarButton),*/ UIBarButtonItem(customView: spinnerView)]
        
        setUpToolbar()
        
        webView.load(URLRequest(url: URL(string: "https://www.hao123.com")!))
    }
    
    private func setUpToolbar() {
        let backward = UIBarButtonItem(title: "←", style: .plain, target: self, action: #selector(onBackwardAction(_:)))
        backward.isEnabled = false
        
        let forward = UIBarButtonItem(title: "→", style: .plain, target: self, action: #selector(onForwardAction(_:)))
        forward.isEnabled = false
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefreshAction(_:)))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onShareAction(_:)))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [backward, space, forward, space, refresh, space, share]
    }
    
    override func customBackItemWithTarget(target: Any, action: Selector) -> UIBarButtonItem? {
        let button = UIButton(type: .custom)
        button.setImage(UIImage (named: "back"), for: .normal)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
}

//MARK:- 按钮的点击事件
extension WebWithToolbarController {
    @objc
    private func hiddenToobarAction(_ button: UIButton) {
        guard let navi = navigationController else {
            return
        }
        navi.setToolbarHidden(!navi.isToolbarHidden, animated: true)
        
        let title = navi.isToolbarHidden ? "S" : "H"
        button.setTitle(title, for: .normal)
    }
    
    @objc
    private func onBackwardAction(_ buttonItem: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc
    private func onForwardAction(_ buttonItem: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc
    private func onRefreshAction(_ buttonItem: UIBarButtonItem) {
        webView.reload()
    }
    
    @objc
    private func onShareAction(_ buttonItem: UIBarButtonItem) {
        print("点击了刷新")
    }
}

//MARK:- WKNavigationDelegate
extension WebWithToolbarController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinnerView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinnerView.stopAnimating()
        indicateLabel.text = "Site provided by:\n" + (webView.url?.host ?? "")
        titleLabel.text = webView.title
        //title = webView.title
        
        guard let toolbarItems = self.toolbarItems else {
            return
        }
        
        toolbarItems[0].isEnabled = webView.canGoBack
        toolbarItems[2].isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinnerView.stopAnimating()
    }
}

//MARK:- UIScrollViewDelegate 这个在监听中的取消请求的方法 可能会导致标题不能更新
extension WebWithToolbarController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 下面这个方法是取消所有的之前的请求,这个太可怕了 还是有针对性的进行取消
        // NSObject.cancelPreviousPerformRequests(withTarget: self)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(scrollViewDidScroll(_:)), object: nil)
        navigationController?.setToolbarHidden(true, animated: true)
        perform(#selector(scrollViewDidEndScrollingAnimation(_:)), with: scrollView, afterDelay: 0.1)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(scrollViewDidEndScrollingAnimation(_:)), object: nil)
        navigationController?.setToolbarHidden(false, animated: true)
    }

}
