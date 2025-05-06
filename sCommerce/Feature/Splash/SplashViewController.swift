//
//  SplashViewController.swift
//  sCommerce
//
//  Created by juni on 3/30/25.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
  
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  lottieAnimationView = .init(name: "SplashLottie")
        let animationView: LottieAnimationView = .init(name: "SplashLottie")
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.play { [weak self] _ in
            
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController = viewController // 루트 뷰 변경
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIImageView().image = SCImage.close
    }
}
