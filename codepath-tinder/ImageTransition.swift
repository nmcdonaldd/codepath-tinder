//
//  ImageTransition.swift
//  codepath-tinder
//
//  Created by Nick McDonald on 4/26/17.
//  Copyright © 2017 nickdonald. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        guard let toViewController = toViewController as? ProfileViewController, let fromViewController = fromViewController as? CardsViewController else {
            return
        }
        let currentVCViewFrame = fromViewController.cardImageView.frame
        let imageToVCViewFrame = toViewController.profileImageView.frame
        let containerImageView = UIImageView(frame: currentVCViewFrame)
        containerImageView.contentMode = .scaleAspectFit
        containerImageView.image = fromViewController.cardImageView.image
        containerView.addSubview(containerImageView)
        toViewController.profileImageView.alpha = 0.0
        toViewController.view.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
            containerImageView.frame = imageToVCViewFrame
        }) { (finished: Bool) -> Void in
            toViewController.profileImageView.alpha = 1.0
            containerImageView.removeFromSuperview()
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
