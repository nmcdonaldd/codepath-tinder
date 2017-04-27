//
//  ProfileViewController.swift
//  codepath-tinder
//
//  Created by Nick McDonald on 4/26/17.
//  Copyright © 2017 nickdonald. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    var imageData: UIImage?
    
    @IBOutlet weak var navBarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.profileImageView.contentMode = .scaleAspectFit
        self.navBarImageView.isUserInteractionEnabled = true
        self.navBarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNavBarTapped)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.profileImageView.image = imageData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onNavBarTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
