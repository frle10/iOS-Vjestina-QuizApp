//
//  GradientViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 06.05.2021..
//
import UIKit

class GradientViewController: UIViewController {
    
    internal var router: AppRouterProtocol!
    
    private var gradientLayer: CAGradientLayer!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(hex: "#744FA3FF").cgColor, UIColor(hex: "#272F76FF").cgColor]
        gradientLayer.locations = [0.1, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
}
