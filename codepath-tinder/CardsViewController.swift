//
//  ViewController.swift
//  codepath-tinder
//
//  Created by Nick McDonald on 4/26/17.
//  Copyright © 2017 nickdonald. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var navigationBarImageVIew: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardActionsImageView: UIImageView!
    private var cardInitialCenter: CGPoint!
    private var topDrag: Bool = true
    
    var imageTransition: BaseTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toProfileViewController)))
    }
    
    func toProfileViewController() {
        self.performSegue(withIdentifier: "toProfileVC", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cardDidPan(_ sender: UIPanGestureRecognizer) {
        let state = sender.state
        switch state {
        case .began:
            self.cardInitialCenter = self.cardImageView.center
            let location = sender.location(in: self.cardImageView)
            if location.y >= self.cardImageView.frame.height/2 {
                self.topDrag = false
            } else {
                self.topDrag = true
            }
        case .changed:
            let translation = sender.translation(in: self.view)
            let horizontalTranslation = translation.x
            let finalHorizontalTranslation = horizontalTranslation * (self.topDrag ? 1.0 : -1.0)
            self.cardImageView.center = CGPoint(x: self.cardInitialCenter.x + horizontalTranslation, y: self.cardInitialCenter.y)
            let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(Double(finalHorizontalTranslation/7.5) * Double.pi / 180))
            self.cardImageView.transform  = rotationTransform
        case .ended:
            let translation = sender.translation(in: self.view)
            let horizontalTranslation = translation.x
            if abs(horizontalTranslation) >= 80 {
                let newCenter = self.cardImageView.center
                // This means it is moving to the left
                var endFrame: CGRect
                if newCenter.x > self.cardInitialCenter.x {
                    endFrame = CGRect(x: self.view.frame.maxX, y: self.cardImageView.frame.origin.y, width: self.cardImageView.frame.width, height: self.cardImageView.frame.height)
                } else {
                    endFrame = CGRect(x: self.view.frame.minX - self.cardImageView.frame.width, y: self.cardImageView.frame.origin.y, width: self.cardImageView.frame.width, height: self.cardImageView.frame.height)
                }
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImageView.frame = endFrame
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: { 
                    self.cardImageView.transform = CGAffineTransform.identity
                    self.cardImageView.center = self.cardInitialCenter
                })
            }
        default:
            print("This shouldn't ever be printed!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        let destinationViewController = segue.destination as! ProfileViewController
        destinationViewController.imageData = self.cardImageView.image
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = .custom
        
        // Create a new instance of your fadeTransition.
        self.imageTransition = ImageTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        destinationViewController.transitioningDelegate = self.imageTransition
        
        // Adjust the transition duration. (seconds)
        self.imageTransition.duration = 1.0
    }
}

