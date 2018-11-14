//
//  VerifyViewController.swift
//  UnlockDemo
//
//  Created by ZK-iOS on 2018/11/13.
//  Copyright © 2018年 ZK-iOS. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {

    @IBOutlet weak var verifyBtnImg: UIButton!
    @IBOutlet weak var verifyBtnText: UIButton!
    
    var biometricsType: BiometricsType = .none
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        biometricsType = LocalAuthenticationService.justSupportBiometricsType()
        guard biometricsType != .none else {
            return
        }
        verifyBtnImg.setImage(biometricsType == .touchID ? #imageLiteral(resourceName: "img_touchid") : #imageLiteral(resourceName: "img_faceid"), for: .normal)
        verifyBtnText.setTitle("点击进行\(biometricsType == .touchID ? "指纹" : "面容")解锁", for: .normal)
        
        verifyAuthentication()
    }
    
    @IBAction func verifyBtnAction() {
        verifyAuthentication()
    }
    
    func verifyAuthentication() {
        LocalAuthenticationService.verifyAuthentication(with: biometricsType) { [weak self] in
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            mainVC.transitioningDelegate = self
            self?.present(mainVC, animated: true, completion: nil)
        }
    }
}

extension VerifyViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
