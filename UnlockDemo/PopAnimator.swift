//
//  PopAnimator.swift
//  UnlockDemo
//
//  Created by ZK-iOS on 2018/11/13.
//  Copyright © 2018年 ZK-iOS. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    // 动画持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 获得容器
        let containerView = transitionContext.containerView
        // 获得目标view
        // viewForKey 获取新的和老的控制器的view
        // viewControllerForKey 获取新的和老的控制器
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        
        containerView.addSubview(toView ?? UIView())
        toView?.alpha = 0.0
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            toView?.alpha = 1.0
        }) { (_) -> Void in
            // 转场动画完成
            transitionContext.completeTransition(true)
        }
    }
}
